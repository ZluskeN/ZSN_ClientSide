switch (ZSN_DisableTI) do
{
	case "ON": {
		{
			_x disableNVGEquipment false;
			_x disableTIEquipment false;
		} foreach vehicles;
	};
	case "NIGHT": {
		_day = sunOrMoon == 1;
		{
			_x disableNVGEquipment _day;
			_x disableTIEquipment _day;
		} foreach vehicles;
	};
	case "OFF": {
		{
			_x disableNVGEquipment true;
			_x disableTIEquipment true;
		} foreach vehicles;
	};
};
sleep 1;
[] spawn zsn_fnc_disableNVG;