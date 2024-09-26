params ["_unit"];

//while {alive _unit} do {
//	sleep 2;
//	if ("ItemGPS" in assignedItems _unit && ZSN_ShowGPS) then { 
//		ZSN_GPSPOS = createMarkerLocal [format ["%1",random 1000], getPosATL (_unit)];   
//		ZSN_GPSPOS setMarkerShapeLocal "ICON";      
//		ZSN_GPSPOS setMarkerTypeLocal "loc_move"; 
//		ZSN_GPSPOS setMarkerAlphaLocal 0.66;
//		ZSN_GPSPOS setMarkerTextLocal "";
//		_markercolor = switch (side group _unit) do {
//			case west: {"ColorWEST"};
//			case east: {"ColorEAST"};
//			case resistance: {"ColorGUER"};
//			default {"Default"};
//		};
//		ZSN_GPSPOS setMarkerColorLocal _markercolor;  
//		while {"ItemGPS" in assignedItems _unit && ZSN_ShowGPS} do {
//			ZSN_GPSPOS setMarkerPosLocal getPosATL (_unit);
//			ZSN_GPSPOS setMarkerDirLocal (getDir _unit - 180);
//			sleep 0.2;
//		};
//		deleteMarkerLocal ZSN_GPSPOS;
//	};
//};

_handle = [{
	params ["_unit"];
	if ("ItemGPS" in assignedItems _unit && ZSN_ShowGPS) then {
		if (isNil "ZSN_GPSPOS") then {
			ZSN_GPSPOS = createMarkerLocal [format ["%1",random 1000], getPosATL (_unit)];   
			ZSN_GPSPOS setMarkerShapeLocal "ICON";      
			ZSN_GPSPOS setMarkerTypeLocal "loc_move"; 
			ZSN_GPSPOS setMarkerAlphaLocal 0.66;
			ZSN_GPSPOS setMarkerTextLocal "";
			_markercolor = switch (side group _unit) do {
				case west: {"ColorWEST"};
				case east: {"ColorEAST"};
				case resistance: {"ColorGUER"};
				default {"Default"};
			};
			ZSN_GPSPOS setMarkerColorLocal _markercolor; 
		} else {
			ZSN_GPSPOS setMarkerPosLocal getPosATL (_unit);
//			ZSN_GPSPOS setMarkerDirLocal (getDir _unit - 180);
		};
	} else {
		deleteMarkerLocal ZSN_GPSPOS;
	};
}, 0.2, _unit] call CBA_fnc_addPerFrameHandler;

_unit setVariable ["zsn_gpshandler", _handle];
_unit addEventHandler ["Killed", {
	params ["_unit", "_killer", "_instigator", "_useEffects"];
	_handle = _unit getVariable "zsn_gpshandler";
	[_handle] call CBA_fnc_removePerFrameHandler;
}];
//[{!(alive (_this select 0))}, {(_this select 1) call CBA_fnc_deletePerFrameHandlerObject}, [_unit,_handle]] call CBA_fnc_waitUntilAndExecute;