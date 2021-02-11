#include "\a3\editor_f\Data\Scripts\dikCodes.h"
if (isClass(configFile >> "CfgPatches" >> "gm_core_animations")) then {
	["ZluskeN", "Lower_MG", "Lower Machine Gun", {if (getNumber (configFile >> "CfgWeapons" >> primaryweapon player >> "inertia") >= ZSN_MGstanceThreshold) then {player playAction "toMachinegun"}}, {}] call cba_fnc_addKeybind;
};

if (isClass(configFile >> "CfgPatches" >> "ace_hitreactions")) then {
	["ZluskeN", "Drop_Weapon", "Drop Weapon", {player call ace_hitreactions_fnc_throwWeapon}, {}] call cba_fnc_addKeybind;
} else {
	["ZluskeN", "Drop_Weapon", "Drop Weapon", {player call zsn_fnc_dropweapon}, {}] call cba_fnc_addKeybind;
};

if (isClass(configFile >> "CfgPatches" >> "ace_arsenal") && !ZSN_VanillaArsenal) then {
	["ZluskeN", "Add_Arsenal", "Create faction arsenal", {[("Land_HelipadEmpty_F" createVehicle position player)] call zsn_fnc_addarsenal_ace}, {}] call cba_fnc_addKeybind;
} else {
	["ZluskeN", "Add_Arsenal", "Create faction arsenal", {[("Land_Ammobox_rounds_F" createVehicle position player)] call zsn_fnc_addarsenal}, {}] call cba_fnc_addKeybind;
};

["ZluskeN", "RandomWeapon", "Give player a random weapon", {player call zsn_fnc_randomweapon}, {}] call cba_fnc_addKeybind;

["ZluskeN", "Squat_Like_Slav", "Squat (Like Slav)", {if (side player == EAST) then {player spawn zsn_fnc_squat}}, {}] call cba_fnc_addKeybind;
