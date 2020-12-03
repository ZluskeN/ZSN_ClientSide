private _unit = _this select 0;
private _threshold = ZSN_MGstanceThreshold;
private _inertia = getNumber (configFile >> "CfgWeapons" >> primaryweapon _unit >> "inertia");
if (_inertia >= _threshold && !zsn_gunloopinit) then { 
	zsn_gunloopinit = true;
	waituntil {(stance _unit == "STAND") && (currentweapon _unit == primaryweapon _unit)}; 
	_unit playAction "toMachinegun"; 
	waituntil {(stance _unit != "STAND") OR (currentweapon _unit != primaryweapon _unit)}; 
	zsn_gunloopinit = false;
	[_unit] spawn zsn_fnc_mgstance; 
}; 