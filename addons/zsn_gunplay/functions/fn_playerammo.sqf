params ["_unit","_compatiblemags","_startmags","_startmagtypes","_startammo"];
_primaryweapon = primaryWeapon _unit;
_primarymagazine = {if (_x select 0 == _primaryweapon) exitwith {_x select 4}} foreach weaponsItems _unit;
_compatiblemags = [_primaryweapon] call CBA_fnc_compatibleMagazines;
_startmags = magazinesAmmo _unit;
_startmagtypes = [];
if (count _primarymagazine == 2) then {_startmagtypes pushback _primarymagazine};
{if (_x select 0 in _compatiblemags) then {_startmagtypes pushback _x}} foreach _startmags;
_startammo = 0;
{_startammo = _startammo + (_x select 1)} foreach _startmagtypes;
_startammo