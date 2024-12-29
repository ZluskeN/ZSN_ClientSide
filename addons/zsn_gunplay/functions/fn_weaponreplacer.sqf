params ["_unit"];

if (typeName ZSN_replaceWeapons == "STRING") then {ZSN_replaceWeapons = call compile ZSN_replaceWeapons};
if (typeName ZSN_replaceweaponswith == "STRING") then {ZSN_replaceweaponswith = call compile ZSN_replaceweaponswith};

if (typeName ZSN_replacemagazines == "STRING") then {ZSN_replacemagazines = call compile ZSN_replacemagazines};
if (typeName ZSN_replacemagazineswith == "STRING") then {ZSN_replacemagazineswith = call compile ZSN_replacemagazineswith};

if (typeName ZSN_replaceattachments == "STRING") then {ZSN_replaceattachments = call compile ZSN_replaceattachments};
if (typeName ZSN_replaceattachmentswith == "STRING") then {ZSN_replaceattachmentswith = call compile ZSN_replaceattachmentswith};

if (isClass(configFile >> "CfgPatches" >> "ZSN_Loadouts")) then {_unit call zsn_fnc_fixMagazines};

_startmags = magazinesAmmo _unit;
_primaryweapon = primaryWeapon _unit;
_primarymagazine = {if (_x select 0 ==  _primaryweapon) exitwith {_x select 4}} foreach weaponsItems _unit;

{
	_mag = _x select 0;
	_magazineindex = {
		_replacemagazinewith = ZSN_replacemagazineswith select _forEachIndex;
		if (_mag isKindOf [_x, configFile >> "CfgMagazines"] && isClass (configFile >> "CfgMagazines" >> _replacemagazinewith)) exitwith {_forEachIndex};
	} foreach ZSN_replacemagazines;
	if (!(isNil "_magazineindex")) then {
		_replacemagazinewith = ZSN_replacemagazineswith select _magazineindex;
		_unit removemagazine _mag;
		_unit addmagazine [_replacemagazinewith, _x select 1];
		_unit setVariable ["ZSN_newprimarymag", _replacemagazinewith];
	};
} foreach _startmags;

_startprimaryammo = 0;
_primarystartmagtypes = [];
if (count _primarymagazine == 2) then {_primarystartmagtypes pushback _primarymagazine};
_compatibleoldprimarymags = [_primaryweapon, true] call CBA_fnc_compatibleMagazines;
{if (_x select 0 in _compatibleoldprimarymags) then {_primarystartmagtypes pushback _x}} foreach _startmags;
{_startprimaryammo = _startprimaryammo + (_x select 1)} foreach _primarystartmagtypes;

_gunindex = {
	_replacewith = ZSN_replaceweaponswith select _forEachIndex;
	if (_primaryweapon isKindOf [_x, configFile >> "CfgWeapons"] && isClass (configFile >> "CfgWeapons" >> _replacewith)) exitwith {_forEachIndex};
} foreach ZSN_replaceWeapons;
_replacewith = ZSN_replaceweaponswith select _gunindex;
_compatiblenewprimarymags = [_replacewith, true] call CBA_fnc_compatibleMagazines;
_replaceprimary = !(isNil "_gunindex");

_primarymagstoreplace = if (_replaceprimary) then {
	_primarymagstoreplace = [];
	{
		if (_x select 0 in _compatibleoldprimarymags && !(_x select 0 in _compatiblenewprimarymags)) then {
			_primarymagstoreplace pushback _x;
			_unit removemagazine (_x select 0);
		};
	} foreach magazinesAmmo _unit;
	_primarymagstoreplace
};

_newprimarymag = _unit getVariable ["ZSN_newprimarymag", _compatiblenewprimarymags select 0];

_handgunweapon = handgunweapon _unit;
_handgunmagazine = {if (_x select 0 ==  _handgunweapon) exitwith {_x select 4}} foreach weaponsItems _unit;
_handgunitems = handgunItems _unit;

_startmagtypes = [];
if (count _handgunmagazine == 2) then {_startmagtypes pushback _handgunmagazine};
_compatibleoldmags = [_handgunweapon, true] call CBA_fnc_compatibleMagazines;
{if (_x select 0 in _compatibleoldmags) then {_startmagtypes pushback _x}} foreach _startmags;

_handgunindex = {
	_replacehandgunwith = ZSN_replaceweaponswith select _forEachIndex;
	if (_handgunweapon isKindOf [_x, configFile >> "CfgWeapons"] && isClass (configFile >> "CfgWeapons" >> _replacehandgunwith)) exitwith {_forEachIndex};
} foreach ZSN_replaceweapons;
_replacehandgunwith = ZSN_replaceweaponswith select _handgunindex;

if (!(isNil "_handgunindex")) then {
	_compatiblenewmags = [_replacehandgunwith, true] call CBA_fnc_compatibleMagazines;
	_newmag = _compatiblenewmags select 0;
	{
		if (_x select 0 in _compatibleoldmags && !(_x select 0 in _compatiblenewmags)) then {
			_unit removemagazine (_x select 0);
			_unit addmagazine [_newmag, (_x select 1)];
		};
	} foreach magazinesAmmo _unit;
	if (count _handgunmagazine == 2) then {
		_magazineindex = {
			_replacemagazinewith = ZSN_replacemagazineswith select _forEachIndex;
			if (_handgunmagazine select 0 isKindOf [_x, configFile >> "CfgMagazines"] && isClass (configFile >> "CfgMagazines" >> _replacemagazinewith)) exitwith {_forEachIndex};
		} foreach ZSN_replacemagazines;
		_replacemagazinewith = if (isNil "_magazineindex") then {
			_newmag
		} else {
			ZSN_replacemagazineswith select _magazineindex
		};
		_unit addmagazine [_replacemagazinewith, _handgunmagazine select 1];
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

_primaryweaponitems = primaryWeaponItems _unit;

if (_replaceprimary) then {
	if (count _primarymagazine == 2) then {
		_unit addmagazine [_newprimarymag, _primarymagazine select 1];
	};
	{_unit addmagazine [_newprimarymag, (_x select 1)]} foreach _primarymagstoreplace;
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

if (_replaceprimary) then {
	while {_unit call zsn_fnc_playerammo < _startprimaryammo && _unit canAdd _newprimarymag} do {
		_unit addmagazine _newprimarymag;
	};
};
