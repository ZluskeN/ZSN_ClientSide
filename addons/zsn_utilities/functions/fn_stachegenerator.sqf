params ["_unit"];
if (_unit getvariable ["ZSN_isFemale", false]) exitWith {};
if (typeName ZSN_Staches == "STRING") then {ZSN_Staches = call compile ZSN_Staches};
if (isClass(configFile >> "CfgPatches" >> "SP_Moustaches")) then {
	switch (side _unit) do {
		case west: {
			if (random 1 < ZSN_WestStacheChance) then {
				_stache = selectrandom ZSN_Staches; 
				_unit linkItem _stache; 
			};
		};
		case east: {
			if (random 1 < ZSN_EastStacheChance) then {
				_stache = selectrandom ZSN_Staches; 
				_unit linkItem _stache; 
			};
		};
		case resistance: {
			if (random 1 < ZSN_GuerStacheChance) then {
				_stache = selectrandom ZSN_Staches; 
				_unit linkItem _stache; 
			};
		};
		case civilian: {
			if (random 1 < ZSN_CivStacheChance) then {
				_stache = selectrandom ZSN_Staches; 
				_unit linkItem _stache; 
			};
		};
	};
};