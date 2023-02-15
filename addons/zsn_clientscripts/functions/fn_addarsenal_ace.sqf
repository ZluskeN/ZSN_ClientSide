if (ZSN_AllowArsenal) then {
	params [
		["_box",[cursortarget]],
		["_fact",[faction player]],
		["_ea",[]]
	];
	_uarr = [];
	{
		if ((configName _x) isKindoF "CAManBase") then {
			_uarr pushback (configName _x);
		};
	} forEach ("(getText (_x >> 'faction') in _fact) && (getNumber (_x >> 'scope') > 1)" configClasses (configfile >> "CfgVehicles"));
	{if (_x in _uarr) then {_uarr = _uarr - [_x]} else {_uarr pushback _x;}} foreach _ea;
	_garr = [];
	zsn_buildarray = {
		private _arr = _this;
		{if (typename _x == "ARRAY") then {_x call zsn_buildarray} else {if (typename _x == "STRING" && !(_x in _garr)) then {_garr pushback _x}}} foreach _arr;
	};
	{
		private _lo = getUnitLoadout (configFile >> "CfgVehicles" >> _x);
		_lo call zsn_buildarray;
	} foreach _uarr;
	[_box, _garr] call ace_arsenal_fnc_initBox;
	[_box, player] call ace_arsenal_fnc_openBox;
};