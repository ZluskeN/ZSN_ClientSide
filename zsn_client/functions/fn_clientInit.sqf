params ["_unit"];
_unit setUnitPosWeak "UP";
if (leader _unit != _unit) then {_unit setCombatMode "WHITE"};
if (isClass(configFile >> "CfgPatches" >> "gm_core_animations")) then {
	zsn_gunloopinit = false;
	_unit addEventHandler ["InventoryClosed", { 
		private _unit = _this select 0;
		[_unit] spawn zsn_fnc_mgstance;
	}];
	[_unit] spawn zsn_fnc_mgstance;
};
if (hasinterface) then {
	_unit addEventHandler["FiredMan", {
		_unit = _this select 0;
		_numOfBullets = (weaponState _unit) select 4; // Get the amount of bullets left in the magazine
		if (_numOfBullets == 0) then {
			if (ZSN_Autoswitch) then {
				if (_unit ammo handgunweapon _unit > 1) then {
					if (((getpos (_unit findNearestEnemy getpos _unit)) distance (getpos _unit)) < 50) then {
						_unit selectWeapon handgunWeapon _unit;
					};
				};
			};
		};
	}];
};