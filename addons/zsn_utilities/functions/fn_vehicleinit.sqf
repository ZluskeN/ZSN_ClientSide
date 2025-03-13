params ["_vehicle"];

if (alive _vehicle) then {
	
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
		if (_ammo != "") then {[(str side _unit), _ammo] remoteexeccall ["zsn_fnc_ammocounter",0]};
	}];

	_vehicle setvariable ["zsn_mass", getmass _vehicle];
	{
		_mass = _vehicle getvariable "zsn_mass";
		_guymass = ((_x getVariable  ["ace_movement_totalload", loadAbs _x]) / 22.046) + 80;
		_vehicle setvariable ["zsn_mass", _mass + _guymass];
	} foreach crew _vehicle;

	_vehicle addEventHandler ["GetIn", { 
		params ["_vehicle", "_role", "_unit", "_turret"]; 
		_massvehicle = _vehicle getvariable "zsn_mass";
		_guymass = ((_unit getVariable ["ace_movement_totalload", loadAbs _unit]) / 22.046) + 80;
		_newmass = _massvehicle + _guymass;
		if (ZSN_AdjustMass) then {
			["ace_common_setMass", [_vehicle, _newmass]] call CBA_fnc_globalEvent;
		};
	}];

	_vehicle addEventHandler ["GetOut", { 
		params ["_vehicle", "_role", "_unit", "_turret"]; 
		_massvehicle = _vehicle getvariable "zsn_mass";
		_guymass = ((_unit getVariable ["ace_movement_totalload", loadAbs _unit]) / 22.046) + 80;
		_newmass = _massvehicle - _guymass;
		if (ZSN_AdjustMass) then {
			["ace_common_setMass", [_vehicle, _newmass]] call CBA_fnc_globalEvent;
		};
	}];

	_masshandle = [{
		params ["_vehicle"];
		_mass = _vehicle getvariable "zsn_mass";
		_cargomass = loadabs _vehicle / 22.046;
		_newmass = _mass + _cargomass;
		if (ZSN_AdjustMass && (alive _vehicle && getmass _vehicle != _newmass)) then {
			["ace_common_setMass", [_vehicle, _newmass]] call CBA_fnc_globalEvent;
		};
	}, 10, _vehicle] call CBA_fnc_addPerFrameHandler;
	_vehicle setVariable ["zsn_masshandler", _masshandle];
	_vehicle addEventHandler ["Killed", {
		params ["_unit", "_killer", "_instigator", "_useEffects"];
		_masshandle = _unit getVariable "zsn_masshandler";
		[_masshandle] call CBA_fnc_removePerFrameHandler;
	}];

	_type = typeof _vehicle;
	_side = getNumber (configFile >> "CfgVehicles" >> _type >> "side");
	_canister = if (_side == 3) then {selectrandom ["Land_CanisterFuel_Blue_F","Land_CanisterFuel_Red_F","Land_CanisterFuel_White_F"]} else {"Land_CanisterFuel_F"};
	[_canister, _vehicle] call ace_cargo_fnc_addCargoItem;
	_vehicle setFuelConsumptionCoef (1 / ZSN_Fuelmultiplier);

};

//_vehicle spawn {
//	params ["_vehicle"];
//	while {alive _vehicle} do {
//		_mass = _vehicle getvariable "zsn_mass";
//		if (ZSN_AdjustMass && getmass _vehicle != _mass) then {
//			["ace_common_setMass", [_vehicle, _mass]] call CBA_fnc_globalEvent;
//		};
//		sleep 10;
//	};
//};

//[{!(alive (_this select 0))}, {(_this select 1) call CBA_fnc_deletePerFrameHandlerObject}, [_vehicle,_masshandle]] call CBA_fnc_waitUntilAndExecute;

//_vehicle spawn {
//	params ["_vehicle"];
//	while {alive _vehicle} do {
//		_currentfuel = fuel _vehicle;
//		if (_currentfuel > ZSN_Fuelmultiplier) then {
//			_vehicle setfuel ZSN_Fuelmultiplier;
//		};
//		sleep 10;
//	};
//};

//_vehicle setfuel (fuel _vehicle * ZSN_Fuelmultiplier);
//_fuelhandle = [{(_this select 0) setfuel (fuel (_this select 0) * ZSN_Fuelmultiplier)}, 10, _vehicle] call CBA_fnc_addPerFrameHandler;
//_vehicle setVariable ["zsn_fuelhandler", _fuelhandle];
//_vehicle addEventHandler ["Killed", {
//	params ["_unit", "_killer", "_instigator", "_useEffects"];
//	_fuelhandle = _unit getVariable "zsn_fuelhandler";
//	_fuelhandle call CBA_fnc_deletePerFrameHandlerObject;
//}];
//[{!(alive (_this select 0))}, {(_this select 1) call CBA_fnc_deletePerFrameHandlerObject}, [_vehicle,_fuelhandle]] call CBA_fnc_waitUntilAndExecute;
