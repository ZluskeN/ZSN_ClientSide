params ["_unit"];

if (isPlayer _unit && hasinterface) then {

	call zsn_fnc_blockmags;

	_unit call zsn_fnc_chambered;

	_unit spawn zsn_fnc_ammoloop;

	_unit spawn zsn_fnc_showgps;

	_unit spawn zsn_fnc_armorshake;

	_unit spawn zsn_fnc_alonewarning;

};