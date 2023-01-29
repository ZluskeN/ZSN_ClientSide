#include "\a3\editor_f\Data\Scripts\dikCodes.h"
if (isClass(configFile >> "CfgPatches" >> "gm_core_animations")) then {
	["ZluskeN Utilities", "Lower_MG", "Lower Machine Gun", {if (getNumber (configFile >> "CfgWeapons" >> primaryweapon player >> "inertia") >= ZSN_MGstanceThreshold) then {player playAction "toMachinegun"}}, {}] call cba_fnc_addKeybind;
};

if (isClass(configFile >> "CfgPatches" >> "RR_mapStuff")) then {
	["ZluskeN Utilities", "Place_Map", "Put Map on Ground", {if ("ItemMap" in assigneditems player) then {call RR_mapStuff_fnc_mapPut}}, {}] call cba_fnc_addKeybind;
};
