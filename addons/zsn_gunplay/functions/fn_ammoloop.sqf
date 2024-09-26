params ["_unit","_unitsidemags","_currentammo","_supplyboxes","_deadboxes","_compatiblemags","_box","_magazinesinbox","_compatiblemagsinbox"];

while {alive _unit} do {
	_currentweapon = primaryweapon _unit;
	if (ZSN_AutoRearm && !(ZSN_Blockmags && !(_currentweapon in zsn_unitsideguns))) then {
		_currentammo = _unit call zsn_fnc_playerammo;
		_startammo = _unit getVariable "zsn_startammo";
		if (_currentammo < _startammo) then {
			_supplyboxes = _unit nearSupplies 3;
			_deadboxes = [];
			{if (!(_x iskindof "Man" && alive _x)) then {_deadboxes pushback _x}} foreach _supplyboxes;
			if (count _deadboxes > 0) then {
				_deadboxes = [_deadboxes, [], {_x distance _unit}, "ASCEND"] call BIS_fnc_sortBy;
				{
					if (primaryweapon _unit != _currentweapon) exitwith {};
					_box = _x;
					_magazinesinbox = switch (_box iskindof "Man") do
					{
						case true: {magazinesAmmo _box};
						case false: {magazinesAmmoCargo _box};
					};
					_compatiblemagsinbox = [];
					_compatiblemags = [_currentweapon] call CBA_fnc_compatibleMagazines;
					{if ((_x select 0) in _compatiblemags && (_x select 1) > 0) then {_compatiblemagsinbox pushback _x}} foreach _magazinesinbox;
					if (count _compatiblemagsinbox > 0) then {
						_compatiblemagsinbox = [_compatiblemagsinbox, [], {_x select 1}, "DESCEND"] call BIS_fnc_sortBy;
						{
							_magazinesinbox = switch (_box iskindof "Man") do
							{
								case true: {magazinesAmmo _box};
								case false: {magazinesAmmoCargo _box};
							};
							if (((_x in _magazinesinbox) && (_box distance _unit <= 3)) && ((_unit canAdd (_x select 0)) && (_currentammo + (_x select 1) <= _startammo))) then {
								if (primaryweapon _unit != _currentweapon) exitwith {};
								switch (_box iskindof "Man") do
								{
									case true: {[_box, _x select 0, _x select 1] call CBA_fnc_removeMagazine};
									case false: {[_box, _x select 0, 1, _x select 1] call CBA_fnc_removeMagazineCargo};
								};
								[_unit, _x select 0, _x select 1] call CBA_fnc_addMagazine;
								_currentammo = _unit call zsn_fnc_playerammo;
								for "_x" from 1 to 16 do {playsound "rearm"};
								sleep 0.5;
							};
						} foreach _compatiblemagsinbox;
					};
				} foreach _deadboxes;
			} else {
				sleep 2;
			};
		} else {
			sleep 2;
		};
	} else {
		sleep 2;
	};
};
