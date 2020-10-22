private _unit = _this select 0;
if (isPlayer _unit) then {
	if (ZSN_Clearweapon) then {
		if (currentWeapon _unit isKindOf ["Rifle_Base_F", configFile >> "CfgWeapons"]) then {
			_magtype = currentmagazine _unit;  
			if (_unit canAdd _magtype) then {
				_unit addmagazine _magtype;
				_unit removePrimaryWeaponItem _magtype;
			};
		};
	};
	if (ZSN_Autoswitch) then {
		[_unit] call zsn_fnc_autoSwitch;
	};
};
if (isClass(configFile >> "CfgPatches" >> "gm_core_animations")) then {
	gunloopinit = false;
	_unit addEventHandler ["InventoryClosed", { 
		private _unit = _this select 0;
		[_unit, gunloopinit] spawn zsn_fnc_mgstance;
	}];
	[_unit, gunloopinit] spawn zsn_fnc_mgstance;
};
if (ZSN_RemoveMaps) then  {
	if (isClass(configFile >> "CfgPatches" >> "RR_mapStuff")) then {
		if (leader _unit != _unit) then {
			_unit unassignItem "itemMap"; 
			_unit removeitem "itemMap";
		};
	};
};