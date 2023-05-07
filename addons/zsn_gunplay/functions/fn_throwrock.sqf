params ["_unit"];

if (hasInterface) then {
	[{
		_sound = selectrandom [
			"a3\sounds_f_orange\missionsfx\orange_pumpkin_impact_01.wss",
			"a3\sounds_f_orange\missionsfx\orange_pumpkin_impact_02.wss",
			"a3\sounds_f_orange\missionsfx\orange_pumpkin_impact_03.wss",
			"a3\sounds_f_orange\missionsfx\orange_pumpkin_impact_04.wss",
			"a3\sounds_f_orange\missionsfx\orange_pumpkin_impact_05.wss",
			"a3\sounds_f_orange\missionsfx\orange_pumpkin_impact_06.wss",
			"a3\sounds_f_orange\missionsfx\orange_pumpkin_impact_07.wss",
			"a3\sounds_f_orange\missionsfx\orange_pumpkin_impact_08.wss",
			"a3\sounds_f_orange\missionsfx\orange_pumpkin_impact_09.wss",
			"a3\sounds_f_orange\missionsfx\orange_pumpkin_impact_10.wss",
			"a3\sounds_f_orange\missionsfx\orange_pumpkin_impact_11.wss",
			"a3\sounds_f_orange\missionsfx\orange_pumpkin_impact_12.wss"
		];
		PlaySound3D [_sound, player];
		addCamShake [5, 1, 5]; // Shakes the camera for 1 second
		hintSilent format ["%1 Threw a rock at you!", name _this];
		["ace_finger_fingered", [_unit, aimPos _unit, (eyePos player) vectorDistance (aimPos _unit)], [player]] call CBA_fnc_targetEvent;
	}, _unit, 1] call CBA_fnc_waitAndExecute;
};