params ["_unit"]; 

waitUntil {sleep 1; [_unit] call ace_medical_status_fnc_hasStableVitals}
if (isClass(configFile >> "CfgPatches" >> "vurtual_seat")) then {
	_pos = getpos _unit;
	_dir = getDir _unit;
	_stretcher = "vurtual_stretcher" createVehicle [random 10,random 10,0];
	[_unit, false] call ace_medical_fnc_setUnconscious;
	_unit assignAsCargo _stretcher; 
	_unit moveincargo _stretcher; 
	_unit setcaptive true;
	_stretcher lock true; 
	_stretcher setDir _dir;
	_stretcher setVehiclePosition [_pos, [], 0, "CAN_COLLIDE"];
	_box = createVehicle ["Box_Syndicate_WpsLaunch_F", _pos, [], 0, "NONE"];
	_box setDir (_dir + 90);
	clearWeaponCargo _box;
	clearMagazineCargo _box;
	clearItemCargo _box;
	clearBackpackCargo _box;
	{_box addWeaponWithAttachmentsCargoGlobal [_x, 1]; _unit removeWeaponGlobal (_x select 0)} forEach (weaponsItems _unit);
	{_box addMagazineAmmoCargo [_x select 0, 1, _x select 1]; [_unit, _x select 0, _x select 1] call CBA_fnc_removeMagazine;} forEach (magazinesAmmo _unit);
	{_box addItemCargoGlobal [_x, 1]; _unit removeitem _x} forEach (Items _unit);
	{_box addItemCargoGlobal [_x, 1]; _unit unlinkItem _x;} forEach (assignedItems _unit);
	_box addBackpackCargo [(Backpack _unit), 1];
	removebackpack _unit;
	_backpack = firstBackpack _box;
	clearItemCargo _backpack;
	clearWeaponCargo _backpack;
	clearMagazineCargo _backpack;
	_box spawn zsn_fnc_transferloop;
};
_unit setvariable ["ZSN_isRedeemable", true, true];