params ["_unit"];
ZSN_faces = [];
if (goggles _unit in ZSN_Staches) then {removeGoggles _unit};
switch (str side _unit) do { 
	case "WEST": { 
		if (isClass(configFile >> "CfgPatches" >> "VX_Character") && _unit isUniformAllowed "VX_Uniform_NATO") then {
			ZSN_faces pushback "Leona_Face";
			if (isClass(configFile >> "CfgPatches" >> "Max_WS")) then {ZSN_faces pushback "max_faceWS1"};
			if (isClass(configFile >> "CfgPatches" >> "female3_ICEMAN")) then {
				{ZSN_faces pushback _x} foreach  ["B_female_bun_01","B_female_bun_02","B_female_bun_03","B_female_bun_04"];
			};
			_face = selectrandom ZSN_faces;
			_unit setface _face;
			if (_face == "Leona_Face") then {removeHeadgear _unit};
			_unit setvariable ["ZSN_isFemale", true, true];
			_items = uniformitems _unit; 
			_unit addUniform "VX_Uniform_NATO";
			{_unit addItemToUniform _x} foreach _items; 
			_name = name _unit;
			_newname = selectrandom ["Leona","Carter","Medrano"];
			_fullname = _name splitString " ";
			if (count _fullname < 2) then {_fullname append _fullname select 0};
			_newfullname = [_newname, _fullname select 1] joinString " ";
			_unit setName [_newfullname, _newname, _fullname select 1];
			if (isClass(configFile >> "CfgPatches" >> "Female_Voice_RU")) THEN {_unit setSpeaker "FemaleVoiceRU"};
			if (isClass(configFile >> "CfgPatches" >> "rhsusf_main")) then {_unit setSpeaker "VX_Female01ENG"};
		} else { 
			if (isClass(configFile >> "CfgPatches" >> "Max_WS")) then {
				{ZSN_faces pushback _x} foreach  ["max_faceWS1","max_faceWS2","max_faceWS3","max_faceWS4","max_faceWS5","max_faceWS6","max_faceWS7","max_faceWS8","max_faceWS9","max_faceWS10"];
			};
			if (isClass(configFile >> "CfgPatches" >> "female3_ICEMAN")) then {
				{ZSN_faces pushback _x} foreach  ["B_female_bun_01","B_female_bun_03"];
			}; 
			if (count ZSN_faces > 0) then {
				_face = selectrandom ZSN_faces;
				_unit setface _face;
				_unit setvariable ["ZSN_isFemale", true, true];
				_name = name _unit;
				_newname = selectrandom ["Carter","Medrano"];
				_fullname = _name splitString " ";
				if (count _fullname < 2) then {_fullname append _fullname select 0};
				_newfullname = [_newname, _fullname select 1] joinString " ";
				_unit setName [_newfullname, _newname, _fullname select 1];
				if (isClass(configFile >> "CfgPatches" >> "Female_Voice_RU")) then {_unit setSpeaker "FemaleVoiceRU"};
				if (isClass(configFile >> "CfgPatches" >> "rhsusf_main")) then {_unit setSpeaker "VX_Female01ENG"};
				if (isClass(configFile >> "CfgPatches" >> "Max_WS")) then {
					switch (faction _unit) do { 
						case "BLU_T_F": {_unit addUniform (selectrandom ["WU_B_T_Soldier_F", "WU_B_T_Soldier_AR_F"])};
						case "BLU_F": {_unit addUniform (selectrandom ["U_B_CombatUniform_mcam_W","U_B_CombatUniform_mcam_tshirt_W"])};
						default {};
					};
				};
			}; 
		}; 
	}; 
	case "EAST": { 
		if (isClass(configFile >> "CfgPatches" >> "VX_Character") && _unit isUniformAllowed "VX_Uniform_CSAT8") then {
			ZSN_faces pushback "Leona_Face";
			if (isClass(configFile >> "CfgPatches" >> "Max_WS")) then {ZSN_faces pushback "max_faceWS1"};
			if (isClass(configFile >> "CfgPatches" >> "female3_ICEMAN")) then {
				{ZSN_faces pushback _x} foreach  ["B_female_bun_01","B_female_bun_02","B_female_bun_03","B_female_bun_04"];
			};
			_face = selectrandom ZSN_faces;
			_unit setface _face;
			if (_face == "Leona_Face") then {removeHeadgear _unit};
			_unit setvariable ["ZSN_isFemale", true, true];
			_items = uniformitems _unit; 
			_unit addUniform "VX_Uniform_CSAT8"; 
			{_unit addItemToUniform _x} foreach _items; 
			_name = name _unit;
			_newname = selectrandom ["Leona","Carter","Medrano"];
			_fullname = _name splitString " ";
			if (count _fullname < 2) then {_fullname append _fullname select 0};
			_newfullname = [_newname, _fullname select 1] joinString " ";
			_unit setName [_newfullname, _newname, _fullname select 1];
			if (isClass(configFile >> "CfgPatches" >> "rhsusf_main")) then {_unit setSpeaker "VX_Female01ENG"};
			if (isClass(configFile >> "CfgPatches" >> "Female_Voice_RU")) THEN {_unit setSpeaker "FemaleVoiceRU"};
		} else { 
			if (isClass(configFile >> "CfgPatches" >> "Max_WS")) then {
				{ZSN_faces pushback _x} foreach  ["max_faceWS1","max_faceWS2","max_faceWS3","max_faceWS4","max_faceWS5","max_faceWS6","max_faceWS7","max_faceWS8","max_faceWS9","max_faceWS10"];
			};
			if (isClass(configFile >> "CfgPatches" >> "female3_ICEMAN")) then {
				{ZSN_faces pushback _x} foreach  ["B_female_bun_01","B_female_bun_03"];
			}; 
			if (count ZSN_faces > 0) then {
				_face = selectrandom ZSN_faces;
				_unit setface _face;
				_unit setvariable ["ZSN_isFemale", true, true];
				_name = name _unit;
				_newname = selectrandom ["Carter","Medrano"];
				_fullname = _name splitString " ";
				if (count _fullname < 2) then {_fullname append _fullname select 0};
				_newfullname = [_newname, _fullname select 1] joinString " ";
				_unit setName [_newfullname, _newname, _fullname select 1];
				if (isClass(configFile >> "CfgPatches" >> "rhsusf_main")) then {_unit setSpeaker "VX_Female01ENG"};
				if (isClass(configFile >> "CfgPatches" >> "Female_Voice_RU")) then {_unit setSpeaker "FemaleVoiceRU"};
				if (isClass(configFile >> "CfgPatches" >> "Max_WS")) then {
					switch (faction _unit) do { 
						case "OPF_T_F": {_unit addUniform "WU_O_T_Soldier_F"};
						case "OPF_F": {_unit addUniform "WU_O_CombatUniform_ocamo"};
						default {};
					};
				};
			}; 
		}; 
	}; 
	default { 
		if (isClass(configFile >> "CfgPatches" >> "Max_WS")) then {
			{ZSN_faces pushback _x} foreach  ["max_faceWS1","max_faceWS2","max_faceWS3","max_faceWS4","max_faceWS5","max_faceWS6","max_faceWS7","max_faceWS8","max_faceWS9","max_faceWS10"];
		};
		if (isClass(configFile >> "CfgPatches" >> "female3_ICEMAN")) then {
			{ZSN_faces pushback _x} foreach  ["B_female_bun_01","B_female_bun_03"];
		}; 
		if (count ZSN_faces > 0) then {
			_face = selectrandom ZSN_faces;
			_unit setface _face;
			_unit setvariable ["ZSN_isFemale", true, true];
			_name = name _unit;
			_newname = selectrandom ["Carter","Medrano"];
			_fullname = _name splitString " ";
			if (count _fullname < 2) then {_fullname append _fullname select 0};
			_newfullname = [_newname, _fullname select 1] joinString " ";
			_unit setName [_newfullname, _newname, _fullname select 1];
			if (isClass(configFile >> "CfgPatches" >> "Female_Voice_RU")) then {_unit setSpeaker "FemaleVoiceRU"};
			if (isClass(configFile >> "CfgPatches" >> "rhsusf_main")) then {_unit setSpeaker "VX_Female01ENG"};
			if (isClass(configFile >> "CfgPatches" >> "Max_WS") && faction _unit == "IND_F") then {_unit addUniform "WU_I_CombatUniform"};
		}; 
	}; 
};