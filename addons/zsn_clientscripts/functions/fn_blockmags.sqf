params ["_unit"];

zsn_westmagazines = [];
zsn_eastmagazines = [];
zsn_guermagazines = [];
zsn_westweapons = [];
zsn_eastweapons = [];
zsn_guerweapons = [];
{
	_unit = _x;
	_weapon = primaryweapon _unit;
	_magazines = [_weapon] call CBA_fnc_compatibleMagazines;
	_magazines insert [-1, magazines _unit, true];
	switch (side _unit) do {
		case WEST: {{zsn_westmagazines pushBackUnique _x} foreach _magazines; zsn_westweapons pushBackUnique _weapon};
		case EAST: {{zsn_eastmagazines pushBackUnique _x} foreach _magazines; zsn_eastweapons pushBackUnique _weapon};
		case INDEPENDENT: {{zsn_guermagazines pushBackUnique _x} foreach _magazines; zsn_guerweapons pushBackUnique _weapon};
		default {};
	};
} foreach allUnits;
zsn_commonmagazines = zsn_westmagazines arrayIntersect zsn_eastmagazines;
zsn_commonweapons = zsn_westweapons arrayIntersect zsn_eastweapons;

zsn_unitsideguns = switch (playerSide) do {
	case WEST: {zsn_westweapons};
	case EAST: {zsn_eastweapons};
	case INDEPENDENT: {zsn_guerweapons};
	default {zsn_commonweapons};
};

player addEventHandler ["InventoryOpened", {
	params ["_unit", "_container","_containerhiddenmags","_unitsidemags","_containermags"];
	if (ZSN_Blockmags) then {
		_containerhiddenmags = _container getvariable ["zsn_hiddenMags", []];
		if (_containerhiddenmags == []) then {
			_unitsidemags = switch (zsn_unitsideguns) do {
				case zsn_westweapons: {zsn_westmagazines};
				case zsn_eastweapons: {zsn_eastmagazines};
				case zsn_guerweapons: {zsn_guermagazines};
				case zsn_commonweapons: {zsn_commonmagazines};
				default {[]};
			};
			if (_container iskindof "Man") then	{
				_containermags = magazinesAmmo _container;
				{if (!(_x select 0 in _unitsidemags)) then {[_container, _x select 0, _x select 1] call CBA_fnc_removeMagazine; _containerhiddenmags pushback _x}} foreach _containermags;
			} else {
				_containermags = magazinesAmmoCargo _container;
				{if (!(_x select 0 in _unitsidemags)) then {[_container, _x select 0, _x select 1] call CBA_fnc_removeMagazineCargo; _containerhiddenmags pushback _x}} foreach _containermags;
			};
			_container setvariable ["zsn_hiddenMags", _containerhiddenmags, true];
			_container addEventHandler ["ContainerClosed", {
				params ["_unit", "_container","_containerhiddenmags"];
				_containerhiddenmags = _container getvariable ["zsn_hiddenMags", []];
				if (_container iskindof "Man") then	{
					{_container addMagazine _x} foreach _containerhiddenmags;
				} else {
					{_container addMagazineAmmoCargo [_x select 0, 1, _x select 1]} foreach _containerhiddenmags;
				};
				_container setvariable ["zsn_hiddenMags", [], true];
				_container removeEventHandler ["ContainerClosed", _thisID];
			}];
		} else {
			closeDialog 602; true
		};
	};
}];
