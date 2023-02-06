params ["_unit"];

_primaryweaponcleared = false;
_primaryweapon = primaryweapon _unit;
_primaryammo = _unit ammo _primaryweapon;
_primarymagazine = primaryWeaponMagazine _unit select 0;

if (ZSN_Clearweapon) then {
	if (_unit canAdd _primarymagazine && isNull objectParent _unit) then {
		_unit addmagazine [_primarymagazine, _primaryammo];
		_unit removePrimaryWeaponItem _primarymagazine;
		_primaryweaponcleared = true;
	} else {
		if (isClass(configFile >> "CfgPatches" >> "ace_safemode")) then {[_unit, _primaryweapon, _primaryweapon] call ace_safemode_fnc_lockSafety};
	};
};

if (ZSN_Chamberedgun) then {

	ZSN_PrimaryChambered = false;
	ZSN_HandgunChambered = false;
	
	_primarymagazine = if (_primaryammo == 0) then {getArray (configFile >> "CfgWeapons" >> _primaryweapon >> "magazines") select 0} else {_primarymagazine};
	_primaryisopenbolt = [_unit, _primarymagazine, _primaryweapon] call zsn_fnc_isopenbolt;
	if (!_primaryweaponcleared && !_primaryisopenbolt) then {
		_newcount = _primaryammo - 1;
		_unit setAmmo [_primaryweapon, _newcount];
		ZSN_PrimaryChambered = true;
	};

	_handgunweapon = handgunweapon _unit;
	_handgunammo = _unit ammo _handgunweapon;
	_handgunmagazine = handgunMagazine _unit select 0;
	
	_handgunmagazine = if (_handgunammo == 0) then {getArray (configFile >> "CfgWeapons" >> _handgunweapon >> "magazines") select 0} else {_handgunmagazine};
	_handgunisopenbolt = [_unit, _handgunmagazine, _handgunweapon] call zsn_fnc_isopenbolt;
	if (!_handgunisopenbolt) then {
		_newcount = _handgunammo - 1;
		_unit setAmmo [_handgunweapon, _newcount];
		ZSN_HandgunChambered = true;
	};

	ZSN_PrimaryWeapon = _primaryweapon;
	ZSN_HandgunWeapon = _handgunweapon;

	ZSN_PrimaryOpenBolt = _primaryisopenbolt;
	ZSN_HandgunOpenBolt = _handgunisopenbolt;

};