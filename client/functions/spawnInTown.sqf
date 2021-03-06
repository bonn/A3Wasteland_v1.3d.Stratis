// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.1
//	@file Name: spawnInTown.sqf
//	@file Author: [404] Deadbeat, [404] Costlyy, [GoT] JoSchaap, AgentRev
//	@file Created: 20/11/2012 05:19
//	@file Args:

private ["_marker", "_preload", "_pos", "_rad", "_townName", "_playerPos","_beacon","_supporterLevel"];


_marker = _this select 0;
_preload = param [1, false, [false]];

_height = (["A3W_spawnBeaconSpawnHeight", 0] call getPublicVar) max 0;
{
	if (_x select 0 == _marker) exitWith
	{
		_pos = getMarkerPos _marker;
		_rad = _x select 1;
		_townName = _x select 2;

		_playerPos = [_pos select 0, _pos select 1, _height];
		
		if (_preload) then { waitUntil {sleep 0.1; preloadCamera _playerPos} };

		waitUntil {!isNil "bis_fnc_init" && {bis_fnc_init}};

		player setPos _playerPos;
	};
} forEach (call cityList);

player setVariable [_marker + "_lastSpawn", diag_tickTime];

respawnDialogActive = false;
closeDialog 0;

_townName spawn
{
	_townName = _this;
	sleep 1;

	_hour = date select 3;
	_mins = date select 4;
	["Wasteland", _townName, format ["%1:%3%2", _hour, _mins, if (_mins < 10) then {"0"} else {""}]] spawn BIS_fnc_infoText;
};



