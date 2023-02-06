#include "\a3\editor_f\Data\Scripts\dikCodes.h"

if (isClass(configFile >> "CfgPatches" >> "ace_hitreactions")) then {
	["ZluskeN Utilities", "Drop_Weapon", "Drop Weapon", {player call ace_hitreactions_fnc_throwWeapon}, {}] call cba_fnc_addKeybind;
} else {
	["ZluskeN Utilities", "Drop_Weapon", "Drop Weapon", {player call zsn_fnc_dropweapon}, {}] call cba_fnc_addKeybind;
};

if (isClass(configFile >> "CfgPatches" >> "ace_arsenal")) then {
	["ZluskeN Utilities", "Add_Arsenal", "Create faction arsenal", {[("Land_HelipadEmpty_F" createVehicle position player)] call zsn_fnc_addarsenal}, {}] call cba_fnc_addKeybind;
} else {
	["ZluskeN Utilities", "Add_Arsenal", "Create faction arsenal", {[("Land_Ammobox_rounds_F" createVehicle position player)] call zsn_fnc_addarsenal}, {}] call cba_fnc_addKeybind;
};

["ZluskeN Utilities", "Squat_Like_Slav", "Squat (Like Slav)", {player spawn zsn_fnc_squat}, {}] call cba_fnc_addKeybind;

["ZluskeN Utilities", "RandomWeapon", "Give random weapon", {player call zsn_fnc_randomweapon}, {}] call cba_fnc_addKeybind;
