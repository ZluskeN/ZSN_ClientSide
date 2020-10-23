Params ["_unit"];
_unit addEventHandler["FiredMan", {
	_unit = _this select 0; // Get the unit who fired
	_magazine = (weaponState _unit) select 3;
	_capacity = getNumber (configFile >> "CfgMagazines" >> _magazine >> "Count");
	_numOfBullets = (weaponState _unit) select 4; // Get the amount of bullets left in the magazine
	if (_numOfBullets == 0) then {
		if (_unit ammo handgunweapon _unit > 1) then {
			if (((getpos (_unit findNearestEnemy getpos _unit)) distance (getpos _unit)) < 50) then {
				if (ZSN_Autoswitch) then {
					_unit selectWeapon handgunWeapon _unit;
				};
			};
		};
	};
}];