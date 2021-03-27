params ["_unit"];
while {alive _unit} do {
	num = 0;
	_nearbyvehicles = _unit nearEntities [["Tank"], 1000];
	_nearbytanks = [_nearbyvehicles, [_unit], {_unit distance _x}, "ASCEND", {speed _x > 0}] call BIS_fnc_sortBy;
	if ((count _nearbytanks > 0 && isNull objectParent _unit) && ZSN_Armorshake) then {
		{
			_mass = getMass _x;
			_dist = _unit distance _x;
			_num = (_mass/_dist)/10000;
			num = num + _num;
		} foreach _nearbytanks;
		addCamShake [num, 3, 20];
	};
	sleep 1;
};