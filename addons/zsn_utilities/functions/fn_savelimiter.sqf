ZSN_manualSaved = false;
ZSN_allowSave = true;

[missionNamespace, "OnGameInterrupt", {
	params ["_display","_btnSave"];
	_btnSave = _display displayCtrl 103;
	if (ZSN_LimitSaves) then {
		if (ZSN_allowSave) then {
			//_btnsave ctrlEnable true;
			_btnSave ctrlAddEventHandler ["ButtonClick",{
				ZSN_manualSaved = true;
			}];
		} else {
			_handle = [{(_this select 0) ctrlEnable false}, 0.1, _btnSave] call CBA_fnc_addPerFrameHandler;
			[{isNull (findDisplay 49)}, {[_this] call CBA_fnc_removePerFrameHandler}, _handle] call CBA_fnc_waitUntilAndExecute;
		};
	};
}] call BIS_fnc_addScriptedEventHandler;

[missionNamespace, "OnSaveGame", {
	if (ZSN_LimitSaves) then {
		if (ZSN_manualSaved) then {ZSN_allowSave = false} else {ZSN_allowSave = true};
		ZSN_manualSaved = false;
	};
}] call BIS_fnc_addScriptedEventHandler;