private _unit = _this select 0;
_threshold = ZSN_MGstanceThreshold;
_inertia = getNumber (configFile >> "CfgWeapons" >> primaryweapon _unit >> "inertia");
if (_inertia >= _threshold && !gunloopinit) then { 
	gunloopinit = true;
	waituntil {stance _unit == "STAND"}; 
	_unit playAction "toMachinegun"; 
	waituntil {stance _unit != "STAND"}; 
	gunloopinit = false;
	[_unit, gunloopinit] spawn zsn_fnc_mgstance; 
}; 