params ["_unit"];

if (typeName ZSN_replaceWeapons == "STRING") then {ZSN_replaceWeapons = call compile ZSN_replaceWeapons};
if (typeName ZSN_replaceweaponswith == "STRING") then {ZSN_replaceweaponswith = call compile ZSN_replaceweaponswith};

if (typeName ZSN_replacemagazines == "STRING") then {ZSN_replacemagazines = call compile ZSN_replacemagazines};
if (typeName ZSN_replacemagazineswith == "STRING") then {ZSN_replacemagazineswith = call compile ZSN_replacemagazineswith};

if (typeName ZSN_replaceattachments == "STRING") then {ZSN_replaceattachments = call compile ZSN_replaceattachments};
if (typeName ZSN_replaceattachmentswith == "STRING") then {ZSN_replaceattachmentswith = call compile ZSN_replaceattachmentswith};

if (isClass(configFile >> "CfgPatches" >> "ZSN_Loadouts")) then {_unit call zsn_fnc_fixMagazines};

_startmags = magazinesAmmo _unit;

{
	_mag = _x select 0;
	_magazineindex = {
		_replacemagazinewith = ZSN_replacemagazineswith select _forEachIndex;
		if (_mag isKindOf [_x, configFile >> "CfgMagazines"] && isClass (configFile >> "CfgMagazines" >> _replacemagazinewith)) exitwith {_forEachIndex};
	} foreach ZSN_replacemagazines;
	_replacemagazinewith = ZSN_replacemagazineswith select _magazineindex;
	if (!(isNil "_magazineindex")) then {
		_unit removemagazine _mag;
		_unit addmagazine [_replacemagazinewith, _x select 1];
	};
} foreach _startmags;

_primaryweapon = primaryWeapon _unit;
_primarymagazine = {if (_x select 0 ==  _primaryweapon) exitwith {_x select 4}} foreach weaponsItems _unit;
_primaryweaponitems = primaryWeaponItems _unit;

_gunindex = {
	_replacewith = ZSN_replaceweaponswith select _forEachIndex;
	if (_primaryweapon isKindOf [_x, configFile >> "CfgWeapons"] && isClass (configFile >> "CfgWeapons" >> _replacewith)) exitwith {_forEachIndex};
} foreach ZSN_replaceWeapons;
_replacewith = ZSN_replaceweaponswith select _gunindex;
_replaceprimary = !(isNil "_gunindex");
_compatibleoldprimarymags = [_primaryweapon, true] call CBA_fnc_compatibleMagazines;
_compatiblenewprimarymags = [_replacewith, true] call CBA_fnc_compatibleMagazines;
_startprimaryammo = 0;
_primarystartmagtypes = [];
if (count _primarymagazine == 2) then {_primarystartmagtypes pushback _primarymagazine};
{if (_x select 0 in _compatibleoldprimarymags) then {_primarystartmagtypes pushback _x}} foreach _startmags;
{_startprimaryammo = _startprimaryammo + (_x select 1)} foreach _primarystartmagtypes;
_compatibleprimarymags = if (_replaceprimary) then {
	_compatiblenewprimarymags
} else {
	_compatibleoldprimarymags
};
_oldprimarymag = if (str _primarymagazine != "[]") then {_primarymagazine select 0} else {_primarystartmagtypes select 1 select 0};
_magazineindex = {
	_replacemagazinewith = ZSN_replacemagazineswith select _forEachIndex;
	if (_oldprimarymag isKindOf [_x, configFile >> "CfgMagazines"] && isClass (configFile >> "CfgMagazines" >> _replacemagazinewith)) exitwith {_forEachIndex};
} foreach ZSN_replacemagazines;
_replacemagazinewith = ZSN_replacemagazineswith select _magazineindex;
_newprimarymag = if (!(isNil "_magazineindex")) then {
	_replacemagazinewith
} else {
	if (_oldprimarymag in _compatibleprimarymags) then {
		_oldprimarymag
	} else {
		_oldcount = getNumber (configFile >> "CfgMagazines" >> _oldprimarymag >> "count");
		_compatibleprimarymags = [_compatibleprimarymags, [], {getNumber (configFile >> "CfgMagazines" >> _x >> "count")}, "DESCEND"] call BIS_fnc_sortBy;
		{if (getNumber (configFile >> "CfgMagazines" >> _x >> "count") <= _oldcount) exitWith {_x}} foreach _compatibleprimarymags;
	}; 
}; 

if (_replaceprimary) then {
	{
		_unit removemagazine (_x select 0);
	} foreach _primarystartmagtypes;
	if (str _primarymagazine != "[]") then {
		_unit addmagazine [_newprimarymag, _primarymagazine select 1];
	};
	_unit addWeaponGlobal _replacewith;
	_unit selectWeapon _replacewith;
	_unit addPrimaryWeaponItem (_primaryweaponitems select 0);
	if ((_primaryweaponitems select 0) != (primaryWeaponItems _unit select 0)) then {
		_item = compatibleItems [_replacewith, "MuzzleSlot"] select 0;
		_unit addPrimaryWeaponItem _item;
	};
	_unit addPrimaryWeaponItem (_primaryweaponitems select 1);
	if ((_primaryweaponitems select 1) != (primaryWeaponItems _unit select 1)) then {
		_item = compatibleItems [_replacewith, "PointerSlot"] select 0;
		_unit addPrimaryWeaponItem _item;
	};
	_unit addPrimaryWeaponItem (_primaryweaponitems select 2);
	if ((_primaryweaponitems select 2) != (primaryWeaponItems _unit select 2)) then {
		_item = compatibleItems [_replacewith, "CowsSlot"] select 0;
		_unit addPrimaryWeaponItem _item;
	};
	_unit addPrimaryWeaponItem (_primaryweaponitems select 3);
	if ((_primaryweaponitems select 3) != (primaryWeaponItems _unit select 3)) then {
		_item = compatibleItems [_replacewith, "UnderBarrelSlot"] select 0;
		_unit addPrimaryWeaponItem _item;
	};
} else {
	if (str _primarymagazine != "[]") then {
		//_unit addmagazine [_newprimarymag, (_primarymagazine select 1)];
		//_unit removePrimaryWeaponItem (_primarymagazine select 0);
		_unit addWeaponItem [_primaryweapon, [_newprimarymag, (_primarymagazine select 1)], true];
		//_unit addPrimaryWeaponItem _newprimarymag;
	};
};

{
	_attachment = _x;
	_attachmentindex = {
		_replacement = ZSN_replaceattachmentswith select _forEachIndex;
		if (_attachment isKindOf [_x, configFile >> "CfgWeapons"] && isClass (configFile >> "CfgWeapons" >> _replacement)) exitwith {_forEachIndex};
	} foreach ZSN_replaceattachments;
	_replacement = ZSN_replaceattachmentswith select _attachmentindex;
	if (!(isNil "_attachmentindex")) then {
		_unit addPrimaryWeaponItem _replacement;
	};
} foreach _primaryweaponitems;

_handgunweapon = handgunweapon _unit;
_handgunmagazine = {if (_x select 0 ==  _handgunweapon) exitwith {_x select 4}} foreach weaponsItems _unit;
_handgunitems = handgunItems _unit;

_handgunindex = {
	_replacehandgunwith = ZSN_replaceweaponswith select _forEachIndex;
	if (_handgunweapon isKindOf [_x, configFile >> "CfgWeapons"] && isClass (configFile >> "CfgWeapons" >> _replacehandgunwith)) exitwith {_forEachIndex};
} foreach ZSN_replaceweapons;
_replacehandgunwith = ZSN_replaceweaponswith select _handgunindex;
_replacehandgun = !(isNil "_handgunindex");
_compatibleoldmags = [_handgunweapon, true] call CBA_fnc_compatibleMagazines;
_compatiblenewmags = [_replacehandgunwith, true] call CBA_fnc_compatibleMagazines;
_startmagtypes = [];
if (count _handgunmagazine == 2) then {_startmagtypes pushback _handgunmagazine};
{if (_x select 0 in _compatibleoldmags) then {_startmagtypes pushback _x}} foreach _startmags;
_compatiblemags = if (_replacehandgun) then {
	_compatiblenewmags
} else {
	_compatibleoldmags
};
_oldmag = if (str _handgunmagazine != "[]") then {_handgunmagazine select 0} else {_startmagtypes select 1 select 0};
_magazineindex = {
	_replacemagazinewith = ZSN_replacemagazineswith select _forEachIndex;
	if (_oldmag isKindOf [_x, configFile >> "CfgMagazines"] && isClass (configFile >> "CfgMagazines" >> _replacemagazinewith)) exitwith {_forEachIndex}
} foreach ZSN_replacemagazines;
_replacemagazinewith = ZSN_replacemagazineswith select _magazineindex;
_newmag = if (!(isNil "_magazineindex")) then {
	_replacemagazinewith
} else {
	if (_oldmag in _compatiblemags) then {
		_oldmag
	} else {
		_compatiblemags select 0
	}; 
};

if (_replacehandgun) then {
	{
		_unit removemagazine (_x select 0);
		_unit addmagazine [_newmag, (_x select 1)];
	} foreach _startmagtypes;
	if (str _handgunmagazine != "[]") then {
		_unit addmagazine [_newmag, _handgunmagazine select 1];
	};
	_unit addWeaponGlobal _replacehandgunwith;
	_unit addHandgunItem (_handgunitems select 0);
	if ((_handgunitems select 0) != (handgunItems _unit select 0)) then {
		_item = compatibleItems [_replacehandgunwith, "MuzzleSlot"] select 0;
		_unit addHandgunItem _item;
	};
	_unit addHandgunItem (_handgunitems select 1);
	if ((_handgunitems select 1) != (handgunItems _unit select 1)) then {
		_item = compatibleItems [_replacehandgunwith, "PointerSlot"] select 0;
		_unit addHandgunItem _item;
	};
	_unit addHandgunItem (_handgunitems select 2);
	if ((_handgunitems select 2) != (handgunItems _unit select 2)) then {
		_item = compatibleItems [_replacehandgunwith, "CowsSlot"] select 0;
		_unit addHandgunItem _item;
	};
	_unit addHandgunItem (_handgunitems select 3);
	if ((_handgunitems select 3) != (handgunItems _unit select 3)) then {
		_item = compatibleItems [_replacehandgunwith, "UnderBarrelSlot"] select 0;
		_unit addHandgunItem _item;
	};
} else {
	if (str _handgunmagazine != "[]") then {
		//_unit addmagazine [_newmag, (_handgunmagazine select 1)];
		//_unit removeHandgunItem (_handgunmagazine select 0);
		_unit addWeaponItem [_handgunweapon, [_newmag, (_handgunmagazine select 1)], true];
		//_unit addHandgunItem _newmag;
	}
};

{
	_attachment = _x;
	_attachmentindex = {
		_replacement = ZSN_replaceattachmentswith select _forEachIndex;
		if (_attachment isKindOf [_x, configFile >> "CfgWeapons"] && isClass (configFile >> "CfgWeapons" >> _replacement)) exitwith {_forEachIndex}
	} foreach ZSN_replaceattachments;
	_replacement = ZSN_replaceattachmentswith select _attachmentindex;
	if (!(isNil "_attachmentindex")) then {
		_unit addHandgunItem _replacement;
	};
} foreach _handgunitems;

if (_replaceprimary) then {
	while {_unit call zsn_fnc_playerammo < _startprimaryammo && _unit canAdd _newprimarymag} do {
		_unit addmagazine _newprimarymag;
	};
};
