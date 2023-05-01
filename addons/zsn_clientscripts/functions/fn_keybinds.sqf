#include "\a3\editor_f\Data\Scripts\dikCodes.h"

["ZluskeN Utilities", "Drop_Weapon", "Drop Current Weapon", {player call ace_hitreactions_fnc_throwWeapon}, {}] call cba_fnc_addKeybind;

["ZluskeN Utilities", "Clear_Weapon", "Clear Current Weapon", {if (currentweapon player in [primaryweapon player, handgunweapon player]) then {player spawn zsn_fnc_clearweapon}}, {}] call cba_fnc_addKeybind;

["ZluskeN Utilities", "Squat_Like_Slav", "Squat (Like Slav)", {player spawn zsn_fnc_squat}, {}] call cba_fnc_addKeybind;

["ZluskeN Utilities", "RandomWeapon", "Give Random Weapon", {player call zsn_fnc_randomweapon}, {}] call cba_fnc_addKeybind;

["ZluskeN Utilities", "Add_Arsenal", "Create Faction Arsenal", {_arsenalholder = "Land_HelipadEmpty_F" createVehicle position player; [_arsenalholder] call zsn_fnc_addarsenal; deletevehicle _arsenalholder}, {}] call cba_fnc_addKeybind;