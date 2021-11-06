params ["_unit"];

if (isClass(configFile >> "CfgPatches" >> "dzn_MG_Tripod") && ZSN_AddTripod) then {_unit call zsn_fnc_addtripod};

if (leader _unit != _unit) then {
	_unit setUnitCombatMode ZSN_CombatMode;
	if (isClass(configFile >> "CfgPatches" >> "grad_trenches_main") && ZSN_AddShovel) then { 
		if (!("ACE_EntrenchingTool" in items _unit)) then {_unit addItem "ACE_EntrenchingTool"};
	};
	if (isClass(configFile >> "CfgPatches" >> "RR_mapStuff") && ZSN_RemoveMaps) then {
		if (!(isPlayer _unit)) then {
			_unit unlinkItem "itemMap";
		} else {
			ZSN_missionstart = true;
			addMissionEventHandler ["PreloadFinished", {if (ZSN_missionstart) then {player unlinkItem "itemMap"; ZSN_missionstart = false;}}];
		};
	};
};

if (isPlayer _unit && hasinterface) then {

//	if (isClass(configFile >> "CfgPatches" >> "AGC") && ZSN_AGCPlayers) then {removeFromRemainsCollector [_unit]};

} else {

	_unit setUnitPosWeak ZSN_Unitpos;

	if (isClass(configFile >> "CfgPatches" >> "gm_core_animations")) then {
		_unit setvariable ["zsn_gunloopinit", false];
		[_unit] spawn zsn_fnc_mgstance;
	};

};