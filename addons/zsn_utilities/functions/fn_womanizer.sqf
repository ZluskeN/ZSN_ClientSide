params ["_unit"];
if (isClass(configFile >> "CfgPatches" >> "VX_Character")) then {
	_names = ["Leona"];
	if (isClass(configFile >> "CfgPatches" >> "female3_ICEMAN")) then {
		_names append ["Carter","Medrano"];
	};
	if (isClass(configFile >> "CfgPatches" >> "TCGM_Girls")) then {
		_names append ["Gonzalez","Fox","Stone","Eilish","Portman","Ayres"];
	};
	if (isClass(configFile >> "CfgPatches" >> "TCGM_Boss")) then {
		_names pushback "Boss";
	};
	if (isClass(configFile >> "CfgPatches" >> "TCGM_Quiet")) then {
		_names pushback "Quiet";
	};
	if (isClass(configFile >> "CfgPatches" >> "huan")) then {
		_names pushback "Tamaki";
	};
	if (isClass(configFile >> "CfgPatches" >> "nx")) then {
		_names pushback "Honoka";
	};
	if (isClass(configFile >> "CfgPatches" >> "xing")) then {
		_names pushback "Kokoro";
	};
	if (isClass(configFile >> "CfgPatches" >> "amy")) then {
		_names pushback "Amy";
	};
	if (isClass(configFile >> "CfgPatches" >> "fiona")) then {
		_names pushback "Fiona";
	};
	if (isClass(configFile >> "CfgPatches" >> "nanami")) then {
		_names pushback "Nanami";
	};
	if (isClass(configFile >> "CfgPatches" >> "xiaobaihe")) then {
		_names pushback "Sayuri";
	};
	if (goggles _unit in ZSN_Staches) then {removeGoggles _unit};
	_uniform = switch (str side _unit) do {
		case "WEST": {
			if (uniform _unit == "U_B_Wetsuit" && isClass(configFile >> "CfgPatches" >> "TCGM_Girls")) then {"TCGM_F_WetsuitShort_B"} else {selectrandom ["VX_Uniform_NATO","VX_Uniform_CSAT6"]};
		};
		case "EAST": {
			if (uniform _unit == "U_O_Wetsuit" && isClass(configFile >> "CfgPatches" >> "TCGM_Girls")) then {switch (faction _unit) do {case "OPF_T_F": {"TCGM_F_WetsuitShortG_O"}; default {"TCGM_F_WetsuitShort_O"}}} else {selectrandom ["VX_Uniform_CSAT5","VX_Uniform_CSAT10"]};
		};
		case "GUER": {
			if (uniform _unit == "U_I_Wetsuit" && isClass(configFile >> "CfgPatches" >> "TCGM_Girls")) then {"TCGM_F_WetsuitShort_I"} else {selectrandom ["VX_Uniform_CSAT2","VX_Uniform_CSAT8"]};
		};
		default {
			if (isClass(configFile >> "CfgPatches" >> "TCGM_Girls")) then {selectrandom ["TCGM_F_Mini_Navy","TCGM_F_Mini_ScotchR","TCGM_F_Mini_Casual2","TCGM_F_Mini_Casual3","TCGM_F_Mini_Casual4","TCGM_F_Mini_Casual5"]}
		};
	};
	_items = uniformitems _unit; 
	_unit forceAddUniform _uniform;
	{_unit addItemToUniform _x} foreach _items; 
	if (_uniform in ["TCGM_F_WetsuitShort_B","TCGM_F_WetsuitShort_O","TCGM_F_WetsuitShort_I"]) then {_names deleteAt 0};
	_name = name _unit;
	_newname = selectrandom _names;
	_fullname = _name splitString " ";
	if (count _fullname < 2) then {_fullname append _fullname select 0};
	_newfullname = [_newname, _fullname select 1] joinString " ";
	_unit setName [_newfullname, _newname, _fullname select 1];
	_face = switch (_newname) do
	{
		case "Amy": {"amy"};
		case "Fiona": {"fiona"};
		case "Nanami": {"nanami"};
		case "Sayuri": {"xiaobaihe"};
		case "Tamaki": {"huan"};
		case "Honoka": {"nx"};
		case "Kokoro": {"xing"};
		case "Carter": {selectrandom ["B_female_bun_01","B_female_bun_02"]};
		case "Medrano": {selectrandom ["B_female_bun_03","B_female_bun_04"]};
		case "Fox": {selectrandom ["TCGM_Fem_Fox","TCGM_MakF_FoxViking1","TCGM_MakF_FoxPunk1","TCGM_MakF_FoxClub1","TCGM_MakF_FoxCommand","TCGM_MakF_FoxClub2","TCGM_Fem_FoxBun","TCGM_MakF_FoxGothic1"]};
		case "Stone": {selectrandom ["TCGM_Fem_Stone","TCGM_MakF_StoneViking1","TCGM_MakF_StonePunk1","TCGM_MakF_StoneClub1","TCGM_MakF_StoneCommand","TCGM_MakF_StoneClub2","TCGM_Fem_StoneBun","TCGM_MakF_StoneGothic1"]};
		case "Eilish": {selectrandom ["TCGM_Fem_Eilish","TCGM_MakF_EilishViking1","TCGM_MakF_EilishPunk1","TCGM_MakF_EilishClub1","TCGM_MakF_EilishCommand","TCGM_MakF_EilishClub2","TCGM_Fem_EilishBun","TCGM_MakF_EilishGothic1"]};
		case "Gonzalez": {selectrandom ["TCGM_Fem_Gonzalez","TCGM_MakF_GonzalezViking1","TCGM_MakF_GonzalezPunk1","TCGM_MakF_GonzalezClub1","TCGM_MakF_GonzalezCommand","TCGM_MakF_GonzalezClub2"]};
		case "Portman": {selectrandom ["TCGM_Fem_Portman","TCGM_MakF_PortmanViking1","TCGM_MakF_PortmanPunk1","TCGM_MakF_PortmanClub1","TCGM_MakF_PortmanCommand","TCGM_MakF_PortmanClub2"]};
		case "Ayres": {selectrandom ["TCGM_Fem_Ayres","TCGM_MakF_AyresViking1","TCGM_MakF_AyresPunk1","TCGM_MakF_AyresClub1","TCGM_MakF_AyresCommand","TCGM_MakF_AyresClub2"]};
		case "Quiet": {selectrandom ["TCGM_Fem_Quiet","TCGM_MakF_QuietViking1","TCGM_MakF_QuietPunk1","TCGM_MakF_QuietClub1","TCGM_MakF_QuietCommand","TCGM_MakF_QuietClub2","TCGM_MakF_QuietGothic1"]};
		case "Boss": {selectrandom ["TCGM_MakF_BossViking1","TCGM_MakF_BossPunk1","TCGM_MakF_BossClub1"]};
		default {"Leona_Face"};
	};
	if (_face in ["Leona_Face","amy","fiona","nanami","xiaobaihe","huan","nx","xing","TCGM_Fem_Quiet","TCGM_MakF_QuietViking1","TCGM_MakF_QuietPunk1","TCGM_MakF_QuietQuiet","TCGM_MakF_QuietClub1","TCGM_MakF_QuietCommand","TCGM_MakF_QuietClub2","TCGM_MakF_QuietGothic1"]) then {
		if (goggles _unit in ["G_Balaclava_snd_lxWS","G_Balaclava_oli_lxWS","G_Balaclava_blk_lxWS","G_Balaclava_TI_G_tna_F","G_Balaclava_TI_tna_F","G_Balaclava_TI_G_blk_F","G_Balaclava_TI_blk_F","G_Balaclava_Tropentarn","G_Balaclava_Skull1","G_Balaclava_Scarecrow_01","G_Balaclava_Flames1","G_Balaclava_oli","G_Balaclava_lowprofile","G_Balaclava_Halloween_01","G_Balaclava_Flecktarn","G_Balaclava_combat","G_Balaclava_BlueStrips","G_Balaclava_blk"]) then {removegoggles _unit};
		if (_face in ["Leona_Face","amy","fiona","nanami","xiaobaihe","huan","nx","xing"]) then {_unit addHeadgear "H_HeadSet_black_F"};
	};
	_unit setface _face;
	_voice = switch (str side _unit) do {
		case "WEST": {
			if (isClass(configFile >> "CfgPatches" >> "CUP_Dubbing_Radio_EN_c")) then {"CUP_D_Female01_EN"} else {
				if (isClass(configFile >> "CfgPatches" >> "Female_Voice_RU")) then {"FemaleVoiceRU"} else {"NoVoice"};
			};
		};
		case "EAST": {
			if (isClass(configFile >> "CfgPatches" >> "Female_Voice_RU")) then {"FemaleVoiceRU"} else {
				if (isClass(configFile >> "CfgPatches" >> "CUP_Dubbing_Radio_EN_c")) then {"CUP_D_Female01_EN"} else {"NoVoice"};
			};
		};
		default {
			if (isClass(configFile >> "CfgPatches" >> "CUP_Dubbing_Radio_EN_c") && isClass(configFile >> "CfgPatches" >> "Female_Voice_RU")) then {selectrandom ["CUP_D_Female01_EN","FemaleVoiceRU"]} else {
				if (isClass(configFile >> "CfgPatches" >> "Female_Voice_RU")) then {"FemaleVoiceRU"};
				if (isClass(configFile >> "CfgPatches" >> "CUP_Dubbing_Radio_EN_c")) then {"CUP_D_Female01_EN"};
				if !(isClass(configFile >> "CfgPatches" >> "CUP_Dubbing_Radio_EN_c") || isClass(configFile >> "CfgPatches" >> "Female_Voice_RU")) then {"NoVoice"};
			};
		};
	};
	_unit setspeaker _voice;
}; 
