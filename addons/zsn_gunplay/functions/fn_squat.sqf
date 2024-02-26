params ["_unit"];
_arr = getArray (configFile >> "CfgVehicles" >> typeof _unit >> "identitytypes");
if ("Head_Euro" in _arr) then {
	_unit setAnimSpeedCoef 2;
	_unit selectWeapon handgunWeapon _unit; 
	_unit playmove "Acts_Executioner_Squat"; 
	_unit playmove "Acts_Executioner_ToPistol";
	sleep 2;
	_unit setAnimSpeedCoef 8;
	sleep 1;
	_unit setAnimSpeedCoef 0;
	if (isplayer _unit && hasInterface) then {
		findDisplay 46 displayAddEventHandler ["KeyDown", "player spawn {
			_this setAnimSpeedCoef 2;
			waituntil {animationstate _this != 'acts_executioner_squat'};
			_this setAnimSpeedCoef 1;
		};"];
	} else {
		_unit setAnimSpeedCoef 2;
		waituntil {animationstate _unit != "acts_executioner_squat"};
		_unit setAnimSpeedCoef 1;
	};
};