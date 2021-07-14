	params ["_unit"];
	
	ZSN_PrimaryChambered = false;
	ZSN_HandgunChambered = false;
	
	_primaryweapon = primaryweapon _unit;
	_primaryammo = _unit ammo _primaryweapon;
	_primarymagazine = primaryWeaponMagazine _unit select 0;
	_isBelt = isNumber (configFile >> "CfgMagazines" >> _primarymagazine >> "ACE_isBelt") && {(getNumber (configFile >> "CfgMagazines" >> _primarymagazine >> "ACE_isBelt")) == 1};
	if (_primaryammo > 6 && !_isBelt) then {
		_newcount = _primaryammo - 1;
		_unit setAmmo [_primaryweapon, _newcount];
		ZSN_PrimaryChambered = true;
	};
	_handgunweapon = handgunweapon _unit;
	_handgunammo = _unit ammo _handgunweapon;
	_handgunmagazine = handgunMagazine _unit select 0;
	_isBelt = isNumber (configFile >> "CfgMagazines" >> _handgunmagazine >> "ACE_isBelt") && {(getNumber (configFile >> "CfgMagazines" >> _handgunmagazine >> "ACE_isBelt")) == 1};
	if (_handgunammo > 6 && !_isBelt) then {
		_newcount = _handgunammo - 1;
		_unit setAmmo [_handgunweapon, _newcount];
		ZSN_HandgunChambered = true;
	};

	_unit addEventHandler["Reloaded", {
		_unit = _this select 0;
		_weapon = _this select 1;
		_muzzle = _this select 2;
		_newmagtype = _this select 3 select 0;
		_newmagammo = _this select 3 select 1;
		_oldmagtype = _this select 4 select 0;
		_oldmagammo = _this select 4 select 1;
		_rounds = getNumber (configFile >> "CfgMagazines" >> _newmagtype >> "count");
		_isBelt = isNumber (configFile >> "CfgMagazines" >> _newmagtype >> "ACE_isBelt") && {(getNumber (configFile >> "CfgMagazines" >> _newmagtype >> "ACE_isBelt")) == 1};
		switch (_muzzle) do {
			case (primaryweapon _unit): {
				if (!ZSN_PrimaryChambered && (_rounds > 6 && !_isBelt)) then {
					if (count _this == 4) then {
						_newcount = _newmagammo - 1;
						_unit setAmmo [_muzzle, _newcount];
					} else {
						switch (_oldmagammo) do {
							case 1: {
								[_unit, _oldmagtype, 1] call CBA_fnc_removeMagazine;
							};
							case 0: {
								_newcount = _newmagammo - 1;
								_unit setAmmo [_muzzle, _newcount];
							};
						};
					};
					ZSN_PrimaryChambered = true;
				};
			};
			case (handgunweapon _unit): {
				if (!ZSN_HandgunChambered && (_rounds > 6 && !_isBelt)) then {
					if (count _this == 4) then {
						_newcount = _newmagammo - 1;
						_unit setAmmo [_muzzle, _newcount];
					} else {
						switch (_oldmagammo) do {
							case 1: {
								[_unit, _oldmagtype, 1] call CBA_fnc_removeMagazine;
							};
							case 0: {
								_newcount = _newmagammo - 1;
								_unit setAmmo [_muzzle, _newcount];
							};
						};
					};
					ZSN_HandgunChambered = true;
				};
			};
		};
	}];

	_unit addEventHandler["Fired", {
		_unit = _this select 0;
		_weapon = _this select 1;
		_muzzle = _this select 2;
		_numOfBullets = (weaponState _unit) select 4;
		_magtype = _this select 5;
		_chambered = switch (_muzzle) do {
			case (primaryweapon _unit): {ZSN_PrimaryChambered};
			case (handgunweapon _unit): {ZSN_HandgunChambered};
			default {false};
		};
		_rounds = getNumber (configFile >> "CfgMagazines" >> _magtype >> "count");
		_isBelt = isNumber (configFile >> "CfgMagazines" >> _magtype >> "ACE_isBelt") && {(getNumber (configFile >> "CfgMagazines" >> _magtype >> "ACE_isBelt")) == 1};
		if (_numOfBullets == 0) then {
			if (_chambered && (_rounds > 6 && !_isBelt)) then {
				_unit setAmmo [_muzzle, 1];
				_unit setWeaponReloadingTime [_unit, _muzzle, 1];
				switch (_muzzle) do {
					case (primaryweapon _unit): {ZSN_PrimaryChambered = false};
					case (handgunweapon _unit): {ZSN_HandgunChambered = false};
				};
			} else {
				if (ZSN_Autoswitch) then {
					if (_unit ammo handgunweapon _unit > 1 && handgunweapon _unit != "hgun_Pistol_Signal_F") then {
						if (((getpos (_unit findNearestEnemy getpos _unit)) distance (getpos _unit)) < 50) then {
							_unit selectWeapon handgunWeapon _unit;
						};
					};
				};
			};
		} else {
			switch (_muzzle) do {
				case (primaryweapon _unit): {ZSN_PrimaryChambered = true};
				case (handgunweapon _unit): {ZSN_HandgunChambered = true};
			};
		};
	}];
