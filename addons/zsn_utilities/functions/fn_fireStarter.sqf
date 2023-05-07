params ["_unit","_humidity","_grp"];
_humidity = if (missionnamespace getvariable "ace_weather_enabled") then {missionnamespace getvariable "ace_weather_currentHumidity"} else {if (humidity > 0) then {humidity} else {random 1}};
//if (random 1 < ZSN_Wildfire) then {
if (random 1 > _humidity && ZSN_Wildfire) then {
	_grp = createGroup sideLogic; 
	"wildfire_main_Module_StartFire" createUnit [ 
		getPos _unit, 
		_grp, 
		"this setVariable ['BIS_fnc_initModules_disableAutoActivation', false, true];" 
	];
};