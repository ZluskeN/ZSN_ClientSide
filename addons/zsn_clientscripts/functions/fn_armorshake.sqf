params ["_unit"];

while {alive _unit} do 
	_shake = 0;
	_nearbyvehicles = _unit nearEntities [["Tank"], 1000];
	_nearbytanks = [_nearbyvehicles, [_unit], {_unit distance _x}, "ASCEND", {speed _x > 0}] call BIS_fnc_sortBy;
	if ((count _nearbytanks > 0 && isNull objectParent _unit) && ZSN_Armorshake) then {
		{
			_mass = getMass _x;
			_dist = _unit distance _x;
			_num = (_mass/_dist)/20000;
			_shake = _shake + _num;
		} foreach _nearbytanks;
		addCamShake [_shake, 3, 20];
	};
	sleep 1;
};
