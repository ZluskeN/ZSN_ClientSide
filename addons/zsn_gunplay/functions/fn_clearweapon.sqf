params ["_unit","_weaponstate","_weapon","_gesture","_magazine"];

_weaponstate = weaponstate _unit;
_weapon = _weaponstate select 0;
_muzzle = _weaponstate select 1;
_magazine = [_weaponstate select 3, _weaponstate select 4];
_primaryWeapon = _unit getVariable "ZSN_PrimaryWeapon";
_primaryOpenBolt = _unit getVariable "ZSN_primaryOpenBolt";
_primaryChambered = _unit getVariable "ZSN_PrimaryChambered";
_handgunWeapon = _unit getVariable "ZSN_handgunWeapon";
_handgunOpenBolt = _unit getVariable "ZSN_HandgunOpenBolt";
_handgunChambered = _unit getVariable "ZSN_HandgunChambered";
[_unit, _weapon, _muzzle] call ace_common_fnc_unloadUnitWeapon;
if (_weapon == _muzzle) then {
	switch (_weapon) do {
		case (primaryweapon _unit): {
			if (_weapon == _primaryWeapon) then {
				if (!_primaryOpenBolt && _primaryChambered) then {
					if (_magazine select 0 == "") then {
						_magazine = getArray (configFile >> "CfgWeapons" >> _weapon >> "magazines") select 0;
						_unit addMagazine [_magazine, 1]; 
					} else {
						_unit addMagazine [_magazine select 0, 1]; 
					};
					_unit setVariable ["ZSN_PrimaryChambered", false];
				};
			} else {
				_isopenbolt = [_unit, _magazine select 0, _weapon] call zsn_fnc_isopenbolt;
				if (!_isopenbolt && (_magazine select 0 != "" && _magazine select 1 > 0)) then {
					_unit addMagazine [_magazine select 0, 1]; 
				};
				_unit setVariable ["ZSN_PrimaryChambered", false];
			};
		};
		case (handgunweapon _unit): {
			if (_weapon == _handgunWeapon) then {
				if (!_handgunOpenBolt && _handgunChambered) then {
					if (_magazine select 0 == "") then {
						_magazine = getArray (configFile >> "CfgWeapons" >> _weapon >> "magazines") select 0;
						_unit addMagazine [_magazine, 1]; 
					} else {
						_unit addMagazine [_magazine select 0, 1]; 
					};
					_unit setVariable ["ZSN_HandgunChambered", false];
				};
			} else {
				_isopenbolt = [_unit, _magazine select 0, _weapon] call zsn_fnc_isopenbolt;
				if (!_isopenbolt && (_magazine select 0 != "" && _magazine select 1 > 0)) then {
					_unit addMagazine [_magazine select 0, 1]; 
				};
				_unit setVariable ["ZSN_HandgunChambered", false];
			};
		};
	}; 
};
_magazine
