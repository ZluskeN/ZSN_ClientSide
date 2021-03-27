private _unit = _this select 0;
if (alive _unit) then {
	private _inertia = getNumber (configFile >> "CfgWeapons" >> primaryweapon _unit >> "inertia");
	private _gunloop = _unit getVariable "zsn_gunloopinit";
	private _threshold = ZSN_MGstanceThreshold;
	private _time = random 3;
	if (_inertia >= _threshold && !_gunloop) then { 
		_unit setvariable ["zsn_gunloopinit", true];
		waituntil {sleep _time; (stance _unit == "STAND") && (currentweapon _unit == primaryweapon _unit)}; 
		_unit playAction "toMachinegun"; 
//		_unit enableStamina false;
		waituntil {sleep _time; (stance _unit != "STAND") OR (currentweapon _unit != primaryweapon _unit)}; 
		_unit setvariable ["zsn_gunloopinit", false];
//		_unit enableStamina true;
		[_unit] spawn zsn_fnc_mgstance; 
	}; 
}; 