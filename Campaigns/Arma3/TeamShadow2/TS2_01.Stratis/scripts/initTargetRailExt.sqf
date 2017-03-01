////////////////////////////////////////////////////////////////////////////////////////////////////////
/*  initTargetRailExt.sqf                                   EXTENDED VERSION                          */
/*  by [W] Steffie                                                                                    */
/*  v1.3, 16.02.14                                                                                    */
/*  required: "nopop=true;" in init.sqf                                                               */
/*            PopUpTarget.sqf            v1.0                                                         */
/*            moveTargetRailExt.sqf      v1.0                                                         */
/*                                                                                                    */
/*  Description:                                                                                      */
/*    This script automatically builds an Popup Target rail                                           */
/*    First Rail segment is used to place startpoint of railway. All other parts are built auto-      */
/*    matically. Movement of the target is controlled by movement-array.                              */
/*    It's possible to start movement by connecting a trigger.                                        */
/*                                                                                                    */
/*  Usage:                                                                                                     */
/*    Target = [Rail,Segm,Dir,Type[Spd,Times,Delay,Downtime,Start,Reset]] execVM "scripts\initTargetRail.sqf"; */
/*                                                                                                             */
/*  Parameters:                                                                                       */
/*    Rail:      Object - First rail segment, sets position an direction of track     ObjVar "_base"  */
/*    Segments:  Number - Count of total segments of rail (1m per Segment)                            */
/*    Direction: Number - 0 to 3, Direction target faces relatively to rail.                          */
/*                        Target starts on 1st rail. Rail 90 deg clockwise.                           */
/*    Type:      Number - Type of Target on Rail an Accuracy feature (2 digits)                       */
/*    Speed:     Number - Speed of target in m/s.                                                     */
/*    Times:     Number - Times the target passes the rail, 2 means to and back, -1 endless           */
/*    Delay:     Number - Time the target rest at the end of the rails.                               */
/*    Downtime:  Number - Time before Target popping up again (-1 means stay down)                    */
/*    Start:     Object - Trigger, Target sleeps until Trigger fires. No Trigger: objNull             */
/*                                                                                                    */
/*  Examples:                                                                                         */
/*    null = [RL_1,3,0,11[5,2,2,4,trgDoor_1]] execVM "scripts\initTargetRail.sqf";                    */
/*    Short Rail that pops in when triggered, stays 2 sec and pops back. Perfect for doors and windows*/
/*                                                                                                    */
/*    null = [RL_2,8,0,12[3,-1,0,-1,objNull]] execVM "scripts\initTargetRail.sqf";                    */
/*    Target moves permanently, good for Sniper practice.                                             */
/*                                                                                                    */
/*    T_1 = [RL_3,5,3,21[10,1,0,-1,trgDoor_2]] execVM "scripts\initTargetRail.sqf";                   */
/*    Target fast moving forward, good surprise in Kill houses                                        */
/*                                                                                                    */
/*  Helper Type:                                                                                      */
/*    first digit:  Target Type (Moving Target 1 to 3 and Zombie)                                     */
/*    second digit: Accuracy Type (none, accuracy aim, zones)                                         */
/*                                                                                                    */
/*    23 means using Moving Target 2 with Zones     10 uses Moving Target 1 plain                     */
/*    default: 10                                                                                     */
/*                                                                                                    */
/*  Helper Directions:                                                                                */
/*    0) v------   1) <------   2) A------   3) >------   initial direction of 1st rail part is top   */
/*         right     backward         left      forward                                               */
/*                                                                                                    */
/*  Reset nopop-targets:  by Variable Stef_targets_reset      (probably only works with times: -1)    */
/*                                                                                                    */
////////////////////////////////////////////////////////////////////////////////////////////////////////


// reading parameters
_frstRail = _this select 0;    // Object - first rail segment
_Seg = _this select 1;         // Number - number of total rail sections
_targetDir = _this select 2;   // Number - direction the target will face
_type = _this select 3;        // Number - Type of Target on Rail
_moveArr = _this select 4;      // Array  - array that describes type of movement the target will perform.
_target = objNull;             // Object - Movable target
_railArr = [];                 // Array  - Contains all used objects
_downTime = _moveArr select 3;  // Bool   - target will popup on true  (saved as objVar "_nopop")

// building rails

_initPos = getPos _frstRail;
_aktRail = "Target_Rail_End_F" createVehicle _initPos; // beginning
_aktRail attachTo [_frstRail,[-0.53,0,0]];
_railArr = [_aktRail,_frstRail];

for [{_x=1},{_x<_Seg},{_x=_x+1}] do {                  // rail parts
  _aktRail = "Target_Rail_F" createVehicle _initPos;
  _aktRail attachTo [_frstRail,[_x,0,0]];
  _railArr = _railArr + [_aktRail];
};

_aktRail = "Target_Rail_End_F" createVehicle _initPos; // ending
_aktRail attachTo [_frstRail,[(_Seg - 0.53),0,0]];
_railArr = _railArr + [_aktRail];

// Target_PopUp2_Moving_90deg_F // Target_PopUp2_Moving_90deg_Acc2_F // Target_PopUp2_Moving_90deg_Acc1_F

_type1 = floor (_type / 10);
_type2 = _type mod 10;

// Set type of target texture
_typeStr = switch (_type1) do {
  case 1: {_accStr = "Target_PopUp_Moving"; _accStr};
  case 2: {_accStr = "Target_PopUp2_Moving"; _accStr};
  case 3: {_accStr = "Target_PopUp3_Moving"; _accStr};
  case 4: {_accStr = "Zombie_PopUp_Moving"; _accStr};
  default {_accStr = "Target_PopUp_Moving"; _accStr};
};

// Set Accuracy texture
_accStr = switch (_type2) do {
  case 0: {_accStr = ""; _accStr};
  case 1: {_accStr = "_Acc1"; _accStr};
  case 2: {_accStr = "_Acc2"; _accStr};
  default {_accStr = ""; _accStr};
};

_target = switch (_targetDir) do {
  case 0: // Target moves right
  {
    _target = (_typeStr + _accStr + "_F") createVehicle _initPos;
    _target setPos (_frstRail modelToWorld [-0.1,0,-0.10]);
    _target setDir (getDir _frstRail); _target
  };
  case 2: // Target moves backward
  {
    _target = (_typeStr + _accStr + "_F") createVehicle _initPos;
    _target setPos (_frstRail modelToWorld [-0.1,0,-0.10]);
    _target setDir (getDir _frstRail -180); _target
  };
  case 1: // Target moves left
  {
    _target = (_typeStr + "_90deg" + _accStr + "_F") createVehicle _initPos;
    _target setPos (_frstRail modelToWorld [-0.1,0,-0.10]);
    _target setDir (getDir _frstRail + 90); _target
  };
  case 3: // Target moves forward
  {
    _target = (_typeStr + "_90deg" + _accStr + "_F") createVehicle _initPos;
    _target setPos (_frstRail modelToWorld [-0.1,0,-0.10]);
    _target setDir (getDir _frstRail - 90); _target
  };
};

// Object Variables
_target setVariable ["_downTime", _downTime, true];
_target setVariable ["_down", false, true];
_target setVariable ["_base", _frstRail, true];
_target setVariable ["_objArr", _railArr, true];

_move = [_moveArr,_seg,_target] execVM "scripts\moveTargetRailExt.sqf";

_target // return value is object Target, frstRail is objVar "_base"
        //                                all objects in objVar "_objArr"

