params ["_unit"];
if (typeName ZSN_UnitItems == "STRING") then {ZSN_UnitItems = call compile ZSN_UnitItems};
if (typeName ZSN_MedicItems == "STRING") then {ZSN_MedicItems = call compile ZSN_MedicItems};
{
	if (_x in ["FirstAidKit", "Medikit"]) then {
		_unit removeitem _x;
	};
} forEach items _unit;
{
	while {_item = (_x select 0); ({_x == _item} count items _unit) < (_x select 1)} do {
		_unit addItem (_x select 0);	
	};
} forEach ZSN_UnitItems;
if ([_unit] call ace_common_fnc_isMedic) then {
	if (backpack _unit == "") then {_unit addbackpack "B_FieldPack_khk"};
	{	
		while {_item = (_x select 0); ({_x == _item} count items _unit) < (_x select 1)} do {
			if (_unit canAddItemToBackpack (_x select 0)) then {_unit addItemToBackpack (_x select 0)} else {_unit addItem (_x select 0)};		
		};
	} forEach ZSN_MedicItems;
};