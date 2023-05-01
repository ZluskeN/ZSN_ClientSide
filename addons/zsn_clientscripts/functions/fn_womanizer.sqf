params ["_unit"];
ZSN_faces = [];
switch (str side _unit) do { 
	case "WEST": { 
		if (isClass(configFile >> "CfgPatches" >> "VX_Character") && _unit isUniformAllowed "VX_Uniform_NATO") then {
			if (isClass(configFile >> "CfgPatches" >> "Max_WS")) then {ZSN_faces pushback "max_faceWS1"};
			if (isClass(configFile >> "CfgPatches" >> "female3_ICEMAN")) then {
				{ZSN_faces pushback _x} foreach  ["B_female_bun_01","B_female_bun_03"];
			};
			_face = if (count ZSN_faces > 0) then {selectrandom ZSN_faces} else {removeHeadgear _unit; "Leona_Face"};
			_unit setface _face;
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
		} else { 
			if (isClass(configFile >> "CfgPatches" >> "Max_WS")) then {
				{ZSN_faces pushback _x} foreach  ["max_faceWS1","max_faceWS2","max_faceWS3","max_faceWS4","max_faceWS5","max_faceWS6","max_faceWS7","max_faceWS8","max_faceWS9","max_faceWS10"];
			};
			if (isClass(configFile >> "CfgPatches" >> "female3_ICEMAN")) then {
				{ZSN_faces pushback _x} foreach  ["B_female_bun_01","B_female_bun_02","B_female_bun_03","B_female_bun_04"];
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
			}; 
		}; 
	}; 
	case "EAST": { 
		if (isClass(configFile >> "CfgPatches" >> "VX_Character") && _unit isUniformAllowed "VX_Uniform_CSAT8") then {
			if (isClass(configFile >> "CfgPatches" >> "Max_WS")) then {ZSN_faces pushback "max_faceWS1"};
			if (isClass(configFile >> "CfgPatches" >> "female3_ICEMAN")) then {
				{ZSN_faces pushback _x} foreach  ["B_female_bun_01","B_female_bun_03"];
			};
			_face = if (count ZSN_faces > 0) then {selectrandom ZSN_faces} else {removeHeadgear _unit; "Leona_Face"};
			_unit setface _face;
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
		} else { 
			if (isClass(configFile >> "CfgPatches" >> "Max_WS")) then {
				{ZSN_faces pushback _x} foreach  ["max_faceWS1","max_faceWS2","max_faceWS3","max_faceWS4","max_faceWS5","max_faceWS6","max_faceWS7","max_faceWS8","max_faceWS9","max_faceWS10"];
			};
			if (isClass(configFile >> "CfgPatches" >> "female3_ICEMAN")) then {
				{ZSN_faces pushback _x} foreach  ["B_female_bun_01","B_female_bun_02","B_female_bun_03","B_female_bun_04"];
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
		}; 
	}; 
};