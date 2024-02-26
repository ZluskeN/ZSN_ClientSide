params ["_side","_ammo"];

if (_side != "CIV") then {
	_string = "ZSN_" + _ammo + _side;
	_index = {if (_string == _x select 1) exitwith {_foreachIndex}} foreach zsn_ammotypes;
	_value = if (isNil "_index") then {
		_string = createMarker[_string,[0,0,0]];
		_string setMarkerShape "ICON";
		_string setMarkerType "mil_dot_noShadow";
		_markerColor = switch (_side) do {
			case "WEST": {"ColorWEST"};
			case "EAST": {"ColorEAST"};
			case "GUER": {"ColorGUER"};
			default {"Default"};
		};
		_string setMarkerColor _markerColor;
		1
	} else {
		_value = ((zsn_ammotypes select _index) select 0) + 1;
		zsn_ammotypes deleteAt _index;
		_value
	};

	_markertext = _ammo + ": " + str _value;
	[_string, _markertext] remoteExecCall ["setMarkerText"];

	zsn_ammotypes pushback [_value, _string];
	zsn_ammotypes sort false;
	{(_x select 1) setmarkerpos [0, worldSize - (_foreachindex * 100)]} foreach zsn_ammotypes;
};
switch (ZSN_Ammocounters) do {
	case "NONE": {{[_x select 1, 0] remoteExecCall ["setMarkerAlphaLocal"];} foreach zsn_ammotypes};
	case "CIV": {{[_x select 1, 0] remoteExecCall ["setMarkerAlphaLocal", [EAST, WEST, RESISTANCE]]; [_x select 1, 1] remoteExecCall ["setMarkerAlphaLocal", CIVILIAN];} foreach zsn_ammotypes};
	case "ALL": {{[_x select 1, 1] remoteExecCall ["setMarkerAlphaLocal"];} foreach zsn_ammotypes};
};