params ["_unit","_compatiblemags","_startmags","_startmagtypes","_startammo"];
_compatiblemags = [primaryweapon _unit] call CBA_fnc_compatibleMagazines;
_startmags = magazinesAmmo _unit;
_startmagtypes = [];
{if (_x select 0 in _compatiblemags) then {_startmagtypes pushback _x};} foreach _startmags;
_startammo = 0;
{_startammo = _startammo + (_x select 1)} foreach _startmagtypes;
_startammo