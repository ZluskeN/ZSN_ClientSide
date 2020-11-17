if (isServer) then {
	addMissionEventHandler ["PreloadFinished", {
		private _headlessClients = entities "HeadlessClient_F";
		private _humanPlayers = allPlayers - _headlessClients;
		if (ZSN_Clearweapon) then {
			{
				if (currentWeapon _x isKindOf ["Rifle_Base_F", configFile >> "CfgWeapons"]) then {
					_magtype = currentmagazine _x;  
					if (_x canAdd _magtype) then {
						_x addmagazine _magtype;
						_x removePrimaryWeaponItem _magtype;
					};
				};
			};
		} foreach _humanPlayers;
		{
			if (ZSN_RemoveMaps) then  {
				if (isClass(configFile >> "CfgPatches" >> "RR_mapStuff")) then {
					if (leader _x != _x) then {
						_x unassignItem "itemMap";
					};
				};
			};
		} forEach allUnits;
	}];
};
