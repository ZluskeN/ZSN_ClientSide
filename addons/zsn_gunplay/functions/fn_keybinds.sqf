#include "\a3\editor_f\Data\Scripts\dikCodes.h"

["ZluskeN Utilities", "Squat_Like_Slav", "Squat (Like Slav)", {player call zsn_fnc_squat}, {}] call cba_fnc_addKeybind;

["ZluskeN Utilities", "Drop_Weapon", "Drop Current Weapon", {player call ace_common_fnc_throwWeapon}, {}] call cba_fnc_addKeybind;

["ZluskeN Utilities", "Clear_Weapon", "Clear Current Weapon", {if (currentweapon player in [primaryweapon player, handgunweapon player]) then {player call zsn_fnc_clearweapon}}, {}] call cba_fnc_addKeybind;

["ZluskeN Utilities", "Add_Arsenal", "Create Faction Arsenal", {if (ZSN_AllowArsenal) then {_arsenalholder = "Land_HelipadEmpty_F" createVehicle position player; [_arsenalholder] call zsn_fnc_addarsenal; deletevehicle _arsenalholder}}, {}] call cba_fnc_addKeybind;

//["ZluskeN Utilities", "Full_Heal", "Full ACE Heal", {if (ZSN_AllowACEHeal) then {[player] call ace_medical_treatment_fnc_fullHealLocal}}, {}] call cba_fnc_addKeybind;

//["ZluskeN Utilities", "RandomWeapon", "Give Random Weapon", {if (ZSN_AllowRandomWeapon) then {player call zsn_fnc_randomweapon}}, {}] call cba_fnc_addKeybind;
