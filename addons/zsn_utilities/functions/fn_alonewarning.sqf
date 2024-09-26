params ["_unit"]; 

//sleep 2; 
//while {alive _unit} do { 
//	_targets = getpos _unit nearEntities ["Allvehicles", ZSN_AloneWarning]; 
//	_men = [];
//	{if (_x iskindof "CAManBase") then {_men pushback _x} else {_vehicle = _x; {_men pushback _x} foreach (crew _vehicle)}} foreach _targets;
//	_men deleteAt (_men find _unit); 
//	_side = side group _unit;
//	if ((_side countside _men == 0 && ZSN_AloneWarning > 0) && (_side != civilian && vehicle _unit == _unit)) then { 
//		"normal" cutText ["<t color='#ff0000' font='PuristaBold' size='2'>You are isolated, make your way back to friendly lines!</t>", "PLAIN", 0.25, true, true]; 
//		sleep 0.25; 
//	} else {
//		sleep 2; 
//	};
//};

[{
	params ["_unit"];
	_handle = [{
		params ["_unit"];
		_targets = getpos _unit nearEntities ["Allvehicles", ZSN_AloneWarning]; 
		_men = [];
		{if (_x iskindof "CAManBase") then {_men pushback _x} else {_vehicle = _x; {_men pushback _x} foreach (crew _vehicle)}} foreach _targets;
		_men deleteAt (_men find _unit); 
		_side = side group _unit;
		if ((_side countside _men == 0 && ZSN_AloneWarning > 0) && (_side != civilian && vehicle _unit == _unit)) then { 
			"normal" cutText ["<t color='#ff0000' font='PuristaBold' size='2'>You are isolated, make your way back to friendly lines!</t>", "PLAIN", 0.5, true, true]; 
		};
	}, 0.5, _unit] call CBA_fnc_addPerFrameHandler;
	
	_unit setVariable ["zsn_alonehandler", _handle];
	_unit addEventHandler ["Killed", {
		params ["_unit", "_killer", "_instigator", "_useEffects"];
		_handle = _unit getVariable "zsn_alonehandler";
		[_handle] call CBA_fnc_removePerFrameHandler;
	}];

	//[{!(alive (_this select 0))}, {(_this select 1) call CBA_fnc_deletePerFrameHandlerObject}, [_unit,_handle]] call CBA_fnc_waitUntilAndExecute;
}, _unit, 2] call CBA_fnc_waitAndExecute;