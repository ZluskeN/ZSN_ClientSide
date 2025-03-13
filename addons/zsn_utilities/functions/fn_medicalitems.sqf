params ["_unit"];
if (typeName ZSN_UnitItems == "STRING") then {ZSN_UnitItems = call compile ZSN_UnitItems};
if (typeName ZSN_MedicItems == "STRING") then {ZSN_MedicItems = call compile ZSN_MedicItems};

_nods = ["ACE_NVG_Gen4_WP","ACE_NVG_Gen4_Green_WP","ACE_NVG_Gen4_Black_WP"];
{
	if (_x == _unit getSlotItemName 616) then {_unit linkItem (_nods select _foreachindex)};
	if (_x in items _unit) then {_unit removeitem _x; _unit additem (_nods select _foreachindex)};
} foreach ["NVGoggles","NVGoggles_INDEP","NVGoggles_OPFOR"];

if (count (["Chemlight_blue","Chemlight_green","Chemlight_red","Chemlight_yellow"] arrayintersect magazines _unit) > 0 && sunOrMoon < 1) then {_unit addItem "ACE_Chemlight_Shield"};

{
	while {_item = (_x select 0); ({_x == _item} count itemsWithMagazines _unit) < (_x select 1)} do {
		_unit addItem (_x select 0);
	};
} forEach ZSN_UnitItems;
_unit addmagazine ["ace_painkillers", 2];

if ([_unit] call ace_common_fnc_isMedic) then {
	if (backpack _unit == "") then {_unit addbackpack "B_FieldPack_khk"};
	{
		while {_item = (_x select 0); ({_x == _item} count itemsWithMagazines _unit) < (_x select 1)} do {
			if (_unit canAddItemToBackpack (_x select 0)) then {_unit addItemToBackpack (_x select 0)} else {_unit addItem (_x select 0)};		
		};
	} forEach ZSN_MedicItems;
	_unit addMagazines ["ace_painkillers", 2];
};