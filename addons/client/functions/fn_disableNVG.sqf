_day = sunOrMoon == 1;
{
	_x disableNVGEquipment _day;
	_x disableTIEquipment _day;
} foreach vehicles;
waituntil {
	sleep 60;
	_newday = sunOrMoon == 1;
	_newday != _day
};
if (ZSN_DisableTI) then {[] spawn zsn_fnc_disableNVG};