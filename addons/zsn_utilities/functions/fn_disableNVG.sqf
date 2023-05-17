switch (ZSN_DisableTI) do
{
	case "ON": {
		{
			_bool = false;
			_veh disableNVGEquipment _bool;
			_veh disableTIEquipment _bool;
		} foreach vehicles;
	};
	case "NIGHT": {
		{
			_parents = [configFile >> "CfgVehicles" >> typeof _x, true] call BIS_fnc_returnParents;
			if (count (_parents arrayintersect ZSN_TIWhitelist) == 0) then {
				_bool = sunOrMoon == 1;
				_x disableNVGEquipment _bool;
				_x disableTIEquipment _bool;
			};
		} foreach vehicles;
		sleep 10;
		[] spawn zsn_fnc_disableNVG;
	};
	case "OFF": {
		{
			_parents = [configFile >> "CfgVehicles" >> typeof _x, true] call BIS_fnc_returnParents;
			if (count (_parents arrayintersect ZSN_TIWhitelist) == 0) then {
				_bool = true;
				_veh disableNVGEquipment _bool;
				_veh disableTIEquipment _bool;
			};
		} foreach vehicles;
		sleep 10;
		[] spawn zsn_fnc_disableNVG;
	};
};