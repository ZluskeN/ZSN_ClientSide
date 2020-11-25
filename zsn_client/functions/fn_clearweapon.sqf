if (hasinterface) then {
	if (ZSN_Clearweapon) then {
		if (currentWeapon player isKindOf ["Rifle_Base_F", configFile >> "CfgWeapons"]) then {
			_magtype = currentmagazine player;  
			if (player canAdd _magtype) then {
				player addmagazine _magtype;
				player removePrimaryWeaponItem _magtype;
			};
		};
	};
};