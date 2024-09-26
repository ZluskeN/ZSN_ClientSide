params ["_unit"];

_primaryweaponsafe = false;
_primaryweaponcleared = false;
_primaryweapon = primaryweapon _unit;
_primaryammo = _unit ammo _primaryweapon;
_primarymagazine = if (_primaryammo == 0) then {getArray (configFile >> "CfgWeapons" >> _primaryweapon >> "magazines") select 0} else {primaryWeaponMagazine _unit select 0};

if (ZSN_Clearweapon) then {
	if (_primaryammo > 0) then {
		if (_unit canAdd _primarymagazine && isNull objectParent _unit) then {
			_unit addmagazine [_primarymagazine, _primaryammo];
			_unit removePrimaryWeaponItem _primarymagazine;
			_primaryweaponcleared = true;
		} else {
			if (isClass(configFile >> "CfgPatches" >> "ace_safemode")) then {[_unit, _primaryweapon, _primaryweapon] call ace_safemode_fnc_lockSafety};
			_primaryweaponsafe = true;
		};
	} else {
		_primaryweaponcleared = true;
	};
};

_unit setVariable ["ZSN_PrimaryChambered", false];
_unit setVariable ["ZSN_HandgunChambered", false];

_primaryisopenbolt = [_unit, _primarymagazine, _primaryweapon] call zsn_fnc_isopenbolt;
if (!_primaryweaponcleared && !_primaryisopenbolt) then {
	if (_primaryammo > 0) then {
		_newcount = _primaryammo - 1;
		_unit setAmmo [_primaryweapon, _newcount];
		_unit setVariable ["ZSN_PrimaryChambered", true];
	};
};

_handgunweapon = handgunweapon _unit;
_handgunammo = _unit ammo _handgunweapon;
_handgunmagazine = if (_handgunammo == 0) then {getArray (configFile >> "CfgWeapons" >> _handgunweapon >> "magazines") select 0} else {handgunMagazine _unit select 0};

_handgunisopenbolt = [_unit, _handgunmagazine, _handgunweapon] call zsn_fnc_isopenbolt;
if (!_handgunisopenbolt && _handgunammo != 0) then {
	if (_handgunammo > 0) then {
		_newcount = _handgunammo - 1;
		_unit setAmmo [_handgunweapon, _newcount];
		_unit setVariable ["ZSN_HandgunChambered", true];
	};
};

_unit setVariable ["ZSN_PrimaryWeapon", _primaryweapon];
_unit setVariable ["ZSN_HandgunWeapon", _handgunweapon];

_unit setVariable ["ZSN_PrimaryOpenBolt", _primaryisopenbolt];
_unit setVariable ["ZSN_HandgunOpenBolt", _handgunisopenbolt];
