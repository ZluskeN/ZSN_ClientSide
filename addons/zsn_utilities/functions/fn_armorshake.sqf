params ["_unit"];

//while {alive _unit} do {
//	_shake = 0;
//	_nearbyvehicles = _unit nearEntities [["Tank"], 1000];
//	_nearbytanks = [_nearbyvehicles, [_unit], {_unit distance _x}, "ASCEND", {speed _x != 0}] call BIS_fnc_sortBy;
//	if ((count _nearbytanks > 0 && isNull objectParent _unit) && ZSN_Armorshake) then {
//		{
//			_mass = getMass _x;
//			_dist = _unit distance _x;
//			_num = (_mass/_dist)/20000;
//			_shake = _shake + _num;
//		} foreach _nearbytanks;
//		if (_shake > 0.1) then {addCamShake [_shake, 3, 20]};
//	};
//	sleep 1;
//};

_handle = [{
	params ["_unit"];
	_shake = 0;
	_nearbyvehicles = _unit nearEntities [["Tank"], 1000];
	_nearbytanks = [_nearbyvehicles, [_unit], {_unit distance _x}, "ASCEND", {speed _x != 0}] call BIS_fnc_sortBy;
	if ((count _nearbytanks > 0 && isNull objectParent _unit) && ZSN_Armorshake) then {
		{
			_mass = getMass _x;
			_dist = _unit distance _x;
			_num = (_mass/_dist)/20000;
			_shake = _shake + _num;
		} foreach _nearbytanks;
		if (_shake > 0.1) then {addCamShake [_shake, 3, 20]};
	};
}, 1, _unit] call CBA_fnc_addPerFrameHandler;

_unit setVariable ["zsn_shakehandler", _handle];
_unit addEventHandler ["Killed", {
	params ["_unit", "_killer", "_instigator", "_useEffects"];
	_handle = _unit getVariable "zsn_shakehandler";
	[_handle] call CBA_fnc_removePerFrameHandler;
}];

//[{!(alive (_this select 0))}, {(_this select 1) call CBA_fnc_deletePerFrameHandlerObject}, [_unit,_handle]] call CBA_fnc_waitUntilAndExecute;