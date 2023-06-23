params ["_unit"];
if (_unit getvariable ["ZSN_isFemale", false]) exitWith {};
if (typeName ZSN_Staches == "STRING") then {ZSN_Staches = call compile ZSN_Staches};
_bool = switch (side _unit) do {
	case west: {random 1 < ZSN_WestStacheChance};
	case east: {random 1 < ZSN_EastStacheChance};
	case resistance: {random 1 < ZSN_GuerStacheChance};
	case civilian: {random 1 < ZSN_CivStacheChance};
};
if (_bool) then {
	_stache = selectrandom ZSN_Staches; 
	if (isClass (configFile >> "CfgGlasses" >> _stache)) then {
		_unit setvariable ["zsn_stache", _stache]; 
		_unit linkItem _stache;
	}; 
};