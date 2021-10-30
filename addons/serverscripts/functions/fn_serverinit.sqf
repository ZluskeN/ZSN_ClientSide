if (isServer) then {
	if (ZSN_DisableTI) then {[] spawn zsn_fnc_disableNVG};
	if (isClass(configFile >> "CfgPatches" >> "AGC") && ZSN_AGCPlayers) then {
		addMissionEventHandler ["EntityKilled", {
			params [["_unit",objNull,[objNull]]];
			if (_unit isEqualTo objNull) exitWith {};
			if (_unit isKindOf "man") then
			{
				if (isPlayer _unit) then
				{
					_unit setVariable ["AGC_GCdeathTime",time];
					if (_unit getVariable ["AGC_removeItems",true]) then
					{
						[_unit] remoteExecCall ["AGC_fnc_removeItems",_unit];
					};
					if !(_unit getVariable ["GCblackList", false]) then
					{
						AGC_GCdeadBodies pushBack _unit;
						[_unit] call AGC_fnc_getWeaponHolder;
					};
				};
				[_unit] call AGC_fnc_countDead;
			};
		}];
	};
};