
["Crub_SpotSystem",	"CHECKBOX",	["Spot System","Spot targets using the revealTarget action (T by default)"],			"Crub's Legacy",True,	nil,{params ["_value"]; [_value] call crub_fnc_spotsystem},true] call CBA_fnc_addSetting;
["Crub_MapIntel",	"CHECKBOX",	["Team Map Intel","Displays group markers on the map that your team has intel about"],	"Crub's Legacy",True,	nil,{params ["_value"]; if (_value) then {[] call crub_fnc_mapintel}},false] call CBA_fnc_addSetting;
["Crub_NameTags",	"CHECKBOX",	["Team Name Tags","Shows names and ranks over friendly players"],						"Crub's Legacy",True,	nil,{params ["_value"]; [_value] spawn crub_fnc_nametags},true] call CBA_fnc_addSetting;
["Crub_MapIcons",	"CHECKBOX",	["Team Map Icons","Show map icons for players and their status"],						"Crub's Legacy",True,	nil,{params ["_value"]; [_value] spawn crub_fnc_mapicons},true] call CBA_fnc_addSetting;

["Crub_CivPresence","CHECKBOX",	["Civilian Presence","Automatically generate pedestrians and traffic on any map"],		"Crub's Legacy",False,	nil,{params ["_value"]; [_value] call crub_fnc_civpresence},true] call CBA_fnc_addSetting;
["Crub_ZombieSystem","CHECKBOX",["Zombie System","Simple Zombie System With Support for Enhanced Zeus Modules"],		"Crub's Legacy",False,	nil,{params ["_value"]; [_value] call crub_fnc_zombiesystem},true] call CBA_fnc_addSetting;
["Crub_Apocalypse",	"CHECKBOX",	["Apocalypse Environment","Automagically create an apocalyptic environment"],			"Crub's Legacy",False,	nil,{params ["_value"]; if (_value) then {[] spawn crub_fnc_apocalypse}},false] call CBA_fnc_addSetting;
["Crub_Floatary",	"CHECKBOX",	["Floatary","Any helicopter bigger than a Ghosthawk can float on the water"],			"Crub's Legacy",False,	nil,{params ["_value"]; [_value] spawn crub_fnc_floatary},true] call CBA_fnc_addSetting;
