params ["_unit"];
if (isClass(configFile >> "CfgPatches" >> "gm_core_animations")) then {
	zsn_gunloopinit = false;
	_unit addEventHandler ["InventoryClosed", { 
		private _unit = _this select 0;
		[_unit] spawn zsn_fnc_mgstance;
	}];
	[_unit] spawn zsn_fnc_mgstance;
};
	
if (hasinterface) then {
	[_unit] call zsn_fnc_autoSwitch;
};