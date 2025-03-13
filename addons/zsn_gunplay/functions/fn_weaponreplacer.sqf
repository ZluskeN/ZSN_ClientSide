params ["_unit"];

if (typeName ZSN_replaceWeapons == "STRING") then {ZSN_replaceWeapons = call compile ZSN_replaceWeapons};
if (typeName ZSN_replaceweaponswith == "STRING") then {ZSN_replaceweaponswith = call compile ZSN_replaceweaponswith};

if (typeName ZSN_replacemagazines == "STRING") then {ZSN_replacemagazines = call compile ZSN_replacemagazines};
if (typeName ZSN_replacemagazineswith == "STRING") then {ZSN_replacemagazineswith = call compile ZSN_replacemagazineswith};

if (typeName ZSN_replaceattachments == "STRING") then {ZSN_replaceattachments = call compile ZSN_replaceattachments};
if (typeName ZSN_replaceattachmentswith == "STRING") then {ZSN_replaceattachmentswith = call compile ZSN_replaceattachmentswith};

_startmags = magazinesAmmo _unit;
_primarygun = primaryWeapon _unit;
_primarymagazine = {if (_x select 0 ==  _primarygun) exitwith {_x select 4}} foreach weaponsItems _unit;

{
	_mag = _x select 0;
	_magazineindex = {
		_replacemagazinewith = ZSN_replacemagazineswith select _forEachIndex;
		if (_mag == _x && isClass (configFile >> "CfgMagazines" >> _replacemagazinewith)) exitwith {_forEachIndex};
	} foreach ZSN_replacemagazines;
	if (!(isNil "_magazineindex")) then {
		_replacemagazinewith = ZSN_replacemagazineswith select _magazineindex;
		_unit removemagazine _mag;
		_unit addmagazine [_replacemagazinewith, _x select 1];
	};
} foreach _startmags;

_startprimaryammo = 0;
_primarystartmagtypes = [];
if (count _primarymagazine == 2) then {_primarystartmagtypes pushback _primarymagazine};
_compatibleoldprimarymags = [_primarygun, true] call CBA_fnc_compatibleMagazines;
{if (_x select 0 in _compatibleoldprimarymags) then {_primarystartmagtypes pushback _x}} foreach _startmags;
{_startprimaryammo = _startprimaryammo + (_x select 1)} foreach _primarystartmagtypes;

_replacewith = {
	_replacewith = ZSN_replaceweaponswith select _forEachIndex;
	if (_primarygun isKindOf [_x, configFile >> "CfgWeapons"] && isClass (configFile >> "CfgWeapons" >> _replacewith)) exitwith {_replacewith};
} foreach ZSN_replaceWeapons;
_compatiblenewprimarymags = [_replacewith, true] call CBA_fnc_compatibleMagazines;
_replaceprimary = !(isNil "_replacewith");

if (_replaceprimary) then {
	{
		if (_x select 0 in _compatibleoldprimarymags && !(_x select 0 in _compatiblenewprimarymags)) then {
			_unit removemagazine (_x select 0);
		};
	} foreach magazinesAmmo _unit;
};

_primarymagsininventory = [];
_compatiblenewprimarymuzzlemags = _replacewith call CBA_fnc_compatibleMagazines;
{if (_x in _compatiblenewprimarymuzzlemags) then {_primarymagsininventory pushback _x}} foreach (magazines _unit);
_consolidatedprimarymagsininventory = _primarymagsininventory call BIS_fnc_consolidateArray;
_sortedprimarymagsininventory = [_consolidatedprimarymagsininventory, [], {_x select 1}, "DESCEND"] call BIS_fnc_sortBy;
_newprimarymag = if (count _sortedprimarymagsininventory > 0) then {_sortedprimarymagsininventory select 0 select 0} else {_compatiblenewprimarymags select 0};

_handgunweapon = handgunweapon _unit;
_handgunmagazine = {if (_x select 0 ==  _handgunweapon) exitwith {_x select 4}} foreach weaponsItems _unit;
_handgunitems = handgunItems _unit;

_handgunindex = {
	_replacehandgunwith = ZSN_replaceweaponswith select _forEachIndex;
	if (_handgunweapon isKindOf [_x, configFile >> "CfgWeapons"] && isClass (configFile >> "CfgWeapons" >> _replacehandgunwith)) exitwith {_forEachIndex};
} foreach ZSN_replaceweapons;
_replacehandgunwith = ZSN_replaceweaponswith select _handgunindex;

if (!(isNil "_handgunindex")) then {
	_compatibleoldmags = [_handgunweapon, true] call CBA_fnc_compatibleMagazines;
	_compatiblenewmags = [[_replacehandgunwith, true] call CBA_fnc_compatibleMagazines, [_handgunmagazine select 1], {_num = (getNumber (configFile >> "CfgMagazines" >> _x >> "count")) - _input0; if (_num > 0) then {_num - 1} else {_num * (-1)}}] call BIS_fnc_sortBy;
	_replacemagazinewith = if (count _handgunmagazine == 2) then {
		_replacement = {
			_mag = ZSN_replacemagazineswith select _forEachIndex;
			if (_handgunmagazine select 0 == _x && isClass (configFile >> "CfgMagazines" >> _replacemagazinewith)) exitwith {_mag};
		} foreach ZSN_replacemagazines;
		if (isNil "_replacement") then {
			if (_handgunmagazine select 0 in _compatiblenewmags) then {_handgunmagazine select 0} else {_compatiblenewmags select 0};
		} else {
			_replacement
		};
	} else {_compatiblenewmags select 0};
	{
		if (_x select 0 in _compatibleoldmags && !(_x select 0 in _compatiblenewmags)) then {
			_unit removemagazine (_x select 0);
			_unit addmagazine [_replacemagazinewith, (_x select 1)];
		};
	} foreach magazinesAmmo _unit;
	_unit addWeaponGlobal _replacehandgunwith;
	_unit addmagazine [_replacemagazinewith, _handgunmagazine select 1];

	_oldmag = getarray (configFile >> "cfgWeapons" >> _handgunweapon >> "magazines") select 0; 
	_oldammo = getText (configFile >> "cfgMagazines" >> _oldmag >> "ammo"); 
	_oldammoNoise = getNumber (configFile >> "cfgAmmo" >> _oldammo >> "audibleFire");

	_newammo = getText (configFile >> "cfgMagazines" >> _replacemagazinewith >> "ammo"); 
	_newammoNoise = getNumber (configFile >> "cfgAmmo" >> _newammo >> "audibleFire");

	if ((HandgunItems _unit select 0 == "" && (_handgunItems select 0) != "") || (_oldammoNoise < _newammoNoise)) then {
		_unit addHandgunItem (_handgunitems select 0);
		if (handgunItems _unit select 0 == "") then {	
			_items = compatibleItems [_replacehandgunwith, "MuzzleSlot"]; 
			_item = _items select (_items findIf {getNumber (configFile >> "cfgWeapons" >> _x >> "ItemInfo" >> "AmmoCoef" >> "audibleFire") < _newammoNoise});
			_unit addHandgunItem _item;
		};
	};
	if (HandgunItems _unit select 1 == "" && (_handgunItems select 1) != "") then {
		_unit addHandgunItem (_handgunitems select 1);
		if (handgunItems _unit select 1 == "") then {
			_item = compatibleItems [_replacehandgunwith, "PointerSlot"] select 0;
			_unit addHandgunItem _item;
		};
	};
	if (HandgunItems _unit select 2 == "" && (_handgunitems select 2) != "") then {
		_unit addHandgunItem (_handgunitems select 2);
		if (handgunItems _unit select 2 == "") then {
			_item = compatibleItems [_replacehandgunwith, "CowsSlot"] select 0;
			_unit addHandgunItem _item;
		};
	};
	if (HandgunItems _unit select 3 == "" && (_handgunItems select 3) != "") then {
		_unit addHandgunItem (_handgunitems select 3);
		if (handgunItems _unit select 3 == "") then {
			_item = compatibleItems [_replacehandgunwith, "UnderBarrelSlot"] select 0;
			_unit addHandgunItem _item;
		};
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
		_unit addmagazine _newprimarymag;
	};

	_unit addWeaponGlobal _replacewith;
	_unit selectWeapon _replacewith;
	
	_count = (_startprimaryammo - (_unit call zsn_fnc_playerammo));
	while {_count > 0 && _unit canAdd _newprimarymag} do {
		_unit addmagazine [_newprimarymag, _count];
		_count = (_startprimaryammo - (_unit call zsn_fnc_playerammo));
	};

	_oldmag = getarray (configFile >> "cfgWeapons" >> _primarygun >> "magazines") select 0; 
	_oldammo = getText (configFile >> "cfgMagazines" >> _oldmag >> "ammo"); 
	_oldammoNoise = getNumber (configFile >> "cfgAmmo" >> _oldammo >> "audibleFire");

	_newammo = getText (configFile >> "cfgMagazines" >> _newprimarymag >> "ammo"); 
	_newammoNoise = getNumber (configFile >> "cfgAmmo" >> _newammo >> "audibleFire");

	if ((_primaryweaponitems select 0 != "" && primaryWeaponItems _unit select 0 == "") || (_oldammoNoise < _newammoNoise)) then {
		_unit addPrimaryWeaponItem (_primaryweaponitems select 0);
		if (primaryWeaponItems _unit select 0 == "") then {
			_items = compatibleItems [_replacewith, "MuzzleSlot"]; 
			_item = _items select (_items findIf {getNumber (configFile >> "cfgWeapons" >> _x >> "ItemInfo" >> "AmmoCoef" >> "audibleFire") < _newammoNoise});
			_unit addPrimaryWeaponItem _item;
		};
	};
	if (_primaryWeaponItems select 1 != "" && primaryWeaponItems _unit select 1 == "") then {
		_unit addPrimaryWeaponItem (_primaryweaponitems select 1);
		if (primaryWeaponItems _unit select 1 == "") then {
			_item = compatibleItems [_replacewith, "PointerSlot"] select 0;
			_unit addPrimaryWeaponItem _item;
		};
	};
	if (_primaryWeaponItems select 2 != "" && primaryWeaponItems _unit select 2 == "") then {
		_unit addPrimaryWeaponItem (_primaryweaponitems select 2);
		if (primaryWeaponItems _unit select 2 == "") then {
			_item = compatibleItems [_replacewith, "CowsSlot"] select 0;
			_unit addPrimaryWeaponItem _item;
		};
	};
	
	_oldbipod = getnumber (configFile >> "cfgWeapons" >> _primarygun >> "hasbipod") == 1;
	_newbipod = getnumber (configFile >> "cfgWeapons" >> _replacewith >> "hasbipod") == 1;

	if ((_primaryWeaponItems select 3 != "" || _oldbipod) && (primaryWeaponItems _unit select 3 == "" ||  !_newbipod)) then {
		_unit addPrimaryWeaponItem (_primaryweaponitems select 3);
		if (primaryWeaponItems _unit select 3 == "") then {
			_item = compatibleItems [_replacewith, "UnderBarrelSlot"] select 0;
			_unit addPrimaryWeaponItem _item;
		};
	};
};

_primaryweaponitems = primaryWeaponItems _unit;

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
