if (isServer) then {
	remoteexec ["zsn_fnc_clearweapon", 0, true];
	addMissionEventHandler ["PreloadFinished", {
		{
			if (ZSN_RemoveMaps) then  {
				if (isClass(configFile >> "CfgPatches" >> "RR_mapStuff")) then {
					if (leader _x != _x) then {
						_x unlinkItem "itemMap";
					};
				};
			};
		} forEach allUnits;
	}];
	if (isClass(configFile >> "CfgPatches" >> "ace_medical_engine")) then {
		["ace_unconscious", {
			params ["_unit", "_isUnconscious"];
			if (_isUnconscious) then {
				_unit call zsn_fnc_dropweapon;
				if (isPlayer _unit) then {
					remoteexec ["zsn_fnc_spectator", _unit];
				};
			};
		}] call CBA_fnc_serverEvent;
	};
};