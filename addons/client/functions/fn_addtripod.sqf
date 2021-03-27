params ["_unit"];
_weapon = primaryweapon _unit; 
_tripod = "dzn_MG_Tripod_Universal_Carry"; 
_threshold = ZSN_MGstanceThreshold;  
_inertia = getNumber (configFile >> "CfgWeapons" >> _weapon >> "inertia"); 
if (([_weapon, _tripod] call dzn_MG_Tripod_fnc_getCompatibleAttachOption == "dzn_MG_Tripod_Universal") && (_inertia >= _threshold && secondaryWeapon _unit == "")) then {_unit addWeaponGlobal _tripod}; 