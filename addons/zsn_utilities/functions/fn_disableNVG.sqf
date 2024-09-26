_nvghandle = [{
	_bool = switch (ZSN_DisableTI) do {
		case "ON": {false};
		case "NIGHT": {sunOrMoon > 0};
		case "OFF": {true};
	};
	{
		_parents = [configFile >> "CfgVehicles" >> typeof _x, true] call BIS_fnc_returnParents;
		if (count (_parents arrayintersect ZSN_TIWhitelist) == 0) then {
			_x disableNVGEquipment _bool;
			_x disableTIEquipment _bool;
		};
	} foreach vehicles;
}, 10, []] call CBA_fnc_addPerFrameHandler;