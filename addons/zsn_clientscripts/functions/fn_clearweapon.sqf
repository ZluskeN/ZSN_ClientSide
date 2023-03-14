params ["_unit","_weaponstate","_weapon","_gesture","_magazine"];

_weaponstate = weaponstate _unit;
_weapon = _weaponstate select 0;
_gesture = getText (configFile >> "CfgWeapons" >> _weapon >> "reloadAction");
_magazine = [_weaponstate select 3, _weaponstate select 4];
_isopenbolt = switch (_weapon) do {
	case (ZSN_PrimaryWeapon): {ZSN_PrimaryOpenBolt};
	case (ZSN_HandgunWeapon): {ZSN_HandgunOpenBolt};
	default {[_unit, _magazine select 0, _weapon] call zsn_fnc_isopenbolt};
};
if (_magazine select 0 != "") then {
	_unit playAction _gesture;
	if (_magazine select 1 > 0) then {[_unit, _magazine select 0, _magazine select 1, true] call CBA_fnc_addMagazine};
	switch (_weapon) do { 
		case (primaryweapon _unit): {
			_unit removePrimaryWeaponItem (_magazine select 0);
            if (isClass(configFile >> "CfgPatches" >> "ace_overheating")) then {playSound "ace_overheating_fixing_rifle"};
			if (ZSN_PrimaryChambered && !_isopenbolt) then {
				ZSN_PrimaryChambered = false;
				_unit addMagazine [_magazine select 0, 1]; 
//				if (_unit canAdd (_magazine select 0)) then {[_unit, _magazine select 0, 1, true] call CBA_fnc_addMagazine};
			};
		}; 
		case (handgunweapon _unit): {
			_unit removeHandgunItem (_magazine select 0);
            if (isClass(configFile >> "CfgPatches" >> "ace_overheating")) then {playSound "ace_overheating_fixing_pistol"};
			if (ZSN_HandgunChambered && !_isopenbolt) then {
				ZSN_HandgunChambered = false;
				_unit addMagazine [_magazine select 0, 1]; 
//				if (_unit canAdd (_magazine select 0)) then {[_unit, _magazine select 0, 1, true] call CBA_fnc_addMagazine};
			};
		}; 
	};
};
_magazine
