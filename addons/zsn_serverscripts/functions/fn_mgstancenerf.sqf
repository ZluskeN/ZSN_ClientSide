params ["_unit", "_weapon"];
if (alive _unit && !(isPlayer _unit && hasinterface)) then {
	private _inertia = getNumber (configFile >> "CfgWeapons" >> _weapon >> "inertia");
	private _gunloop = _unit getVariable "zsn_mgstancenerf";
	if (_inertia >= ZSN_MGstanceThreshold && _gunloop) then { 
		_unit setvariable ["zsn_mgstancenerf", false];
		waituntil {sleep 1; (stance _unit == "STAND") && (animationstate _unit splitString "_" select 0 != "gm")}; 
		_unit playAction "toMachinegun";
		waituntil {sleep 1; ((stance _unit != "STAND") OR (animationstate _unit splitString "_" select 0 == "gm")) OR (currentweapon _unit != _weapon)}; 
		_unit setCustomAimCoef 1;
		_unit setvariable ["zsn_mgstancenerf", true];
		[_unit, currentweapon _unit] spawn zsn_fnc_mgstancenerf;
	};
}; 