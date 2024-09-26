params ["_unit"];
_arr = getArray (configFile >> "CfgVehicles" >> typeof _unit >> "identitytypes");
if ("Head_Euro" in _arr) then {
	_unit setAnimSpeedCoef 2;
	_unit selectWeapon handgunWeapon _unit; 
	_unit playmove "Acts_Executioner_Squat"; 
	_unit playmove "Acts_Executioner_ToPistol";
	[{_this setAnimSpeedCoef 8}, ["_unit"], 2] call CBA_fnc_waitAndExecute;
//	sleep 2;
//	_unit setAnimSpeedCoef 8;
	[{_this setAnimSpeedCoef 0}, ["_unit"], 1] call CBA_fnc_waitAndExecute;
//	sleep 1;
//	_unit setAnimSpeedCoef 0;
	if (isplayer _unit && hasInterface) then {
		findDisplay 46 displayAddEventHandler ["KeyDown", "
			player setAnimSpeedCoef 2;
			[{animationstate _this != 'acts_executioner_squat'}, {_this setAnimSpeedCoef 1}, [player]] call CBA_fnc_waitUntilAndExecute;
		"];
	} else {
		_unit setAnimSpeedCoef 2;
		[{animationstate _unit != "acts_executioner_squat"}, {_this setAnimSpeedCoef 1}, ["_unit"]] call CBA_fnc_waitUntilAndExecute;
//		waituntil {animationstate _unit != "acts_executioner_squat"};
//		_unit setAnimSpeedCoef 1;
	};
};