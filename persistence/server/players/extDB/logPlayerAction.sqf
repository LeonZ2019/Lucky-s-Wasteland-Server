// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2015 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: logPlayerAction.sqf
//	@file Author: Leon

#define FILTERED_CHARS [58] // colon

params ["_playerUID", "_playerName", "_side", "_actionType", "_target", "_value", "_position", "_extra", "_remarks"];

[format ["addPlayerLog:%1:%2:%3:%4:%5:%6:%7:%8:%9:%10", call A3W_extDB_ServerID, _playerUID, toString (toArray _playerName - FILTERED_CHARS), _side, _actionType, toString (toArray _target - FILTERED_CHARS), str _value, str _position, _extra, toString (toArray _remarks - FILTERED_CHARS)]] call extDB_Database_async;
