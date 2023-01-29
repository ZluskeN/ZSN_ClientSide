if (ZSN_AllowRandomWeapon) then {
	private _unit = _this;
	{_unit removemagazines _x} forEach primaryWeaponMagazine _unit;
	_unit removeweapon primaryWeapon _unit;
	_weaponsarray = [];
	{if ((configName _x) isKindOf ["Rifle_Base_F", configFile >> "CfgWeapons"])   then {_weaponsarray pushback (configName _x)}} forEach ("getNumber (_x >> 'scope') > 1" configClasses (configfile >> "CfgWeapons"));
	_weapon = (_weaponsarray select floor random count _weaponsarray);
	_magarray = (getArray (configFile >> "CfgWeapons" >> _weapon >> "magazines"));
	_unit addWeapon _weapon;
	if (count _magarray > 0) then {
		_magazine = (_magarray select floor random count _magarray);
		_unit addprimaryweaponitem _magazine;
		_unit addmagazines [_magazine, 3];
	};

	{_unit removemagazines _x} forEach handgunMagazine _unit;
	_unit removeweapon handgunWeapon _unit;
	_weaponsarray = [];
	{if ((configName _x) isKindOf ["Pistol_Base_F", configFile >> "CfgWeapons"]) then {_weaponsarray pushback (configName _x)}} forEach ("getNumber (_x >> 'scope') > 1" configClasses (configfile >> "CfgWeapons"));
	_weapon = (_weaponsarray select floor random count _weaponsarray);
	_magarray = (getArray (configFile >> "CfgWeapons" >> _weapon >> "magazines"));
	_unit addWeapon _weapon;
	if (count _magarray > 0) then {
		_magazine = (_magarray select floor random count _magarray);
		_unit addHandgunItem _magazine;
		_unit addmagazines [_magazine, 3];
	};
};