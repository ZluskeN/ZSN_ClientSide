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
_oldbool = _bool;
waituntil {
	sleep 10;
	_newbool = switch (ZSN_DisableTI) do {
		case "ON": {false};
		case "NIGHT": {sunOrMoon > 0};
		case "OFF": {true};
	};
	_newbool != _oldbool
};
[] spawn zsn_fnc_disableNVG;