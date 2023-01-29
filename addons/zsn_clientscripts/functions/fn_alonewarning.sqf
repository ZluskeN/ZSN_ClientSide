params ["_unit"]; 
sleep 2; 
while {alive _unit} do { 
	_targets = getpos _unit nearEntities ["Allvehicles", ZSN_AloneWarning]; 
	_men = [];
	{if (_x iskindof "CAManBase") then {_men pushback _x} else {_vehicle = _x; {_men pushback _x} foreach (crew _vehicle)}} foreach _targets;
	_men deleteAt (_men find _unit); 
	_side = side group _unit;
	if (((_side != civilian && _side countside _men == 0) && (!(vehicle _unit iskindof "Air") && rank _unit in ["PRIVATE","CORPORAL","SERGEANT"])) && ZSN_AloneWarning > 0) then { 
		"normal" cutText ["<t color='#ff0000' font='PuristaBold' size='2'>You are isolated, make your way back to friendly lines!</t>", "PLAIN", 0.25, true, true]; 
		sleep 0.25; 
	} else {
		sleep 2; 
	};
};