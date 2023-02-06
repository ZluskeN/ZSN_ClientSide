


//["ZSN_AddTripod",			"CHECKBOX",	["Give tripods to Machine Gunners","Heavy Machine Gunners will be given tripods (DZN Tripods)"],	["ZluskeN Server Settings","Third Party Addon Settings"],False,			nil,{params ["_value"]; ZSN_AddTripod = _value;},true] call CBA_fnc_addSetting;
//["ZSN_MGstanceThreshold",	"SLIDER",	["Weapon Inertia Threshold","Weapons with inertia above this value can be carried low (GM)"],		["ZluskeN Server Settings","Third Party Addon Settings"],[0,2,0.9,1],	nil,{params ["_value"]; ZSN_MGstanceThreshold = _value;},true] call CBA_fnc_addSetting;

//["ZSN_DisableTI",			"CHECKBOX",	["Disable Thermals","Disable Thermal Imaging and Night Vision on all vehicles during daytime"],		"ZluskeN Server Settings",True,											nil,{params ["_value"]; ZSN_DisableTI = _value; [] spawn zsn_fnc_disableNVG},true] call CBA_fnc_addSetting;
//["ZSN_AGCPlayers",		"CHECKBOX",	["AGC for players","Advanced Garbage Collector now works with players' corpses (AGC)"],				["ZluskeN Server Settings","Third Party Addon Settings"],False,			nil,{params ["_value"]; ZSN_AGCPlayers = _value;},true] call CBA_fnc_addSetting;
