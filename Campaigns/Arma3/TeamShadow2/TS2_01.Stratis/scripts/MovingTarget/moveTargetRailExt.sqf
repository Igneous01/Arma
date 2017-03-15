
////////////////////////////////////////////////////////////////////////////////////////////////////////
/*  moveTargetRailExt.sqf                                                                             */
/*  by [W] Steffie                                                                                    */
/*  v1.3, 16.02.14                                                                                    */
/*  required: "nopop=true;" in init.sqf                                                               */
/*            PopUpTarget.sqf            v1.0                                                         */
/*            initTargetRailExt.sqf      v1.3                                                         */
/*                                                                                                    */
/*  [[speed,times,delay,nopop,start,reset],segmets,target]                                            */
/*                                                                                                    */
/*  Description:                                                                                      */
/*    This script automatically builds an Popup Target rail                                           */
/*    First Rail segment is used to place startpoint of railway. All other parts are built auto-      */
/*    matically. Movement of the target is controlled by movement-array.                              */
/*    It's possible to start movement by connecting a trigger.                                        */
/*                                                                                                    */
/*  more Information in initTargetRailExt.sqf                                                         */
/*                                                                                                    */
////////////////////////////////////////////////////////////////////////////////////////////////////////

// reading parameters
_movArr = _this select 0;      // Array  - array that describes type of movement the target will perform.
_Seg = _this select 1;         // Number - number of total rail sections
_target = _this select 2;      // Number - direction the target will face
_speed = _movArr select 0;     // Number - Speed n/s
_times = _movArr select 1;     // Number - times
_delay = _movArr select 2;     // Number - time target will rest
_downTime = _movArr select 3;   // Bool   - target will popup on true
_start = _movArr select 4;     // Object - Trigger
_reset = _movArr select 5;     // Object - Trigger
_frstRail = _target getVariable "_base"; // baseRail

// custom hit Eventhandler, default disabled by nopop=true; in init.sqf
//_target addEventHandler ["HitPart", {[(_this select 0)] execVM 'scripts\MovingTarget\PopUpTargetExt.sqf';}];

// calculating distance for movement
_dist = _Seg - 1 + 2*0.05;
_dw = _speed * 0.01;


// if trigger used, wait until it's triggered
if( !isNull _start ) then {
  _target animate ["terc", 1];
  waitUntil {triggerActivated _start};
  _target animate ["terc", 0];
};

// loop until times over, target not popping up again or endless
_i = 0;  // counting times

while{ (_i < _times || _times == -1)} do {

  _aktw = 0;

  // target moving down rail
  while {(_aktw < _dist)  && !(_target getVariable "_down")} do {

    _aktw = _aktw + _dw;
    _target setPos (_frstRail modelToWorld [(_aktW - 0.15),0,-0.10]);
    sleep 0.01;

  };

  _i = _i +1;
  sleep _delay;

  // target moving up rail again
  if ( _i < _times || _times == -1) then {  // stop if times over
    while {(_aktw > 0) && !(_target getVariable "_down")} do {

      _aktw = _aktw - _dw;
      _target setPos (_frstRail modelToWorld [(_aktW - 0.15),0,-0.10]);
      sleep 0.01;

    };
  _i = _i +1;
  sleep _delay;
  };
};

true


