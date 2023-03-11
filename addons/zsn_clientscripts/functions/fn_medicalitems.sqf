params ["_unit"];
{
	if (_x in ["FirstAidKit", "Medikit"]) then {
		_unit removeitem _x;
	};
} forEach items _unit;
{
	while {_item = (_x select 0); ({_x == _item} count items _unit) < (_x select 1)} do {
		_unit addItem (_x select 0);	
	};
} forEach [["ACE_packingBandage",7],["ACE_tourniquet",2],["ACE_morphine",1],["ACE_splint",1]];
if ([_unit] call ace_common_fnc_isMedic) then {
	if (backpack _unit == "") then {_unit addbackpack "B_FieldPack_khk"};
	{	
		while {_item = (_x select 0); ({_x == _item} count items _unit) < (_x select 1)} do {
			if (_unit canAddItemToBackpack (_x select 0)) then {_unit addItemToBackpack (_x select 0)} else {_unit addItem (_x select 0)};		
		};
	} forEach [
			["ACE_tourniquet", 4],
			["ACE_morphine", 5], 
			["ACE_bloodIV", 7],
			["ACE_epinephrine", 7],
			["ACE_splint", 5],
			["ACE_surgicalKit", 1],
			["ACE_adenosine", 3],
			["ACE_elasticBandage", 26]
		];
};