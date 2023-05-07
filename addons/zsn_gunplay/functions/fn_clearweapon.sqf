params ["_unit","_weaponstate","_weapon","_gesture","_magazine"];

_weaponstate = weaponstate _unit;
_weapon = _weaponstate select 0;
_muzzle = _weaponstate select 1;
_magazine = [_weaponstate select 3, _weaponstate select 4];
//_gesture = if (_weapon == _muzzle) then {
//	getText (configFile >> "CfgWeapons" >> _weapon >> "reloadAction");
//} else {
//	getText (configFile >> "CfgWeapons" >> _weapon >> _muzzle >> "reloadAction");
//};
//_unit playAction _gesture;
//if (_magazine select 1 > 0) then {[_unit, _magazine select 0, _magazine select 1, true] call CBA_fnc_addMagazine};
[_unit, _weapon, _muzzle] call ace_common_fnc_unloadUnitWeapon;
if (_weapon == _muzzle) then {
	switch (_weapon) do {
		case (primaryweapon _unit): {
	//		_unit removePrimaryWeaponItem (_magazine select 0);
	//		if (isClass(configFile >> "CfgPatches" >> "ace_overheating")) then {playSound "ace_overheating_fixing_rifle"};
			if (_weapon == ZSN_PrimaryWeapon) then {
				if (!ZSN_PrimaryOpenBolt && ZSN_PrimaryChambered) then {
					if (_magazine select 0 == "") then {
						_magazine = getArray (configFile >> "CfgWeapons" >> _weapon >> "magazines") select 0;
						_unit addMagazine [_magazine, 1]; 
					} else {
						_unit addMagazine [_magazine select 0, 1]; 
					};
					ZSN_PrimaryChambered = false;
				};
			} else {
				_isopenbolt = [_unit, _magazine select 0, _weapon] call zsn_fnc_isopenbolt;
				if (!_isopenbolt && (_magazine select 0 != "" && _magazine select 1 > 0)) then {
					_unit addMagazine [_magazine select 0, 1]; 
				};
				ZSN_PrimaryChambered = false;
			};
		};
		case (handgunweapon _unit): {
	//		_unit removeHandgunItem (_magazine select 0);
	//		if (isClass(configFile >> "CfgPatches" >> "ace_overheating")) then {playSound "ace_overheating_fixing_pistol"};
			if (_weapon == ZSN_HandgunWeapon) then {
				if (!ZSN_HandgunOpenBolt && ZSN_HandgunChambered) then {
					if (_magazine select 0 == "") then {
						_magazine = getArray (configFile >> "CfgWeapons" >> _weapon >> "magazines") select 0;
						_unit addMagazine [_magazine, 1]; 
					} else {
						_unit addMagazine [_magazine select 0, 1]; 
					};
					ZSN_HandgunChambered = false;
				};
			} else {
				_isopenbolt = [_unit, _magazine select 0, _weapon] call zsn_fnc_isopenbolt;
				if (!_isopenbolt && (_magazine select 0 != "" && _magazine select 1 > 0)) then {
					_unit addMagazine [_magazine select 0, 1]; 
				};
				ZSN_HandgunChambered = false;
			};
		};
	}; 
};
_magazine
