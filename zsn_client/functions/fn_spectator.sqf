params ["_delay","_mytime"];
sleep random 3;
_delay = ZSN_SpectatorTimer;
_mytime = time + _delay;
if (_delay == 0) exitwith {};
waituntil {lifestate player != "INCAPACITATED" OR time >= _mytime};
if (lifestate player == "INCAPACITATED") then {
	titleText ["", "BLACK OUT"];
	["Initialize",[player, [playerside], false, false, true, true, true, true, true, true]] remoteexec ["BIS_fnc_EGSpectator", player];
	titleText ["", "BLACK IN"];
	waituntil {lifestate player != "INCAPACITATED"};
	titleText ["", "BLACK OUT"];
	["Terminate"] remoteexec ["BIS_fnc_EGSpectator", player];
	titleText ["", "BLACK IN"];
};