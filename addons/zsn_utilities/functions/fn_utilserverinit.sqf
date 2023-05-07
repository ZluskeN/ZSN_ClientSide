if (isServer) then {
	if (isClass(configFile >> "CfgPatches" >> "wildfire_main") && isClass(configFile >> "CfgPatches" >> "ace_cookoff")) then {
		["ace_cookoff_cookOff", {_this call zsn_fnc_fireStarter }] call CBA_fnc_addEventHandler;
		["ace_cookoff_cookOffBox", {_this call zsn_fnc_fireStarter}] call CBA_fnc_addEventHandler;
	};
};

["ace_interact_menu_newControllableObject", {
	params ["_type"];
	if (!(_type isKindOf "Tank")) exitWith {}; // lägg bara på handlingen i en vagn av den löst definerade kategorin "Tank"
	rund_kickAction = [
		"rund_KickAction", //namn
		"Chastise driver", //text
		"", //ikon
		{ //exekverad kod
			_ownerOfDriver = driver vehicle _player; 
			_ownerOfDriver remoteExec ["rund_fnc_kickimpact", _ownerOfDriver];
		},
		{_player isEqualTo commander vehicle _player} //Utvärdera om spelaren är vagnchef
	] call ace_interact_menu_fnc_createAction;		//Dela ut förmågan att utföra handlingen
	[_type, 1, ["ACE_SelfActions"], rund_kickAction, true] call ace_interact_menu_fnc_addActionToClass;
}] call CBA_fnc_addEventHandler;

if (!isMultiplayer) then {
	_units = [];
	if (count units player > 2) then {
		{if (_x != player && (getText (configFile >> "CfgVehicles" >> (typeof _x) >> "vehicleClass") != "MenStory")) then {_units pushback _x}} foreach units player;
	} else {
		{if (group _x != group player && (getText (configFile >> "CfgVehicles" >> (typeof _x) >> "vehicleClass") != "MenStory")) then {_units pushback _x}} foreach units (side player);
	};
	_unit = selectrandom _units;
	_unit call zsn_fnc_womanizer;
};
