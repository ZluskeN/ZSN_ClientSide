if (isServer) then {
	if (isClass(configFile >> "CfgPatches" >> "ace_medical_engine")) then {
		["ace_unconscious", {
			params ["_unit", "_isUnconscious"];
			if (_isUnconscious) then {
				if (isPlayer _unit) then {
					remoteexec ["zsn_fnc_spectator", _unit];
				};
			};
		}] call CBA_fnc_addEventHandler;
	};
	addMissionEventHandler ["PreloadFinished", {
		if (isClass(configFile >> "CfgPatches" >> "RR_mapStuff") && ZSN_RemoveMaps) then {
			{player call zsn_fnc_removemaps;} remoteExecCall ["bis_fnc_call", 0, true];
		};
		remoteExecCall ["zsn_fnc_clearweapon", 0, true];
	}];
};