params ["_unit"];
if ((random 1 < ZSN_Femalechance && !(isPlayer _unit && hasinterface)) && (getText (configFile >> "CfgVehicles" >> (typeof _unit) >> "vehicleClass") != "MenStory")) then {
	_faces = [];
	if (isClass(configFile >> "CfgPatches" >> "female3_ICEMAN")) then {
		if (side _unit == EAST) then {
			{_faces pushback _x} foreach ["B_female_bun_02","B_female_bun_04"];
		} else {
			{_faces pushback _x} foreach ["B_female_bun_01","B_female_bun_03"]
		};
	};
	if (isClass(configFile >> "CfgPatches" >> "Max_WS")) then {
		switch (faction _unit) do {
			case "BLU_F": {if (_unit iskindof "B_Soldier_diver_base_F") then {_unit addUniform "WU_B_Wetsuit"} else {_unit addUniform (selectrandom ["U_B_CombatUniform_mcam_W","U_B_CombatUniform_mcam_tshirt_W"])}; {_faces pushback _x} foreach ["max_faceWS1","max_faceWS2","max_faceWS3","max_faceWS4","max_faceWS5","max_faceWS6"]};
			case "BLU_T_F": {if (_unit iskindof "B_Soldier_diver_base_F") then {_unit addUniform "WU_B_Wetsuit"} else {_unit addUniform (selectrandom ["WU_B_T_Soldier_F", "WU_B_T_Soldier_AR_F"])}; {_faces pushback _x} foreach ["max_faceWS1","max_faceWS2","max_faceWS3","max_faceWS4","max_faceWS5","max_faceWS6"]};
			case "OPF_F": {if (_unit iskindof "O_Soldier_diver_base_F") then {_unit addUniform "WU_O_Wetsuit"} else {_unit addUniform "WU_O_CombatUniform_ocamo"}; {_faces pushback _x} foreach ["max_faceWS10","max_faceWS9"]};
			case "OPF_T_F": {if (_unit iskindof "O_Soldier_diver_base_F") then {_unit addUniform "WU_O_Wetsuit"} else {_unit addUniform "WU_O_T_Soldier_F"}; {_faces pushback _x} foreach ["max_faceWS7","max_faceWS8"]};
			case "IND_F": {_unit addUniform "WU_I_CombatUniform"; {_faces pushback _x} foreach ["max_faceWS1","max_faceWS2","max_faceWS3","max_faceWS4","max_faceWS5","max_faceWS6"]};
			default {{_faces pushback _x} foreach ["max_faceWS1","max_faceWS2","max_faceWS3","max_faceWS4","max_faceWS5","max_faceWS6","max_faceWS7","max_faceWS8","max_faceWS9","max_faceWS10"]} 
		};
	};
	if (count _faces > 0) then {
		_face = selectrandom _faces;
		_unit setface _face;
		_name = name _unit;
		_fullname = _name splitString " ";
		if (count _fullname > 1) then {
			_unit setName [_fullname select 1, "", _fullname select 1];
		};
		if (isClass(configFile >> "CfgPatches" >> "Female_Voice_RU")) then {_unit setSpeaker "FemaleVoiceRU"} else {_unit setspeaker "NoVoice"};
		if (isClass(configFile >> "CfgPatches" >> "rhsusf_main")) then {_unit setSpeaker "VX_Female01ENG"} else {_unit setspeaker "NoVoice"};
	};
} else {
	if (typeName ZSN_Staches == "STRING") then {ZSN_Staches = call compile ZSN_Staches};
	if (!(face _unit in ["Leona_Face","B_female_bun_01","B_female_bun_02","B_female_bun_03","B_female_bun_04","max_faceWS1","max_faceWS2","max_faceWS3","max_faceWS4","max_faceWS5","max_faceWS6","max_faceWS7","max_faceWS8","max_faceWS9","max_faceWS10"])) then {
		_bool = switch (side _unit) do {
			case west: {random 1 < ZSN_WestStacheChance};
			case east: {random 1 < ZSN_EastStacheChance};
			case resistance: {random 1 < ZSN_GuerStacheChance};
			case civilian: {random 1 < ZSN_CivStacheChance};
		};
		if (_bool) then {
			_stache = selectrandom ZSN_Staches; 
			if (isClass (configFile >> "CfgGlasses" >> _stache)) then {
				_unit additem (goggles _unit);
				_unit setvariable ["zsn_stache", _stache]; 
				_unit linkItem _stache;
			}; 
		};
	};
};