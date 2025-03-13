
params ["_unit"];

{if (_x == "FirstAidKit") then {
	_uniformgear = getunitloadout _unit select 3 select 1;
	_addedtouniform = {
		if (count _x == 3 && (_x select 0 == "ace_painkillers" && _x select 2 <= 8)) exitWith {
			[uniformcontainer _unit, "ace_painkillers", 1, _x select 2] call CBA_fnc_removeMagazineCargo;
			[_unit, "ace_painkillers", "uniform", (_x select 2) + 2] call ace_common_fnc_addToInventory;
			true
		};
		false
	} foreach _uniformgear;
	if (!_addedtouniform) then {[_unit, "ace_painkillers", "uniform", 2] call ace_common_fnc_addToInventory};
}} foreach uniformItems _unit;

{if (_x == "FirstAidKit") then {
	_vestgear = getunitloadout _unit select 4 select 1;
	_addedtovest = {
		if (count _x == 3 && (_x select 0 == "ace_painkillers" && _x select 2 <= 8)) exitWith {
			[vestcontainer _unit, "ace_painkillers", 1, _x select 2] call CBA_fnc_removeMagazineCargo;
			[_unit, "ace_painkillers", "vest", (_x select 2) + 2] call ace_common_fnc_addToInventory;
			true
		};
		false
	} foreach _vestgear;
	if (!_addedtovest) then {[_unit, "ace_painkillers", "vest", 2] call ace_common_fnc_addToInventory};
}} foreach vestItems _unit;

{if (_x == "FirstAidKit") then {
	_backpackgear = getunitloadout _unit select 5 select 1;
	_addedtobackpack = {
		if (count _x == 3 && (_x select 0 == "ace_painkillers" && _x select 2 <= 8)) exitWith {
			[backpackcontainer _unit, "ace_painkillers", 1, _x select 2] call CBA_fnc_removeMagazineCargo;
			[_unit, "ace_painkillers", "backpack", (_x select 2) + 2] call ace_common_fnc_addToInventory;
			true
		};
		false
	} foreach _backpackgear;
	if (!_addedtobackpack) then {[_unit, "ace_painkillers", "backpack", 2] call ace_common_fnc_addToInventory};
}} foreach backpackItems _unit;
