params ["_vehicle"];

[{
    params ["_args"];
    _args params ["_vehicle", "_lastRun"];
	private _delta = cba_missionTime - _lastRun;
	if (ZSN_G != 9.8) then {
		private _force = [0, 0, getMass _vehicle * _delta * (9.8 - ZSN_G)];
		_vehicle addForce [_force, getCenterOfMass _vehicle];
	};
	_args set [1, cba_missionTime];
}, 0, [_vehicle, cba_missionTime]] call CBA_fnc_addPerFrameHandler;

_vehicle addEventHandler ["Fired", {
	params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];
	if (_ammo != "") then {[(str side _unit), _ammo] remoteexeccall ["zsn_fnc_ammocounter",0,true]};
}];

_vehicle setvariable ["zsn_mass", getmass _vehicle];
{
	_mass = _vehicle getvariable "zsn_mass";
	_vehicle setvariable ["zsn_mass", _mass + 100];
} foreach crew _vehicle;

_vehicle addEventHandler ["GetIn", { 
	params ["_vehicle", "_role", "_unit", "_turret"]; 
	_massvehicle = _vehicle getvariable "zsn_mass";
	_newmass = _massvehicle + 100;
	if (ZSN_AdjustMass) then {
		["ace_common_setMass", [_vehicle, _newmass]] call CBA_fnc_globalEvent;
	};
}];

_vehicle addEventHandler ["GetOut", { 
	params ["_vehicle", "_role", "_unit", "_turret"]; 
	_massvehicle = _vehicle getvariable "zsn_mass";
	_newmass = _massvehicle - 100;
	if (ZSN_AdjustMass) then {
		["ace_common_setMass", [_vehicle, _newmass]] call CBA_fnc_globalEvent;
	};
}];

_vehicle spawn {
	params ["_vehicle"];
	while {alive _vehicle} do {
		_mass = _vehicle getvariable "zsn_mass";
		if (ZSN_AdjustMass && getmass _vehicle != _mass) then {
			["ace_common_setMass", [_vehicle, _mass]] call CBA_fnc_globalEvent;
		};
		sleep 10;
	};
};

_vehicle setfuel (fuel _vehicle * ZSN_Fuelmultiplier);
_vehicle spawn {
	params ["_vehicle"];
	while {alive _vehicle} do {
		_currentfuel = fuel _vehicle;
		if (_currentfuel > ZSN_Fuelmultiplier) then {
			_vehicle setfuel ZSN_Fuelmultiplier;
		};
		sleep 10;
	};
};
