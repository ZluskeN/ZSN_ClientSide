
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

if (isClass(configFile >> "CfgPatches" >> "SP_Moustaches")) then {
	_staches = [ 
		"SP_Moustache", 
		"SP_Moustache_Blonde", 
		"SP_Moustache_Brown", 
		"SP_Moustache_Ginger", 
		"SP_Moustache_White" 
	];

	{
		_female = _x getvariable ["ZSN_isFemale", false];
		if (random 1 < ZSN_WestStacheChance && !_female) then {
			_stache = selectrandom _staches; 
			_x linkItem _stache; 
		};
	} foreach units WEST;
	{
		_female = _x getvariable ["ZSN_isFemale", false];
		if (random 1 < ZSN_EastStacheChance && !_female) then {
			_stache = selectrandom _staches; 
			_x linkItem _stache; 
		};
	} foreach units EAST;
	{
		_female = _x getvariable ["ZSN_isFemale", false];
		if (random 1 < ZSN_GuerStacheChance && !_female) then {
			_stache = selectrandom _staches; 
			_x linkItem _stache; 
		};
	} foreach units independent;
	{
		_female = _x getvariable ["ZSN_isFemale", false];
		if (random 1 < ZSN_CivStacheChance && !_female) then {
			_stache = selectrandom _staches; 
			_x linkItem _stache; 
		};
	} foreach units civilian;
};