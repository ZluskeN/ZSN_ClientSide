params ["_unit"];
if (currentWeapon _unit isKindOf ["Rifle_Base_F", configFile >> "CfgWeapons"]) then {
	_magtype = currentmagazine _unit;  
	if (_unit canAdd _magtype && isNull objectParent _unit) then {
		_unit addmagazine [_magtype, 999];
		_unit removePrimaryWeaponItem _magtype;
	};
};