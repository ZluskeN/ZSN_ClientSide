params ["_vehicle"];

_vehicle setfuel (fuel _vehicle * ZSN_Fuelmultiplier);
while {alive _vehicle} do {
	_currentfuel = fuel _vehicle;
	if (_currentfuel > ZSN_Fuelmultiplier) then {
		_vehicle setfuel ZSN_Fuelmultiplier;
	};
	sleep 10;
};
