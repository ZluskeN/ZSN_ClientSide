["ace_loadCargo", {
	params ["_object", "_vehicle"];
	_massobject = getmass _object;
	_massvehicle = getmass _vehicle;
	["ace_common_setMass", [_vehicle, (_massvehicle + _massobject)]] call CBA_fnc_globalEvent;
}] call CBA_fnc_addEventHandler;
["ace_unloadCargo", {
	params ["_object", "_vehicle"];
	_massobject = if (typeName _object == "STRING") then {
		_obj = _object createvehicle [0,0,0];
		_mass = getmass _obj;
		deletevehicle _obj;
		_mass
	} else {
		getmass _object;
	};
	_massvehicle = getMass _vehicle;
	["ace_common_setMass", [_vehicle, (_massvehicle - _massobject)]] call CBA_fnc_globalEvent;
}] call CBA_fnc_addEventHandler;
["ace_common_setMass", {
	params ["_object", "_mass"];
	_object setvariable ["zsn_mass", _mass];
}] call CBA_fnc_addEventHandler;
{
	_vehicle = _x;
	_vehicle setvariable ["zsn_mass", getmass _vehicle];
	{
		_vehicle setvariable ["zsn_mass", getmass _vehicle + 100];
	} foreach crew _vehicle;
	_vehicle addEventHandler ["GetIn", { 
		params ["_vehicle", "_role", "_unit", "_turret"]; 
		_massvehicle = _vehicle getvariable "zsn_mass";
		["ace_common_setMass", [_vehicle, (_massvehicle + 100)]] call CBA_fnc_globalEvent;
	}];
	_vehicle addEventHandler ["GetOut", { 
		params ["_vehicle", "_role", "_unit", "_turret"]; 
		_massvehicle = _vehicle getvariable "zsn_mass";
		["ace_common_setMass", [_vehicle, (_massvehicle - 100)]] call CBA_fnc_globalEvent;
	}];
	_vehicle spawn {
		params ["_vehicle"];
		while {alive _vehicle} do {
			sleep 1;
			_mass = _vehicle getvariable "zsn_mass";
			if (getmass _vehicle != _mass) then {
				_vehicle setmass _mass;
			};
		};
	};
} foreach vehicles;