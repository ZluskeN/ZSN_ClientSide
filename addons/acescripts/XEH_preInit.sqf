
["ZSN_SpectatorTimer",		"SLIDER",	["Spectator timer","Time spent Unconscious before being placed in spectator mode (0 to disable) (ACE)"],	"ZluskeN ACE Settings",[0,600,0,0],	nil,{params ["_value"]; ZSN_SpectatorTimer = _value;},true] call CBA_fnc_addSetting;
["ZSN_GrenadeTrack",		"CHECKBOX",	["Allow Planting of Grenades in Tank Tracks","Hand Grenades can be used to detrack enemy tanks (ACE)"],		"ZluskeN ACE Settings",True,		nil,{params ["_value"]; ZSN_GrenadeTrack = _value;},true] call CBA_fnc_addSetting;
["ZSN_MedicFacility",		"CHECKBOX",	["Medics are facilities","Medics get configured as medical facilities (ACE)"],								"ZluskeN ACE Settings",True,		nil,{params ["_value"]; ZSN_MedicFacility = _value;},true] call CBA_fnc_addSetting;
["ZSN_MedicalItems",		"CHECKBOX",	["More medical items","Units get issued more medical gear (ACE)"],											"ZluskeN ACE Settings",True,		nil,{params ["_value"]; ZSN_MedicalItems = _value;},true] call CBA_fnc_addSetting;
