params ["_unit"];
while {alive _unit} do {
	sleep 2;
	if ("ItemGPS" in assignedItems _unit && ZSN_ShowGPS) then { 
		ZSN_GPSPOS = createMarkerLocal [format ["%1",random 1000], getPosATL (_unit)];   
		ZSN_GPSPOS setMarkerShapeLocal "ICON";      
		ZSN_GPSPOS setMarkerTypeLocal "loc_move"; 
		ZSN_GPSPOS setMarkerAlphaLocal 0.5;
		ZSN_GPSPOS setMarkerTextLocal "";
		_markercolor = switch (side group _unit) do {
			case west: {"ColorWEST"};
			case east: {"ColorEAST"};
			case resistance: {"ColorGUER"};
			default {"Default"};
		};
		ZSN_GPSPOS setMarkerColorLocal _markercolor;  
		while {"ItemGPS" in assignedItems _unit && ZSN_ShowGPS} do {
			ZSN_GPSPOS setMarkerPosLocal getPosATL (_unit);
//			ZSN_GPSPOS setMarkerDirLocal (getDir _unit - 180);
			sleep 0.2;
		};
		deleteMarkerLocal ZSN_GPSPOS;
	};
};