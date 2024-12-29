["ZSN_replaceAttachments",	"EDITBOX",	["Attachments to replace","Replace all attachments found in this list with respective ones from the list below"],"ZluskeN Gunplay Settings",'["optic_Hamr","optic_SOS"]',nil,{params ["_value"]; if (typeName _value == "STRING") then {ZSN_replaceAttachments = call compile _value} else {ZSN_replaceAttachments = _value}},false] call CBA_fnc_addSetting;
["ZSN_replaceAttachmentsWith","EDITBOX",["Attachments to replace with","Attachments in above list will be replaced with respective ones in this list"],"ZluskeN Gunplay Settings",'["ace_xm157_prototype","ace_xm157_prototype"]',nil,{params ["_value"]; if (typeName _value == "STRING") then {ZSN_replaceAttachmentsWith = call compile _value} else {ZSN_replaceAttachmentsWith = _value}},false] call CBA_fnc_addSetting;
["ZSN_replacemagazines",	"EDITBOX",	["Magazines to replace","Replace all magazines found in this list with respective ones from the list below"],"ZluskeN Gunplay Settings",'["ACE_30Rnd_556x45_Stanag_M995_AP_mag","ZSN_30Rnd_556x45_Stanag_Sand_M995_AP_mag","ZSN_200Rnd_556x45_M995_AP_Box","200Rnd_556x45_Box_F","200Rnd_556x45_Box_Red_F","30Rnd_65x39_caseless_black_mag"]',nil,{params ["_value"]; if (typeName _value == "STRING") then {ZSN_replacemagazines = call compile _value} else {ZSN_replacemagazines = _value}},false] call CBA_fnc_addSetting;
["ZSN_replacemagazinesWith","EDITBOX",	["Magazines to replace with","Magazines in above list will be replaced with respective ones in this list"],	"ZluskeN Gunplay Settings",'["30Rnd_556x45_AP_Stanag_RF","30Rnd_556x45_AP_Stanag_Tan_RF","CUP_200Rnd_TE4_Yellow_Tracer_556x45_M249_Pouch","CUP_200Rnd_TE4_Yellow_Tracer_556x45_M249_Pouch","CUP_200Rnd_TE4_Red_Tracer_556x45_M249_Pouch","KAR_20Rnd_Fury_RT_blk"]',nil,{params ["_value"]; if (typeName _value == "STRING") then {ZSN_replacemagazinesWith = call compile _value} else {ZSN_replacemagazinesWith = _value}},false] call CBA_fnc_addSetting;
["ZSN_replaceWeapons",		"EDITBOX",	["Weapons to replace","Replace all weapons found in this list with respective ones from the list below"],	"ZluskeN Gunplay Settings",'["ef_arifle_mxar_gl","ef_arifle_mxar","arifle_MXM_Black_F","arifle_MXC_Black_F","arifle_MX_Black_F","arifle_MXM_F","arifle_MXC_F","arifle_MX_F","arifle_MX_SW_Black_F","arifle_MX_SW_F","arifle_MX_GL_Black_F","arifle_MX_GL_F","hgun_P07_blk_F","hgun_P07_khk_F","hgun_P07_F","arifle_Mk20_plain_F","arifle_Mk20C_plain_F","arifle_Mk20_GL_plain_F","srifle_DMR_03_khaki_F","arifle_Mk20_F","arifle_Mk20C_F","arifle_Mk20_GL_F","srifle_DMR_03_F","LMG_03_F","arifle_SPAR_01_blk_F","arifle_SPAR_01_khk_F","arifle_SPAR_01_snd_F","arifle_SPAR_01_GL_blk_F","arifle_SPAR_01_GL_khk_F","arifle_SPAR_01_GL_snd_F","arifle_SPAR_02_blk_F","arifle_SPAR_02_khk_F","arifle_SPAR_02_snd_F","arifle_SPAR_03_blk_F","arifle_SPAR_03_khk_F","arifle_SPAR_03_snd_F"]',nil,{params ["_value"]; if (typeName _value == "STRING") then {ZSN_replaceweapons = call compile _value} else {ZSN_replaceweapons = _value}},false] call CBA_fnc_addSetting;
["ZSN_replaceWeaponsWith",	"EDITBOX",	["Weapons to replace with","weapons in above list will be replaced with respective ones in this list"],		"ZluskeN Gunplay Settings",'["CUP_arifle_HK_M27_AG36","CUP_arifle_HK_M27_VFG","KAR_XM7_BLK_G","KAR_XM7_BLK","KAR_XM7_BLK","KAR_XM7_G","KAR_XM7","KAR_XM7","KAR_XM250_BLK","KAR_XM250","glaunch_GLX_lxWS","glaunch_GLX_tan_lxWS","CUP_hgun_M17_Coyote","CUP_hgun_M17_Coyote","CUP_hgun_M17_Green","CUP_arifle_Mk16_STD","CUP_arifle_Mk16_CQC","CUP_arifle_Mk16_CQC_EGLM","CUP_arifle_Mk20","CUP_arifle_Mk16_STD_woodland","CUP_arifle_Mk16_CQC_woodland","CUP_arifle_Mk16_CQC_EGLM_woodland","CUP_arifle_Mk20_woodland","CUP_lmg_m249_SQuantoon","CUP_arifle_HK416_CQB_Wood","CUP_arifle_HK416_Desert","CUP_arifle_HK416_CQB_Desert","CUP_arifle_HK416_AGL_Wood","CUP_arifle_HK416_AGL_Desert","CUP_arifle_HK416_CQB_AG36_Desert","CUP_arifle_HK416_Wood","CUP_arifle_M4A1_SOMMOD_Grip_tan","CUP_arifle_M4A1_SOMMOD_tan","CUP_arifle_HK417_20_Wood","CUP_arifle_HK417_20_Desert","CUP_arifle_HK417_12_Desert"]',nil,{params ["_value"]; if (typeName _value == "STRING") then {ZSN_replaceweaponsWith = call compile _value} else {ZSN_replaceweaponsWith = _value}},false] call CBA_fnc_addSetting;
["ZSN_Clearweapon",			"CHECKBOX",	["Clear Primary Weapon","Player starts with cleared primary weapon"],										"ZluskeN Gunplay Settings",True,	nil,{params ["_value"]; ZSN_Clearweapon = _value;},true] call CBA_fnc_addSetting;
["ZSN_AutoRearm",			"CHECKBOX",	["Automatic Rearm","Player will automatically pick up compatible magazines for their primary weapon"],		"ZluskeN Gunplay Settings",True,	nil,{params ["_value"]; ZSN_AutoRearm = _value;},false] call CBA_fnc_addSetting;
["ZSN_Blockmags",			"CHECKBOX",	["Hide Magazines for other sides","Disable picking up magazines belonging to different side"],				"ZluskeN Gunplay Settings",False,	nil,{params ["_value"]; ZSN_Blockmags = _value;},false] call CBA_fnc_addSetting;
["ZSN_Tun_Respawn_OldGear",	"CHECKBOX",	["Respawn with old gear","Players will respawn without replenished gear (TUN Respawn)"],					"ZluskeN Gunplay Settings",False,	nil,{params ["_value"]; ZSN_Tun_Respawn_OldGear = _value;},false] call CBA_fnc_addSetting;
["ZSN_NerfMG",				"CHECKBOX",	["Nerf Heavy Gunners","Players with heavy weapons can not ADS while moving and are forced to slow walk while firing"],"ZluskeN Gunplay Settings",False,	nil,{params ["_value"]; ZSN_NerfMG = _value;},false] call CBA_fnc_addSetting;
["ZSN_Throwing",			"CHECKBOX",	["Allow Throwing Rocks and Magazines","Players can throw magazines and rocks at each other"],				"ZluskeN Gunplay Settings",True,	nil,{params ["_value"]; ZSN_Throwing = _value;},false] call CBA_fnc_addSetting;
["ZSN_Autoswitch",			"CHECKBOX",	["Auto switch to handgun","Switch to handgun automatically when primary weapon runs out of ammo in combat"],"ZluskeN Gunplay Settings",True,	nil,{params ["_value"]; ZSN_AutoSwitch = _value;},false] call CBA_fnc_addSetting;
["ZSN_GrenadeTrack",		"CHECKBOX",	["Allow Planting of Grenades in Tank Tracks","Hand Grenades can be used to detrack enemy tanks (ACE)"],		"ZluskeN Gunplay Settings",True,	nil,{params ["_value"]; ZSN_GrenadeTrack = _value;},false] call CBA_fnc_addSetting;
["ZSN_AllowArsenal",		"CHECKBOX",	["Allow Arsenal","Allow players to create faction Arsenal"],												"ZluskeN Gunplay Settings",False,	nil,{params ["_value"]; ZSN_AllowArsenal = _value;},false] call CBA_fnc_addSetting;
//["ZSN_ACEPiPScopes",		"CHECKBOX",	["Use ACE PiP Scopes","Replace RCO, MOS and NXS with ACE PiP Versions"],									"ZluskeN Gunplay Settings",True,	nil,{params ["_value"]; ZSN_ACEPiPScopes = _value;},false] call CBA_fnc_addSetting;
//["ZSN_AllowACEHeal",		"CHECKBOX",	["Allow Full ACE Heal","Allow players to give themselves a full ACE Heal"],							["ZluskeN Gunplay Settings","Cheats"],False,	nil,{params ["_value"]; ZSN_AllowACEHeal = _value;},false] call CBA_fnc_addSetting;
//["ZSN_AllowRandomWeapon",	"CHECKBOX",	["Allow Random Weapon","Allow players to give themselves a random weapon"],							["ZluskeN Gunplay Settings","Cheats"],False,	nil,{params ["_value"]; ZSN_AllowRandomWeapon = _value;},false] call CBA_fnc_addSetting;

//,"30Rnd_556x45_AP_Stanag_RF","30Rnd_556x45_AP_Stanag_red_RF","30Rnd_556x45_AP_Stanag_green_RF","30Rnd_556x45_AP_Stanag_Tan_RF","30Rnd_556x45_AP_Stanag_red_Tan_RF","30Rnd_556x45_AP_Stanag_green_Tan_RF"
//,"30Rnd_556x45_Stanag","30Rnd_556x45_Stanag_red","30Rnd_556x45_Stanag_green","30Rnd_556x45_Stanag_Sand","30Rnd_556x45_Stanag_Sand_red","30Rnd_556x45_Stanag_Sand_green"

ZSN_Grenades = [
	"HandGrenade",
	"MiniGrenade",
	"ACE_M14",
	"CUP_HandGrenade_L109A1_HE",
	"CUP_HandGrenade_L109A2_HE",
	"CUP_HandGrenade_M67",
	"CUP_HandGrenade_RGD5",
	"CUP_HandGrenade_RGO",
	"sfp_handgrenade_shgr07",
	"sfp_handgrenade_shgr2000",
	"sfp_handgrenade_shgr56",
	"gm_handgrenade_frag_dm41",
	"gm_handgrenade_frag_dm41a1",
	"gm_handgrenade_frag_dm51",
	"gm_handgrenade_frag_dm51a1",
	"gm_handgrenade_frag_m26",
	"gm_handgrenade_frag_m26a1",
	"gm_handgrenade_frag_rgd5",
	"vn_chicom_grenade_mag",
	"vn_f1_grenade_mag",
	"vn_m14_grenade_mag",
	"vn_m14_early_grenade_mag",
	"vn_m61_grenade_mag",
	"vn_m67_grenade_mag",
	"vn_rg42_grenade_mag",
	"vn_rgd33_grenade_mag",
	"vn_rgd5_grenade_mag",
	"vn_v40_grenade_mag",
	"vn_rkg3_grenade_mag",
	"vn_satchelcharge_02_throw_mag",
	"rhs_mag_rgd5",
	"rhs_grenade_m1939e_f_mag",
	"rhs_grenade_m1939l_f_mag",
	"rhs_mag_f1",
	"rhs_grenade_mkii_mag",
	"rhs_grenade_sthgr43_mag",
	"rhs_grenade_sthgr43_heerfrag_mag",
	"rhs_grenade_sthgr43_SSfrag_mag",
	"rhs_grenade_khattabka_vog17_mag",
	"rhs_grenade_khattabka_vog25_mag",
	"rhs_mag_an_m14_th3",
	"rhs_mag_m67",
	"rhs_grenade_sthgr24_mag",
	"rhs_grenade_sthgr24_heerfrag_mag",
	"rhs_grenade_sthgr24_SSfrag_mag",
	"rhs_grenade_sthgr24_x7bundle_mag",
	"rhs_charge_sb3kg_mag",
	"rhs_charge_tnt_x2_mag",
	"rhssaf_mag_brz_m88",
	"rhssaf_mag_br_m84",
	"rhssaf_mag_br_m75",
	"rhssaf_mag_brk_m79",
	"LIB_F1",
	"LIB_M39",
	"LIB_US_Mk_2",
	"LIB_MillsBomb",
	"LIB_No82",
	"LIB_Rg42",
	"LIB_Shg24",
	"LIB_Shg24x7",
	"LIB_Rpg6",
	"LIB_Pwm",
	"fow_e_mk2",
	"fow_e_no36mk1",
	"fow_e_no69",
	"fow_e_no73",
	"fow_e_no82",
	"fow_e_m24",
	"fow_e_m24K",
	"fow_e_m24_spli",
	"fow_e_m24K_spli",
	"fow_e_m24_at",
	"fow_e_type97",
	"fow_e_type99",
	"fow_e_type99_at",
	"fow_e_tnt_halfpound",
	"NORTH_M32MortarNade_mag",
	"NORTH_M43Grenade_mag",
	"NORTH_M32Grenade_mag",
	"NORTH_NOR_IMPROV_GRENADE",
	"NORTH_F1Grenade_mag",
	"NORTH_RG42Grenade_mag",
	"NORTH_RGD33Grenade_mag",
	"NORTH_Kasapanos2kg_mag",
	"NORTH_Kasapanos3kg_mag",
	"NORTH_Kasapanos4kg_mag",
	"NORTH_KasapanosImpr3kg_mag",
	"NORTH_KasapanosImpr6kg_mag"
];
