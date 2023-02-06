params ["_unit","_containers","_container","_boxContents","_weapon"];
if ((!(captive _unit) && primaryweapon _unit == "") && !(hasinterface && isplayer _unit)) then {
	_containers = [];
	{if ((weaponcargo _x) select 0 isKindOf ["Rifle_Base_F", configFile >> "CfgWeapons"]) then {_containers pushback _x};} forEach nearestObjects [_unit, ["ReammoBox", "ThingX"], 50];
	if (count _containers > 0) then {
		_containers = [_containers, [], {_unit distance _x}] call BIS_fnc_sortBy;
		_container = _containers select 0;
		_boxContents = weaponCargo _container;
		_weapon = _boxContents select 0;
		_unit action ["TakeWeapon", _container, _weapon];
		[_unit, "Picked up a weapon", _weapon] remoteexec ["zsn_fnc_hint"];
	};
};