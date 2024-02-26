if (isServer) then {

	zsn_ammotypes = [];

	addMissionEventHandler ["PlayerViewChanged", { 
		params ["_oldUnit", "_newUnit", "_vehicleIn","_oldCameraOn", "_newCameraOn", "_uav" ]; 
		if (unitIsUAV _newCameraOn) then {
			_goggles = goggles _oldCameraOn;
			_oldCameraOn unassignItem _goggles;
			_oldcameraon setVariable ["ZSN_Goggles", _goggles];
			_oldCameraOn addGoggles "G_Goggles_VR";
		};
		if (unitIsUAV _oldCameraOn) then {
			removeGoggles _newCameraOn; 
			_goggles = _newCameraOn getVariable "ZSN_Goggles";
			_newCameraOn assignItem _goggles;
		};
	}];

	if (isClass(configFile >> "CfgPatches" >> "wildfire_main") && isClass(configFile >> "CfgPatches" >> "ace_cookoff")) then {
		["ace_cookoff_cookOff", {_this call zsn_fnc_fireStarter }] call CBA_fnc_addEventHandler;
		["ace_cookoff_cookOffBox", {_this call zsn_fnc_fireStarter}] call CBA_fnc_addEventHandler;
	};

	["ace_loadCargo", {
	params ["_object", "_vehicle"];
		_massobject = getmass _object;
		_massvehicle = getmass _vehicle;
		_newmass = _massvehicle + _massobject;
		if (ZSN_AdjustMass) then {
			["ace_common_setMass", [_vehicle, _newmass]] call CBA_fnc_globalEvent;
		};
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
		_newmass = _massvehicle - _massobject;
		if (ZSN_AdjustMass) then {
			["ace_common_setMass", [_vehicle, _newmass]] call CBA_fnc_globalEvent;
		};
	}] call CBA_fnc_addEventHandler;

	["ace_common_setMass", {
		params ["_object", "_mass"];
		_object setvariable ["zsn_mass", _mass];
	}] call CBA_fnc_addEventHandler;

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
		if (count units (side player) > 2) then {
			{if (group _x != group player && (getText (configFile >> "CfgVehicles" >> (typeof _x) >> "vehicleClass") != "MenStory")) then {_units pushback _x}} foreach units (side player);
		};
	};
	_unit = selectrandom _units;
	_unit call zsn_fnc_womanizer;
};
