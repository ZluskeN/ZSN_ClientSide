params ["_unit","_target","_selection"];

_sound = selectrandom [
	"A3\Sounds_F\weapons\Grenades\handgrenade_drops\handg_drop_Metal_1.wss",
	"A3\Sounds_F\weapons\Grenades\handgrenade_drops\handg_drop_Metal_2.wss",
	"A3\Sounds_F\weapons\Grenades\handgrenade_drops\handg_drop_Metal_3.wss",
	"A3\Sounds_F\weapons\Grenades\handgrenade_drops\handg_drop_Metal_4.wss",
	"A3\Sounds_F\weapons\Grenades\handgrenade_drops\handg_drop_Metal_5.wss"
];

_selectednade = (currentThrowable _unit select 0);
_nades = ZSN_Grenades arrayintersect (magazines _unit);
_nade = if (_selectednade in ZSN_Grenades) then {_selectednade} else {_nades select 0};
_ammo = getText (configFile >> "CfgMagazines" >> _nade >> "ammo");
playSound3D [_sound, _unit]; 
_livenade = _ammo createVehicle getpos _unit; 
_livenade attachTo [_target, [0, 0, -1], _selection];	
_unit removeMagazine _nade; 
_track = switch (_selection) do {

	case "kolp1": {["hit_trackr_point","hit_trackr"]};
	case "koll1": {["hit_trackl_point","hit_trackl"]};
	case "kolp2": {["hit_trackr_point","hit_trackr"]};
	case "koll2": {["hit_trackl_point","hit_trackl"]};
	case "podkolol3": {["hit_trackl_point", "pas_l"]};
	case "podkolop3": {["hit_trackr_point", "pas_p"]};
	case "sprocket_wheel_1_1": {["hitpoint_track_1"]};
	case "sprocket_wheel_1_2": {["hitpoint_track_2"]};
	case "idler_wheel_1_1": {["hitpoint_track_1"]};
	case "idler_wheel_1_2": {["hitpoint_track_2"]};
	
};
[_livenade, _target, _track, _unit] spawn {waituntil{!alive (_this select 0)}; {(_this select 1) setHit [_x, 1, true, (_this select 3)]} foreach (_this select 2)}; 
[] spawn {ZSN_GrenadeTrack = false; sleep 2; ZSN_GrenadeTrack = true;};


