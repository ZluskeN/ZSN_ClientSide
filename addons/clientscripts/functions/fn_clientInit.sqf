params ["_unit"];

if (isPlayer _unit && hasinterface) then {

	_unit spawn zsn_fnc_armorshake;

	_unit call zsn_fnc_chambered;

	_unit spawn zsn_fnc_ammoloop;

};