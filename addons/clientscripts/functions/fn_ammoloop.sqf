params ["_unit","_currentammo","_supplyboxes","_deadboxes","_compatiblemags","_box","_magazinesinbox","_compatiblemagsinbox"];

zsn_startammo = _unit call zsn_fnc_playerammo; 

while {alive _unit} do {
	if (ZSN_AutoRearm) then {
		_currentammo = _unit call zsn_fnc_playerammo;
		if (_currentammo < zsn_startammo) then {
			_supplyboxes = _unit nearSupplies 3;
			_deadboxes = [];
			{if (!(_x iskindof "Man" && alive _x)) then {_deadboxes pushback _x}} foreach _supplyboxes;
			if (count _deadboxes > 0) then {
				_deadboxes = [_deadboxes, [], {_x distance _unit}, "ASCEND"] call BIS_fnc_sortBy;
				_compatiblemags = [primaryweapon _unit] call CBA_fnc_compatibleMagazines;
				{
					_box = _x;
					_magazinesinbox = switch (_box iskindof "Man") do
					{
						case true: {magazinesAmmo _box};
						case false: {magazinesAmmoCargo _box};
					};
					_compatiblemagsinbox = [];
					{if ((_x select 0) in _compatiblemags) then {_compatiblemagsinbox pushback _x}} foreach _magazinesinbox;
					if (count _compatiblemagsinbox > 0) then {
						_compatiblemagsinbox = [_compatiblemagsinbox, [], {_x select 1}, "DESCEND"] call BIS_fnc_sortBy;
						{					
							_magazinesinbox = switch (_box iskindof "Man") do
							{
								case true: {magazinesAmmo _box};
								case false: {magazinesAmmoCargo _box};
							};
							if (((_x in _magazinesinbox) && (_box distance _unit <= 3)) && ((_unit canAdd (_x select 0)) && (_currentammo + (_x select 1) <= zsn_startammo))) then {
								switch (_box iskindof "Man") do
								{
									case true: {[_box, _x select 0, _x select 1] call CBA_fnc_removeMagazine};
									case false: {[_box, _x select 0, 1, _x select 1] call CBA_fnc_removeMagazineCargo};
								};
								[_unit, _x select 0, _x select 1] call CBA_fnc_addMagazine;
								_currentammo = _unit call zsn_fnc_playerammo;
								playsound "weap_ar_drop";
								sleep 0.5;
							};
						} foreach _compatiblemagsinbox;
					};
				} foreach _deadboxes;
			} else {
				sleep 0.5;
			};
		} else {
			sleep 0.5;
		};
	} else {
		sleep 0.5;
	};
};


