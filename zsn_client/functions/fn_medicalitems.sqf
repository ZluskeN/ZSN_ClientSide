params ["_unit"];
{
	if (_x in ["FirstAidKit", "Medikit"]) then {
		_unit removeitem _x;
	};
} forEach items _unit;
if ([_unit] call ace_common_fnc_isMedic) then {
	{	
		if (_unit canAddItemToBackpack _x) then {_unit addItemToBackpack _x} else {_unit addItem _x};
	} forEach [
		"ACE_tourniquet",
		"ACE_tourniquet",
		"ACE_morphine",
		"ACE_morphine",
		"ACE_morphine",
		"ACE_morphine",
		"ACE_bloodIV",
		"ACE_bloodIV",
		"ACE_bloodIV",
		"ACE_bloodIV",
		"ACE_bloodIV",
		"ACE_bloodIV",
		"ACE_bloodIV",
		"ACE_epinephrine",
		"ACE_epinephrine",
		"ACE_epinephrine",
		"ACE_epinephrine",
		"ACE_epinephrine",
		"ACE_epinephrine",
		"ACE_epinephrine",
		"ACE_splint",
		"ACE_splint",
		"ACE_splint",
		"ACE_splint",
		"ACE_surgicalKit",
		"ACE_adenosine",
		"ACE_adenosine",
		"ACE_adenosine",
		"ACE_elasticBandage",
		"ACE_elasticBandage",
		"ACE_elasticBandage",
		"ACE_elasticBandage",
		"ACE_elasticBandage",
		"ACE_elasticBandage",
		"ACE_elasticBandage",
		"ACE_elasticBandage",
		"ACE_elasticBandage",
		"ACE_elasticBandage",
		"ACE_elasticBandage",
		"ACE_elasticBandage",
		"ACE_elasticBandage",
		"ACE_elasticBandage",
		"ACE_elasticBandage",
		"ACE_elasticBandage",
		"ACE_elasticBandage",
		"ACE_elasticBandage",
		"ACE_elasticBandage",
		"ACE_elasticBandage",
		"ACE_elasticBandage",
		"ACE_elasticBandage",
		"ACE_elasticBandage",
		"ACE_elasticBandage",
		"ACE_elasticBandage",
		"ACE_elasticBandage"];
};
{
	_unit addItem _x;
} forEach ["ACE_packingBandage","ACE_packingBandage","ACE_packingBandage","ACE_packingBandage","ACE_packingBandage","ACE_packingBandage","ACE_packingBandage","ACE_tourniquet","ACE_tourniquet","ACE_morphine","ACE_splint"];