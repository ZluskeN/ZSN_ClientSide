params ["_unit"];
if (!(face _unit in ["huan","nx","xing","amy","fiona","nanami","xiaobaihe","Leona_Face","max_faceWS1","max_faceWS2","max_faceWS3","max_faceWS4","max_faceWS5","max_faceWS6","max_faceWS7","max_faceWS8","max_faceWS9","max_faceWS10","B_female_bun_01","B_female_bun_02","B_female_bun_03","B_female_bun_04","TCGM_Fem_Liu","TCGM_Fem_Zhu","TCGM_Fem_Fenty","TCGM_Fem_Hobson","TCGM_Fem_Gonzalez","TCGM_MakF_GonzalezViking1","TCGM_MakF_GonzalezPunk1","TCGM_MakF_GonzalezCommand","TCGM_MakF_GonzalezQuiet","TCGM_MakF_GonzalezClub1","TCGM_MakF_GonzalezClub2","TCGM_Fem_Fox","TCGM_Fem_FoxBun","TCGM_MakF_FoxViking1","TCGM_MakF_FoxPunk1","TCGM_MakF_FoxCommand","TCGM_MakF_FoxQuiet","TCGM_MakF_FoxClub1","TCGM_MakF_FoxClub2","TCGM_MakF_FoxGothic1","TCGM_Fem_Stone","TCGM_Fem_StoneBun","TCGM_MakF_StoneViking1","TCGM_MakF_StonePunk1","TCGM_MakF_StoneCommand","TCGM_MakF_StoneQuiet","TCGM_MakF_StoneClub1","TCGM_MakF_StoneClub2","TCGM_MakF_StoneGothic1","TCGM_Fem_Eilish","TCGM_Fem_EilishBun","TCGM_MakF_EilishViking1","TCGM_MakF_EilishPunk1","TCGM_MakF_EilishCommand","TCGM_MakF_EilishQuiet","TCGM_MakF_EilishClub1","TCGM_MakF_EilishClub2","TCGM_MakF_EilishGothic1","TCGM_Fem_Portman","TCGM_MakF_PortmanViking1","TCGM_MakF_PortmanPunk1","TCGM_MakF_PortmanCommand","TCGM_MakF_PortmanQuiet","TCGM_MakF_PortmanClub1","TCGM_MakF_PortmanClub2","TCGM_Fem_Ayres","TCGM_MakF_AyresViking1","TCGM_MakF_AyresPunk1","TCGM_MakF_AyresCommand","TCGM_MakF_AyresQuiet","TCGM_MakF_AyresClub1","TCGM_MakF_AyresClub2","TCGM_MakF_FentyClub1","TCGM_MakF_HobsonClub1","TCGM_MakF_LiuClub1","TCGM_MakF_ZhuClub1","TCGM_Fem_Quiet","TCGM_MakF_QuietViking1","TCGM_MakF_QuietPunk1","TCGM_MakF_QuietQuiet","TCGM_MakF_QuietClub1","TCGM_MakF_QuietCommand","TCGM_MakF_QuietClub2","TCGM_MakF_QuietGothic1","TCGM_Fem_Boss","TCGM_MakF_BossViking1","TCGM_MakF_BossPunk1","TCGM_MakF_BossClub1","mgsr_nakedsnake"])) then {
	if ((random 1 < ZSN_Femalechance && !(isPlayer _unit && hasinterface)) && (getText (configFile >> "CfgVehicles" >> (typeof _unit) >> "vehicleClass") != "MenStory")) then {
		_faces = [];
		_uniforms = []; 
		switch (faction _unit) do {
			case "BLU_F": {
				if (isClass(configFile >> "CfgPatches" >> "TCGM_Boss")) then {
					_faces append ["TCGM_Fem_Boss","TCGM_MakF_BossClub1"];
				};
				if (isClass(configFile >> "CfgPatches" >> "TCGM_Quiet")) then {
					_faces append ["TCGM_Fem_Quiet","TCGM_MakF_QuietClub1"];
				};
				if (isClass(configFile >> "CfgPatches" >> "female3_ICEMAN") && uniform _unit != "U_B_Wetsuit") then {
					_faces append ["B_female_bun_02","B_female_bun_04","B_female_bun_01","B_female_bun_03"];
				};
				if (isClass(configFile >> "CfgPatches" >> "Max_WS")) then {
					_faces append ["max_faceWS1","max_faceWS2","max_faceWS3","max_faceWS4","max_faceWS5","max_faceWS6"];
				};
				if (isClass(configFile >> "CfgPatches" >> "TCGM_Girls")) then {
					_faces append ["TCGM_Fem_Gonzalez","TCGM_Fem_Fox","TCGM_Fem_Stone","TCGM_Fem_Portman","TCGM_Fem_Liu","TCGM_Fem_Zhu","TCGM_Fem_Fenty","TCGM_Fem_Hobson","TCGM_Fem_FoxBun","TCGM_Fem_StoneBun"];
				};
				switch (uniform _unit) do {
					case "U_B_Wetsuit": {
						if (isClass(configFile >> "CfgPatches" >> "Max_WS")) then {
							_uniforms pushback "WU_B_Wetsuit";
						};
						if (isClass(configFile >> "CfgPatches" >> "TCGM_Girls")) then {
							_uniforms pushback "TCGM_F_Wetsuit_B";
						};
					};
					case "U_B_CombatUniform_mcam": {
						if (isClass(configFile >> "CfgPatches" >> "Max_WS")) then {
							_uniforms pushback "U_B_CombatUniform_mcam_W";
						};
						if (isClass(configFile >> "CfgPatches" >> "TCGM_Girls")) then {
							_uniforms pushback "TCGM_CombatFatigues_MTP";
						};
					};
					case "U_B_CombatUniform_mcam_tshirt": {
						if (isClass(configFile >> "CfgPatches" >> "Max_WS")) then {
							_uniforms pushback "U_B_CombatUniform_mcam_tshirt_W";
						};
						if (isClass(configFile >> "CfgPatches" >> "TCGM_Girls")) then {
							_uniforms pushback "TCGM_CombatFatigues_MTP_Bra";
						};
					};
					case "U_B_HeliPilotCoveralls": {
						if (isClass(configFile >> "CfgPatches" >> "Max_WS")) then {
							_uniforms pushback "WU_B_HeliPilotCoveralls";
						};
					};
					default {
						if (isClass(configFile >> "CfgPatches" >> "TCGM_Girls")) then {
							_uniforms pushback "TCGM_CombatFatigues_MTP_RollUp";
						};
					};
				};
			};
			case "BLU_T_F": {
				if (isClass(configFile >> "CfgPatches" >> "TCGM_Boss")) then {
					_faces append ["TCGM_Fem_Boss","TCGM_MakF_BossClub1"];
				};
				if (isClass(configFile >> "CfgPatches" >> "TCGM_Quiet")) then {
					_faces append ["TCGM_Fem_Quiet","TCGM_MakF_QuietClub1"];
				};
				if (isClass(configFile >> "CfgPatches" >> "female3_ICEMAN") && uniform _unit != "U_B_Wetsuit") then {
					_faces append ["B_female_bun_02","B_female_bun_04","B_female_bun_01","B_female_bun_03"];
				};
				if (isClass(configFile >> "CfgPatches" >> "Max_WS")) then {
					_faces append ["max_faceWS1","max_faceWS2","max_faceWS3","max_faceWS4","max_faceWS5","max_faceWS6"];
				};
				if (isClass(configFile >> "CfgPatches" >> "TCGM_Girls")) then {
					_faces append ["TCGM_Fem_Gonzalez","TCGM_Fem_Fox","TCGM_Fem_Stone","TCGM_Fem_Portman","TCGM_Fem_Liu","TCGM_Fem_Zhu","TCGM_Fem_Fenty","TCGM_Fem_Hobson","TCGM_Fem_FoxBun","TCGM_Fem_StoneBun"];
				};
				switch (uniform _unit) do {
					case "U_B_Wetsuit": {
						if (isClass(configFile >> "CfgPatches" >> "Max_WS")) then {
							_uniforms pushback "WU_B_Wetsuit";
						};
						if (isClass(configFile >> "CfgPatches" >> "TCGM_Girls")) then {
							_uniforms pushback "TCGM_F_Wetsuit_B";
						};
					};
					case "U_B_T_Soldier_F": {
						if (isClass(configFile >> "CfgPatches" >> "Max_WS")) then {
							_uniforms pushback "WU_B_T_Soldier_F";
						};
						if (isClass(configFile >> "CfgPatches" >> "TCGM_Girls")) then {
							_uniforms pushback "TCGM_CombatFatigues_tna";
						};
					};
					case "U_B_T_Soldier_AR_F": {
						if (isClass(configFile >> "CfgPatches" >> "Max_WS")) then {
							_uniforms pushback "WU_B_T_Soldier_AR_F";
						};
						if (isClass(configFile >> "CfgPatches" >> "TCGM_Girls")) then {
							_uniforms pushback "TCGM_CombatFatigues_tna_Bra";
						};
					};
					case "U_B_HeliPilotCoveralls": {
						if (isClass(configFile >> "CfgPatches" >> "Max_WS")) then {
							_uniforms pushback "WU_B_HeliPilotCoveralls";
						};
					};
					default {
						if (isClass(configFile >> "CfgPatches" >> "TCGM_Girls")) then {
							_uniforms pushback "TCGM_CombatFatigues_tna_RollUp";
						};
					};
				};
			};
			case "BLU_W_F": {
				if (isClass(configFile >> "CfgPatches" >> "TCGM_Boss")) then {
					_faces append ["TCGM_Fem_Boss","TCGM_MakF_BossClub1"];
				};
				if (isClass(configFile >> "CfgPatches" >> "TCGM_Quiet")) then {
					_faces append ["TCGM_Fem_Quiet","TCGM_MakF_QuietClub1"];
				};
				if (isClass(configFile >> "CfgPatches" >> "female3_ICEMAN")) then {
					_faces append ["B_female_bun_02","B_female_bun_04","B_female_bun_01","B_female_bun_03"];
				};
				if (isClass(configFile >> "CfgPatches" >> "Max_WS")) then {
					_faces append ["max_faceWS1","max_faceWS2","max_faceWS3","max_faceWS4","max_faceWS5","max_faceWS6"];
				};
				if (isClass(configFile >> "CfgPatches" >> "TCGM_Girls")) then {
					_faces append ["TCGM_Fem_Gonzalez","TCGM_Fem_Fox","TCGM_Fem_Stone","TCGM_Fem_Portman","TCGM_Fem_Liu","TCGM_Fem_Zhu","TCGM_Fem_Fenty","TCGM_Fem_Hobson","TCGM_Fem_FoxBun","TCGM_Fem_StoneBun"];
				};
				switch (uniform _unit) do {
					case "U_B_CombatUniform_mcam_wdl_f": {
						if (isClass(configFile >> "CfgPatches" >> "TCGM_Girls")) then {
							_uniforms pushback "TCGM_CombatFatigues_wdl";
						};
					};
					case "U_B_CombatUniform_tshirt_mcam_wdL_f": {
						if (isClass(configFile >> "CfgPatches" >> "TCGM_Girls")) then {
							_uniforms pushback "TCGM_CombatFatigues_wdl_Bra";
						};
					};
					case "U_B_HeliPilotCoveralls": {
						if (isClass(configFile >> "CfgPatches" >> "Max_WS")) then {
							_uniforms pushback "WU_B_HeliPilotCoveralls";
						};
					};
					default {
						if (isClass(configFile >> "CfgPatches" >> "TCGM_Girls")) then {
							_uniforms pushback "TCGM_CombatFatigues_wdl_RollUp";
						};
					};
				};
			};
			case "BLU_CTRG_F": {
				if (isClass(configFile >> "CfgPatches" >> "TCGM_Boss")) then {
					_faces append ["TCGM_Fem_Boss","TCGM_MakF_BossClub1"];
				};
				if (isClass(configFile >> "CfgPatches" >> "TCGM_Quiet")) then {
					_faces append ["TCGM_Fem_Quiet","TCGM_MakF_QuietClub1"];
				};
				if (isClass(configFile >> "CfgPatches" >> "female3_ICEMAN")) then {
					_faces append ["B_female_bun_02","B_female_bun_04","B_female_bun_01","B_female_bun_03"];
				};
				if (isClass(configFile >> "CfgPatches" >> "Max_WS")) then {
					_faces append ["max_faceWS1","max_faceWS2","max_faceWS3","max_faceWS4","max_faceWS5","max_faceWS6"];
				};
				if (isClass(configFile >> "CfgPatches" >> "TCGM_Girls")) then {
					_faces append ["TCGM_Fem_Gonzalez","TCGM_Fem_Fox","TCGM_Fem_Stone","TCGM_Fem_Portman","TCGM_Fem_Liu","TCGM_Fem_Zhu","TCGM_Fem_Fenty","TCGM_Fem_Hobson","TCGM_Fem_FoxBun","TCGM_Fem_StoneBun"];
					_uniform = switch (uniform _unit) do {
						case "U_B_CTRG_Soldier_F": {"TCGM_CombatUniform_CTRG_Stealth"};
						case "U_B_CTRG_Soldier_Arid_F": {"TCGM_CombatUniform_CTRG_Stealth_arid"};
						case "U_B_CTRG_Soldier_urb_1_F": {"TCGM_UrbanUniform_CTRG"};
						case "U_B_CTRG_Soldier_urb_2_F": {"TCGM_UrbanUniform_CTRG_Bra"};
						case "U_B_CTRG_Soldier_urb_2_F": {"TCGM_UrbanUniform_CTRG_RollUp"};
						case "U_B_CTRG_3_lxWS": {"TCGM_CombatUniform_CTRG_RollUp"};
						case "U_B_CTRG_4_lxWS": {"TCGM_CombatUniform_CTRG"};
						default {"TCGM_CombatUniform_CTRG_Bra"};
					};
					_uniforms pushback _uniform;
				};
			};
			case "OPF_F": {
				if (isClass(configFile >> "CfgPatches" >> "Max_WS")) then {
					_faces append ["max_faceWS10","max_faceWS9","max_faceWS8","max_faceWS7"];
				};
				if (isClass(configFile >> "CfgPatches" >> "TCGM_Girls")) then {
					_faces append ["TCGM_Fem_Liu","TCGM_Fem_Zhu"];
				};
				switch (uniform _unit) do {
					case "U_O_Wetsuit": {
						if (isClass(configFile >> "CfgPatches" >> "TCGM_Girls")) then {
							_uniforms pushback "TCGM_F_Wetsuit_O";
						};
						if (isClass(configFile >> "CfgPatches" >> "Max_WS")) then {
							_uniforms pushback "WU_O_Wetsuit";
						};
					};
					case "U_O_PilotCoveralls": {
						if (isClass(configFile >> "CfgPatches" >> "Max_WS")) then {
							_uniforms pushback "WU_O_PilotCoveralls";
						};
					};
					case "U_O_CombatUniform_oucamo": {
						if (isClass(configFile >> "CfgPatches" >> "TCGM_Girls")) then {
							_uniforms pushback "TCGM_F_Viper_UHex";
							_unit addheadgear "TCGM_Helmet_Viper_O_UHex";
						};
					};
					case "U_O_OfficerUniform_ocamo": {
						if (isClass(configFile >> "CfgPatches" >> "Max_WS")) then {
							_uniforms pushback "WU_O_OfficerUniform_ocamo";
						};
					};
					case "U_O_V_Soldier_Viper_hex_F": {
						if (isClass(configFile >> "CfgPatches" >> "TCGM_Girls")) then {
							_uniforms pushback "TCGM_F_Viper_UHex";
						};
					};
					default {
						if (isClass(configFile >> "CfgPatches" >> "Max_WS")) then {
							_uniforms pushback "WU_O_CombatUniform_ocamo";
						};
					};
				};
			};
			case "OPF_T_F": {
				if (isClass(configFile >> "CfgPatches" >> "Max_WS")) then {
					_faces append ["max_faceWS10","max_faceWS9","max_faceWS8","max_faceWS7"];
				};
				if (isClass(configFile >> "CfgPatches" >> "TCGM_Girls")) then {
					_faces append ["TCGM_Fem_Liu","TCGM_Fem_Zhu"];
				};
				switch (uniform _unit) do {
					case "U_O_Wetsuit": {
						if (isClass(configFile >> "CfgPatches" >> "TCGM_Girls")) then {
							_uniforms pushback "TCGM_F_WetsuitG_O";
						};
						if (isClass(configFile >> "CfgPatches" >> "Max_WS")) then {
							_uniforms pushback "WU_O_Wetsuit";
						};
					};
					case "U_O_T_Officer_F": {
						if (isClass(configFile >> "CfgPatches" >> "Max_WS")) then {
							_uniforms pushback "WU_O_T_Officer_F";
						};
					};
					case "U_O_V_Soldier_Viper_F": {
						if (isClass(configFile >> "CfgPatches" >> "TCGM_Girls")) then {
							_uniforms pushback "TCGM_F_Viper_GHex";
						};
					};
					default {
						if (isClass(configFile >> "CfgPatches" >> "Max_WS")) then {
							_uniforms pushback "WU_O_T_Soldier_F";
						};
					};
				};
			};
			case "IND_F": {
				if (isClass(configFile >> "CfgPatches" >> "female3_ICEMAN") && uniform _unit != "U_B_Wetsuit") then {
					_faces append ["B_female_bun_02","B_female_bun_04","B_female_bun_01","B_female_bun_03"];
				};
				if (isClass(configFile >> "CfgPatches" >> "Max_WS")) then {
					_faces append ["max_faceWS1","max_faceWS2","max_faceWS3"];
				};
				if (isClass(configFile >> "CfgPatches" >> "TCGM_Girls")) then {
					_faces append ["TCGM_Fem_Gonzalez","TCGM_Fem_Fox","TCGM_Fem_Stone","TCGM_Fem_Portman","TCGM_Fem_FoxBun","TCGM_Fem_StoneBun"];
				};
				if (isClass(configFile >> "CfgPatches" >> "TCGM_Boss")) then {
					_faces append ["TCGM_Fem_Boss","TCGM_MakF_BossClub1"];
				};
				if (isClass(configFile >> "CfgPatches" >> "TCGM_Quiet")) then {
					_faces append ["TCGM_Fem_Quiet","TCGM_MakF_QuietClub1"];
				};
				switch (uniform _unit) do {
					case "U_I_Wetsuit": {
						if (isClass(configFile >> "CfgPatches" >> "TCGM_Girls")) then {
							_uniforms pushback "TCGM_F_Wetsuit_I";
						};
					};
					case "U_I_CombatUniform": {
						if (isClass(configFile >> "CfgPatches" >> "Max_WS")) then {
							_uniforms pushback "WU_I_CombatUniform";
						};
						if (isClass(configFile >> "CfgPatches" >> "TCGM_Girls")) then {
							_uniforms pushback "TCGM_F_Soldier02";
						};
					};
					case "U_I_OfficerUniform": {
						if (isClass(configFile >> "CfgPatches" >> "Max_WS")) then {
							_uniforms pushback "WU_I_OfficerUniform";
						};
					};
					case "U_I_HeliPilotCoveralls": {
						if (isClass(configFile >> "CfgPatches" >> "Max_WS")) then {
							_uniforms pushback "WU_I_HeliPilotCoveralls";
						};
					};
					default {
						if (isClass(configFile >> "CfgPatches" >> "TCGM_Girls")) then {
							_uniforms pushback "TCGM_F_Soldier02_RollUp";
						};
					};
				};
			};
			case "IND_E_F": {
				if (isClass(configFile >> "CfgPatches" >> "female3_ICEMAN")) then {
					_faces append ["B_female_bun_02","B_female_bun_04","B_female_bun_01","B_female_bun_03"];
				};
				if (isClass(configFile >> "CfgPatches" >> "Max_WS")) then {
					_faces append ["max_faceWS1","max_faceWS2","max_faceWS3"];
				};
				if (isClass(configFile >> "CfgPatches" >> "TCGM_Girls")) then {
					_faces append ["TCGM_Fem_Gonzalez","TCGM_Fem_Fox","TCGM_Fem_Stone","TCGM_Fem_Portman","TCGM_Fem_FoxBun","TCGM_Fem_StoneBun"];
				};
				if (isClass(configFile >> "CfgPatches" >> "TCGM_Boss")) then {
					_faces append ["TCGM_Fem_Boss","TCGM_MakF_BossClub1"];
				};
				if (isClass(configFile >> "CfgPatches" >> "TCGM_Quiet")) then {
					_faces append ["TCGM_Fem_Quiet","TCGM_MakF_QuietClub1"];
				};
				switch (uniform _unit) do {
					case "U_I_E_Uniform_01_F": {
						if (isClass(configFile >> "CfgPatches" >> "TCGM_Girls")) then {
							_uniforms append ["TCGM_F_Soldier3","TCGM_F_Soldier4"];
						};
					};
					case "U_I_E_Uniform_01_shortsleeve_F": {
						if (isClass(configFile >> "CfgPatches" >> "Max_WS")) then {
							_uniforms append ["TCGM_F_Soldier3_RollUp","TCGM_F_Soldier4_RollUp"];
						};
					};
					case "U_I_E_Uniform_01_sweater_F": {
						if (isClass(configFile >> "CfgPatches" >> "Max_WS")) then {
							_uniforms pushback "TCGM_F_Soldier2";
						};
					};
					default {
						if (isClass(configFile >> "CfgPatches" >> "TCGM_Girls")) then {
							_uniforms pushback "TCGM_F_Soldier2_RollUp";
						};
					};
				};
			};
			case "IND_C_F": {
				if (isClass(configFile >> "CfgPatches" >> "Max_WS")) then {
					_faces append ["max_faceWS10","max_faceWS9","max_faceWS8","max_faceWS7","max_faceWS6","max_faceWS5","max_faceWS4"];
				};
				if (isClass(configFile >> "CfgPatches" >> "TCGM_Girls")) then {
					_faces append ["TCGM_Fem_Liu","TCGM_Fem_Zhu","TCGM_Fem_Fenty","TCGM_Fem_Hobson"];
					_uniforms append ["TCGM_F_SoldierParamilitary2_RollUp","TCGM_F_SoldierParamilitary2"];
				};
			};
			case "EF_B_MJTF_Wdl": {
				if (isClass(configFile >> "CfgPatches" >> "TCGM_Boss")) then {
					_faces append ["TCGM_Fem_Boss","TCGM_MakF_BossClub1"];
				};
				if (isClass(configFile >> "CfgPatches" >> "TCGM_Quiet")) then {
					_faces append ["TCGM_Fem_Quiet","TCGM_MakF_QuietClub1"];
				};
				if (isClass(configFile >> "CfgPatches" >> "female3_ICEMAN") && uniform _unit != "U_B_Wetsuit") then {
					_faces append ["B_female_bun_02","B_female_bun_04","B_female_bun_01","B_female_bun_03"];
				};
				if (isClass(configFile >> "CfgPatches" >> "Max_WS")) then {
					_faces append ["max_faceWS1","max_faceWS2","max_faceWS3","max_faceWS4","max_faceWS5","max_faceWS6"];
				};
				if (isClass(configFile >> "CfgPatches" >> "TCGM_Girls")) then {
					_faces append ["TCGM_Fem_Gonzalez","TCGM_Fem_Fox","TCGM_Fem_Stone","TCGM_Fem_Portman","TCGM_Fem_Liu","TCGM_Fem_Zhu","TCGM_Fem_Fenty","TCGM_Fem_Hobson","TCGM_Fem_FoxBun","TCGM_Fem_StoneBun"];
				};
				switch (uniform _unit) do {
					case "EF_U_B_MarineCombatUniform_Wdl_1": {
						if (isClass(configFile >> "CfgPatches" >> "TCGM_MultiPlay_Girls")) then {
							_uniforms pushback "TCGM_Soldier02_B_MARPAT_WOOD";
						};
					};
					case "EF_U_B_MarineCombatUniform_Wdl_2": {
						if (isClass(configFile >> "CfgPatches" >> "TCGM_MultiPlay_Girls")) then {
							_uniforms pushback "TCGM_Soldier02_B_MARPAT_Wood2";
						};
					};
					case "EF_U_B_MarineCombatUniform_Wdl_3": {
						if (isClass(configFile >> "CfgPatches" >> "TCGM_MultiPlay_Girls")) then {
							_uniforms pushback "TCGM_Soldier02_B_MARPAT_WOOD_RollUp";
						};
					};
					case "EF_U_B_MarineCombatUniform_Wdl_4": {
						if (isClass(configFile >> "CfgPatches" >> "TCGM_MultiPlay_Girls")) then {
							_uniforms pushback "TCGM_Soldier02_B_MARPAT_Wood2_RollUp";
						};
					};
					case "EF_U_B_MarineCombatUniform_Wdl_5": {
						if (isClass(configFile >> "CfgPatches" >> "TCGM_MultiPlay_Girls")) then {
							_uniforms pushback "TCGM_Soldier02_B_WOOD_MARPAT";
						};
					};
					case "EF_U_B_MarineCombatUniform_Wdl_6": {
						if (isClass(configFile >> "CfgPatches" >> "TCGM_MultiPlay_Girls")) then {
							_uniforms pushback "TCGM_Soldier02_B_WOOD_MARPAT_RollUp";
						};
					};
					default {
						if (isClass(configFile >> "CfgPatches" >> "TCGM_Girls")) then {
							_uniforms pushback "TCGM_Survival_TNA_Bra";
						};
					};
				};
			};
			case "EF_B_MJTF_Des": {
				if (isClass(configFile >> "CfgPatches" >> "TCGM_Boss")) then {
					_faces append ["TCGM_Fem_Boss","TCGM_MakF_BossClub1"];
				};
				if (isClass(configFile >> "CfgPatches" >> "TCGM_Quiet")) then {
					_faces append ["TCGM_Fem_Quiet","TCGM_MakF_QuietClub1"];
				};
				if (isClass(configFile >> "CfgPatches" >> "female3_ICEMAN") && uniform _unit != "U_B_Wetsuit") then {
					_faces append ["B_female_bun_02","B_female_bun_04","B_female_bun_01","B_female_bun_03"];
				};
				if (isClass(configFile >> "CfgPatches" >> "Max_WS")) then {
					_faces append ["max_faceWS1","max_faceWS2","max_faceWS3","max_faceWS4","max_faceWS5","max_faceWS6"];
				};
				if (isClass(configFile >> "CfgPatches" >> "TCGM_Girls")) then {
					_faces append ["TCGM_Fem_Gonzalez","TCGM_Fem_Fox","TCGM_Fem_Stone","TCGM_Fem_Portman","TCGM_Fem_Liu","TCGM_Fem_Zhu","TCGM_Fem_Fenty","TCGM_Fem_Hobson","TCGM_Fem_FoxBun","TCGM_Fem_StoneBun"];
				};
				switch (uniform _unit) do {
					case "EF_U_B_MarineCombatUniform_Des_1": {
						if (isClass(configFile >> "CfgPatches" >> "TCGM_MultiPlay_Girls")) then {
							_uniforms pushback "TCGM_Soldier02_B_MARPAT_Desert";
						};
					};
					case "EF_U_B_MarineCombatUniform_Des_2": {
						if (isClass(configFile >> "CfgPatches" >> "TCGM_MultiPlay_Girls")) then {
							_uniforms pushback "TCGM_Soldier02_B_MARPAT_Desert2";
						};
					};
					case "EF_U_B_MarineCombatUniform_Des_3": {
						if (isClass(configFile >> "CfgPatches" >> "TCGM_MultiPlay_Girls")) then {
							_uniforms pushback "TCGM_Soldier02_B_MARPAT_Desert_RollUp";
						};
					};
					case "EF_U_B_MarineCombatUniform_Des_4": {
						if (isClass(configFile >> "CfgPatches" >> "TCGM_MultiPlay_Girls")) then {
							_uniforms pushback "TCGM_Soldier02_B_MARPAT_Desert2_RollUp";
						};
					};
					case "EF_U_B_MarineCombatUniform_Des_5": {
						if (isClass(configFile >> "CfgPatches" >> "TCGM_MultiPlay_Girls")) then {
							_uniforms pushback "TCGM_Soldier02_B_3CD_Ranger";
						};
					};
					case "EF_U_B_MarineCombatUniform_Des_6": {
						if (isClass(configFile >> "CfgPatches" >> "TCGM_MultiPlay_Girls")) then {
							_uniforms pushback "TCGM_Soldier02_B_3CD_Ranger_RollUp";
						};
					};
					default {
						if (isClass(configFile >> "CfgPatches" >> "TCGM_Girls")) then {
							_uniforms pushback "TCGM_Survival_MTP_Bra";
						};
					};
				};
			};
			case "CUP_I_PMC_ION": {
				if (isClass(configFile >> "CfgPatches" >> "female3_ICEMAN")) then {
					_faces append ["B_female_bun_02","B_female_bun_04","B_female_bun_01","B_female_bun_03"];
				};
				if (isClass(configFile >> "CfgPatches" >> "Max_WS")) then {
					_faces append ["max_faceWS10","max_faceWS9","max_faceWS8","max_faceWS7","max_faceWS1","max_faceWS2","max_faceWS3"];
				};
				if (isClass(configFile >> "CfgPatches" >> "TCGM_Girls")) then {
					_faces append ["TCGM_Fem_Gonzalez","TCGM_Fem_Fox","TCGM_Fem_Stone","TCGM_Fem_Portman","TCGM_Fem_Liu","TCGM_Fem_Zhu","TCGM_Fem_FoxBun","TCGM_Fem_StoneBun"];
					if (getText (configFile >> "CfgVehicles" >> (typeof player) >> "editorSubcategory") == "EdSubcat_Personnel") then {
						_uniforms append ["TCGM_CombatUniform_Sage_Bra","TCGM_CombatUniform_M81_Bra"];
						if (isClass(configFile >> "CfgPatches" >> "TCGM_MultiPlay_Girls")) then {
							_uniforms pushback "TCGM_Multiplay_U_B_MARPAT_Bra";
						};
					};
				};
				if (getText (configFile >> "CfgVehicles" >> (typeof player) >> "editorSubcategory") == "EdSubcat_Personnel_Camo_Arctic") then {
					if (isClass(configFile >> "CfgPatches" >> "TCGM_MultiPlay_Girls")) then {
						_uniforms append ["TCGM_Multiplay_U_B_Snow_Combat_Stealth","TCGM_Multiplay_U_B_Snow_Type2"];
					};
					if (isClass(configFile >> "CfgPatches" >> "TCGM_Boss")) then {
						_uniforms pushback "TCGM_f_Boss_U1";
					};
				};
				if (isClass(configFile >> "CfgPatches" >> "TCGM_Quiet")) then {
					_faces pushback "TCGM_Fem_Quiet";
				};
			};
			default {
				if (isClass(configFile >> "CfgPatches" >> "female3_ICEMAN")) then {
					_faces append ["B_female_bun_01","B_female_bun_03"];
				};
				if (isClass(configFile >> "CfgPatches" >> "Max_WS")) then {
					_faces append ["max_faceWS1","max_faceWS2","max_faceWS3","max_faceWS4","max_faceWS5","max_faceWS6","max_faceWS7","max_faceWS8","max_faceWS9","max_faceWS10"];
				};
				if (isClass(configFile >> "CfgPatches" >> "TCGM_Boss")) then {
					_faces append ["TCGM_Fem_Boss","TCGM_MakF_BossClub1"];
				};
				if (isClass(configFile >> "CfgPatches" >> "TCGM_Quiet")) then {
					_faces append ["TCGM_Fem_Quiet","TCGM_MakF_QuietClub1"];
				};
				switch (uniform _unit) do {
					case "U_B_GEN_Commander_F": {
						if (isClass(configFile >> "CfgPatches" >> "Max_WS")) then {
							_uniforms pushback "WU_B_GEN_Commander_F";
						};
						if (isClass(configFile >> "CfgPatches" >> "TCGM_Girls")) then {
							_uniforms pushback "TCGM_F_Soldier_GEN";
						};
					};
					case "U_B_GEN_Soldier_F": {
						if (isClass(configFile >> "CfgPatches" >> "Max_WS")) then {
							_uniforms pushback "WU_B_GEN_Soldier_F";
						};
						if (isClass(configFile >> "CfgPatches" >> "TCGM_Girls")) then {
							_uniforms pushback "TCGM_F_Soldier_GEN_RollUp";
						};
					};
					case "U_C_Paramedic_01_F": {
						if (isClass(configFile >> "CfgPatches" >> "TCGM_Girls")) then {
							_uniforms pushback "TCGM_F_Paramedic";
						};
					};
				};
				if (isClass(configFile >> "CfgPatches" >> "TCGM_Girls")) then {
					_faces append ["TCGM_Fem_Gonzalez","TCGM_Fem_Fox","TCGM_Fem_Stone","TCGM_Fem_Portman","TCGM_Fem_Fenty","TCGM_Fem_Hobson","TCGM_Fem_Liu","TCGM_Fem_Zhu","TCGM_MakF_GonzalezClub1","TCGM_MakF_FoxClub1","TCGM_MakF_StoneClub1","TCGM_MakF_PortmanClub1","TCGM_MakF_FentyClub1","TCGM_MakF_HobsonClub1","TCGM_MakF_LiuClub1","TCGM_MakF_ZhuClub1","TCGM_Fem_FoxBun","TCGM_Fem_StoneBun","TCGM_MakF_FoxGothic1","TCGM_MakF_StoneGothic1"];
					switch (str side _unit) do {
						case "CIV": {_uniforms append ["TCGM_F_Sport_1","TCGM_F_Sport_2","TCGM_F_Sport_3","TCGM_F_Sport_4","TCGM_F_Sport_5"]};
						default {_uniforms append ["TCGM_F_SoldierParamilitary","TCGM_F_SoldierParamilitary_RollUp","TCGM_F_Soldier1_RollUp","TCGM_F_Soldier1"]};
					};
				};
				if (isClass(configFile >> "CfgPatches" >> "TCGM_MultiPlay_Girls")) then {
					switch (str side _unit) do {
						case "CIV": {_uniforms pushback "TCGM_Multiplay_U_B_BLK_Combat_Stealth"};
						default {_uniforms append ["TCGM_Multiplay_U_B_BLK_TAN","TCGM_Multiplay_U_B_BLK_TAN_RollUp","TCGM_Multiplay_U_B_Blk_OD","TCGM_Multiplay_U_B_Blk_OD_RollUp","TCGM_Soldier02_B_BLK_BLK","TCGM_Soldier02_B_BLK_BLK_RollUp","TCGM_Multiplay_U_B_BLK","TCGM_Multiplay_U_B_BLK_RollUp","TCGM_Multiplay_U_B_Sage_RollUp","TCGM_Multiplay_U_B_Sage_Bra","TCGM_Multiplay_U_B_TAN_BLK","TCGM_Multiplay_U_B_TAN_BLK_RollUp","TCGM_Multiplay_U_B_TAN_OD","TCGM_Multiplay_U_B_TAN_OD_RollUp","TCGM_Soldier02_B_TAN_TAN","TCGM_Soldier02_B_TAN_TAN_RollUp","TCGM_Multiplay_U_B_TAN_Bra","TCGM_Multiplay_U_B_OD_BLK","TCGM_Multiplay_U_B_OD_BLK_RollUp","TCGM_Soldier02_B_OD_OD","TCGM_Soldier02_B_OD_OD_RollUp","TCGM_Multiplay_U_B_OD_Bra","TCGM_Multiplay_U_B_3CD_BLK","TCGM_Multiplay_U_B_3CD_BLK_RollUp","TCGM_Multiplay_U_B_3cd","TCGM_Multiplay_U_B_3cd_RollUp","TCGM_Multiplay_U_B_3CD_Bra","TCGM_Multiplay_U_B_WDL_GRY","TCGM_Multiplay_U_B_WDL_GRY_RollUp","TCGM_Multiplay_U_B_WDL","TCGM_Multiplay_U_B_WDL_RollUp","TCGM_Multiplay_U_B_WDL_Bra"]};
					};
				};
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
					if (isClass(configFile >> "CfgPatches" >> "CUP_Dubbing_Radio_EN_c") && isClass(configFile >> "CfgPatches" >> "Female_Voice_RU")) then {selectrandom ["FemaleVoiceRU","CUP_D_Female01_EN"]} else {
						if (isClass(configFile >> "CfgPatches" >> "Female_Voice_RU")) then {"FemaleVoiceRU"};
						if (isClass(configFile >> "CfgPatches" >> "CUP_Dubbing_Radio_EN_c")) then {"CUP_D_Female01_EN"};
						if !(isClass(configFile >> "CfgPatches" >> "CUP_Dubbing_Radio_EN_c") || isClass(configFile >> "CfgPatches" >> "Female_Voice_RU")) then {"NoVoice"};
					};
				};
			};
			_unit setspeaker _voice;
			if (count _uniforms > 0) then {
				_uniform = selectrandom _uniforms;
				_items = uniformitems _unit; 
				_unit forceAddUniform _uniform;
				{_unit addItemToUniform _x} foreach _items; 
			};
		};
	} else {
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
				_unit additem (goggles _unit);
				_unit setvariable ["zsn_stache", _stache]; 
				_unit linkItem _stache;
			}; 
		};
	};
};