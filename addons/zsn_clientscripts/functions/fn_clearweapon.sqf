params ["_unit","_weaponstate","_weapon","_gesture","_magazine"];

_weaponstate = weaponstate _unit;
_weapon = _weaponstate select 0;
_gesture = getText (configFile >> "CfgWeapons" >> _weapon >> "reloadAction");
_magazine = [_weaponstate select 3, _weaponstate select 4];
if (_magazine select 0 != "") then {
	_unit playAction _gesture;
	[_unit, _magazine select 0, _magazine select 1, true] call CBA_fnc_addMagazine;
	switch (_weapon) do { 
		case (primaryweapon _unit): {
			_unit removePrimaryWeaponItem (_magazine select 0);
            if (isClass(configFile >> "CfgPatches" >> "ace_overheating")) then {playSound "ace_overheating_fixing_rifle"};
			if (ZSN_PrimaryChambered) then {
				ZSN_PrimaryChambered = false;
				if (_unit canAdd _magazine) then {[_unit, _magazine select 0, 1, true] call CBA_fnc_addMagazine};
			};
		}; 
		case (handgunweapon _unit): {
			_unit removeHandgunItem (_magazine select 0);
            if (isClass(configFile >> "CfgPatches" >> "ace_overheating")) then {playSound "ace_overheating_fixing_pistol"};
			if (ZSN_HandgunChambered) then {
				ZSN_HandgunChambered = false;
				if (_unit canAdd _magazine) then {[_unit, _magazine select 0, 1, true] call CBA_fnc_addMagazine};
			};
		}; 
	};
};
_magazine
