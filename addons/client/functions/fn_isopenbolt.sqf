
	params ["_magazine", "_weapon", "_ammo", "_blacklist", "_whitelist", "_isBelt", "_isOpenBolt", "_boolean"];
	
	_blacklist = [
		"vn_m1895",
		"vn_m712",
		"vn_sks",
		"CUP_SKS",
		"CUP_smg_M3A1",
		"CUP_saw_base",
		"CUP_sgun_AA12",
		"CUP_Mac10_Base",
		"CUP_hgun_Mac10_Base",
		"CUP_srifle_LeeEnfield",
		"rhs_weap_M1garand_Base_F",
		"rhs_weap_m3a1",
		"rhs_weap_m249",
		"sfp_kpistm45_base",
		"sfp_cbj_ms_base",
		"sfp_ksp90b",
		"hlc_saw_base",
		"hlc_C96_base",
		"SP_l4_lmg",
		"SP_enfield_no4",
		"SP_smg_sterling",
		"sp_fwa_smg_mat49",
		"sp_fwa_enfield_no4",
		"sp_fwa_smg_sterling",
		"cwr3_smg_sterling_sd",
		"cwr3_smg_sterling",
		"cwr3_glaunch_mm1",
		"cwr3_lmg_bren",
		"cwr3_smg_uzi",
		"uns_m1garand",
		"uns_smle",
		"Uns_LMG",
		"Uns_SMG",
		"LIB_SMG",
		"LIB_LMG",
		"LIB_M1895",
		"LIB_M1896",
		"LIB_M1_Garand",
		"LIB_LeeEnfield_No4",
		"fow_rifle_base",
		"NORTH_kp31",
		"NORTH_sten",
		"NORTH_ls26",
		"NORTH_dp27",
		"NORTH_m1895",
		"NORTH_PPD34",
		"NORTH_ppsh41",
		"NORTH_nor_smle",
		"NORTH_SIG_M1920",
		"NORTH_Madsen1914"
	];

	_whitelist = [
		"vn_pk",
		"gm_pk_base",
		"CUP_lmg_PKM",
		"CUP_srifle_ksvk",
		"CUP_srifle_AS50",
		"CUP_sgun_SPAS12",
		"CUP_sgun_Saiga12K",
		"CUP_sgun_M1014_base",
		"CUP_srifle_AWM_Base",
		"CUP_srifle_CZ550_base",
		"CUP_srifle_M2010_BASE",
		"FHQ_srifle_M2010_BASE",
		"rhs_weap_XM2010_Base_F",
		"rhs_weap_M590_5RD",
		"rhs_weap_t5000",
		"rhs_pkp_base",
		"hlc_AWC_base",
		"hlc_rifle_saiga12k",
		"fow_w_m1_carbine",
		"fow_w_stg44",
		"fow_w_fg42",
		"fow_w_g43",
		"LIB_G43",
		"LIB_SVT_40"
	];

	_isBelt = isNumber (configFile >> "CfgMagazines" >> _magazine >> "ACE_isBelt") && {(getNumber (configFile >> "CfgMagazines" >> _magazine >> "ACE_isBelt")) == 1};
	_isOpenBolt = isNumber (configFile >> "CfgWeapons" >> _weapon >> "ACE_overheating_closedBolt") && {(getNumber (configFile >> "CfgWeapons" >> _weapon >> "ACE_overheating_closedBolt")) == 0};
	_bool = {if (_weapon isKindOf [_x, configFile >> "CfgWeapons"]) exitWith {true}; _ammo <= 6} forEach _blacklist;
	if ((_isBelt OR _isOpenBolt) OR _bool) then {_bool = {if (_weapon isKindOf [_x, configFile >> "CfgWeapons"]) exitWith {false}; true} forEach _whitelist};
	switch (_weapon) do {
		case (primaryweapon player): {ZSN_PrimaryWeapon = _weapon; ZSN_PrimaryOpenBolt = _bool};
		case (handgunweapon player): {ZSN_HandgunWeapon = _weapon; ZSN_HandgunOpenBolt = _bool};
	};
	_bool