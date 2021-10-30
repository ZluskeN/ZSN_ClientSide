["ZSN_CombatMode","LIST",["Set AI Combat Mode","Set default combat mode for AI"],"ZluskeN Settings",[["","GREEN","WHITE","YELLOW","RED"],["Unchanged","Hold fire, keep formation","Hold fire, engage at will","Fire at will, keep formation","Fire at will, engage at will"], 2],nil,{params ["_value"]; ZSN_CombatMode = _value;}] call CBA_fnc_addSetting;
["ZSN_Unitpos","LIST",["Set AI Unit Position","Set default unit position AI"],"ZluskeN Settings",[["","DOWN","UP","MIDDLE","AUTO"],["Unchanged","Prone","Stand Up","Keep Low","Follow Leader"], 2],					nil,{params ["_value"]; ZSN_Unitpos = _value;}] call CBA_fnc_addSetting;

["ZSN_AddTripod",			"CHECKBOX",	["Give tripods to Machine Gunners","Heavy Machine Gunners will be given tripods (DZN Tripods)"],			["ZluskeN Settings","Third Party Addon Settings"],True,			nil,{params ["_value"]; ZSN_AddTripod = _value;},true] call CBA_fnc_addSetting;
["ZSN_AddShovel",			"CHECKBOX",	["Add Entrenching Tools","Soldiers start with Entrenching Tools (GRAD Trenches)"],							["ZluskeN Settings","Third Party Addon Settings"],True,			nil,{params ["_value"]; ZSN_AddShovel = _value;},true] call CBA_fnc_addSetting;
["ZSN_RemoveMaps",			"CHECKBOX",	["Remove ItemMap","Only squad leaders get maps (RR Immersive Maps)"],										["ZluskeN Settings","Third Party Addon Settings"],True,			nil,{params ["_value"]; ZSN_RemoveMaps = _value;},true] call CBA_fnc_addSetting;
["ZSN_AGCPlayers",			"CHECKBOX",	["AGC for players","Advanced Garbage Collector now works with players' corpses (AGC)"],						["ZluskeN Settings","Third Party Addon Settings"],False,		nil,{params ["_value"]; ZSN_AGCPlayers = _value;},true] call CBA_fnc_addSetting;

["ZSN_SpectatorTimer",		"SLIDER",	["Spectator timer","Time spent Unconscious before being placed in spectator mode (0 to disable) (ACE)"],	["ZluskeN Settings","Third Party Addon Settings"],[0,600,0,0],	nil,{params ["_value"]; ZSN_SpectatorTimer = _value;},true] call CBA_fnc_addSetting;
["ZSN_GrenadeTrack",		"CHECKBOX",	["Allow Planting of Grenades in Tank Tracks","Hand Grenades can be used to detrack enemy tanks (ACE)"],		["ZluskeN Settings","Third Party Addon Settings"],True,			nil,{params ["_value"]; ZSN_GrenadeTrack = _value;},true] call CBA_fnc_addSetting;
["ZSN_MedicFacility",		"CHECKBOX",	["Medics are facilities","Medics get configured as medical facilities (ACE)"],								["ZluskeN Settings","ACE Medical Settings"],True,				nil,{params ["_value"]; ZSN_MedicFacility = _value;},true] call CBA_fnc_addSetting;
["ZSN_MedicalItems",		"CHECKBOX",	["More medical items","Units get issued more medical gear (ACE)"],											["ZluskeN Settings","ACE Medical Settings"],True,				nil,{params ["_value"]; ZSN_MedicalItems = _value;},true] call CBA_fnc_addSetting;

["ZSN_DisableTI",			"CHECKBOX",	["Disable Thermals","Disable Thermal Imaging on all vehicles"],												"ZluskeN Settings",True,										nil,{params ["_value"]; ZSN_DisableTI = _value; [] spawn zsn_fnc_disableNVG},true] call CBA_fnc_addSetting;
["ZSN_MGstanceThreshold",	"SLIDER",	["Weapon Inertia Threshold","Weapons with inertia above this value can be carried low (GM)"],				["ZluskeN Settings","Third Party Addon Settings"],[0,2,0.9,1],	nil,{params ["_value"]; ZSN_MGstanceThreshold = _value;},true] call CBA_fnc_addSetting;


["ZSN_Jukebox",				"CHECKBOX",	["Jukebox","Dynamic ambient Music"],																		"ZluskeN Settings",True,										nil,{params ["_value"]; ZSN_Jukebox = _value; if (ZSN_Jukebox) then {["initialize"] call BIS_fnc_jukebox} else {["terminate"] call BIS_fnc_jukebox}}] call CBA_fnc_addSetting;
["ZSN_Armorshake",			"CHECKBOX",	["Camerashake when tracked armor is close","Scales with weight, numbers and distance"],						"ZluskeN Settings",True,										nil,{params ["_value"]; ZSN_Armorshake = _value;},true] call CBA_fnc_addSetting;

["ZSN_Clearweapon",			"CHECKBOX",	["Clear Primary Weapon","Player starts with cleared primary weapon"],										"ZluskeN Settings",True,										nil,{params ["_value"]; ZSN_Clearweapon = _value;},true] call CBA_fnc_addSetting;
["ZSN_Autoswitch",			"CHECKBOX",	["Auto switch to handgun","Switch to handgun automatically when primary weapon runs out of ammo in combat"],"ZluskeN Settings",True,										nil,{params ["_value"]; ZSN_AutoSwitch = _value;},true] call CBA_fnc_addSetting;
["ZSN_Chamberedgun",		"CHECKBOX",	["Simulate chambered round","Simulate chambered rounds for closed-bolt weapons"],							"ZluskeN Settings",True,										nil,{params ["_value"]; ZSN_Chamberedgun = _value; if (ZSN_Chamberedgun) then {player call zsn_fnc_chambered}}] call CBA_fnc_addSetting;
["ZSN_AutoRearm",			"CHECKBOX",	["Automatic Rearm","Player will automatically pick up compatible magazines for their primary weapon"],		"ZluskeN Settings",True,										nil,{params ["_value"]; ZSN_AutoRearm = _value;},true] call CBA_fnc_addSetting;

["ZSN_AllowRandomWeapon",	"CHECKBOX",	["Allow Random Weapon","Allow players to give themselves a random weapon"],									["ZluskeN Settings","'Cheat' Settings"],False,					nil,{params ["_value"]; ZSN_AllowRandomWeapon = _value;}] call CBA_fnc_addSetting;
["ZSN_AllowArsenal",		"CHECKBOX",	["Allow Arsenal","Allow players to create faction Arsenal"],												["ZluskeN Settings","'Cheat' Settings"],False,					nil,{params ["_value"]; ZSN_AllowArsenal = _value;}] call CBA_fnc_addSetting;
