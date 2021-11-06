params ["_unit"];
if (random 1 < ZSN_Wildfire) then {
	_grp = createGroup sideLogic; 
	"wildfire_main_Module_StartFire" createUnit [ 
		getPos _unit, 
		_grp, 
		"this setVariable ['BIS_fnc_initModules_disableAutoActivation', false, true];" 
	];
};