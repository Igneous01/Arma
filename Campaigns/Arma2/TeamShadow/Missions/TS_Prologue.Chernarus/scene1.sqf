titlecut [" ","BLACK IN",5];
_camera = "camera" camcreate [0,0,0];
_camera cameraeffect ["internal", "back"];

// Overview camera
_camera camPrepareTarget [-36312.38,-84497.80,-8213.71];
_camera camPreparePos [2001.14,7479.81,9.34];
_camera camPrepareFOV 0.700;
_camera camCommitPrepared 0;
waitUntil {(camCommitted _camera)};

sleep 6;

titlecut [" ","BLACK IN",3];

// Camera inside forest (credits follow)
_camera camPrepareTarget [-11688.46,-91427.86,7465.49];
_camera camPreparePos [1754.38,7404.91,1.71];
_camera camPrepareFOV 0.700;
_camera camCommitPrepared 0;
waitUntil {(camCommitted _camera)};

sleep 9.4;

// ************************************************* camera move through forest birds eye
_camera camPrepareTarget [5887.67,-90324.70,-28978.06];
_camera camPreparePos [1577.58,7700.98,33.34];
_camera camPrepareFOV 0.300;
_camera camCommitPrepared 0;
waitUntil {(camCommitted _camera)};

_camera camPrepareTarget [-92753.38,5357.90,-32051.98];
_camera camPreparePos [1930.58,6954.80,74.15];
_camera camPrepareFOV 0.900;
_camera camCommitPrepared 17;
waitUntil {(camCommitted _camera)};

// ********************************************** look at boar
_camera camPrepareTarget boar;
_camera camPreparePos [1743.19,7282.09,3.19];
_camera camPrepareFOV 0.200;
_camera camCommitPrepared 0;
waitUntil {(camCommitted _camera)};

_camera camPrepareTarget [22832.12,104994.74,962.59];
_camera camPreparePos [1722.05,7252.65,3.67];
_camera camPrepareFOV 0.800;
_camera camCommitPrepared 10;
waitUntil {(camCommitted _camera)};

sleep 0.1;

// ******************************************** zoom on snipers
_camera camPrepareTarget sniper;
_camera camPreparePos getmarkerpos "smark1";
_camera camPrepareFOV 0.700;
_camera camCommitPrepared 0;
waitUntil {(camCommitted _camera)};

_camera camPrepareTarget sniper;
_camera camPreparePos [getmarkerpos "smark2" select 0, getmarkerpos "smark2" select 1, 5];
_camera camPrepareFOV 0.800;
_camera camCommitPrepared 15;
waitUntil {(camCommitted _camera)};

sleep 0.1;

// ************************************ rotate around sniper
_camera camPrepareTarget sniper;
_camera camPreparePos [1793.94,7408.67,0.55];
_camera camPrepareFOV 0.700;
_camera camCommitPrepared 0;
waitUntil {(camCommitted _camera)};

_camera camPrepareTarget [99132.57,5720.82,-22551.24];
_camera camPreparePos [1791.28,7408.25,0.61];
_camera camPrepareFOV 0.700;
_camera camCommitPrepared 15;
waitUntil {(camCommitted _camera)};

// ************************************* rotate around ao
_camera camPrepareTarget [-28731.16,102323.11,5909.77];
_camera camPreparePos [2019.58,7357.48,2.65];
_camera camPrepareFOV 0.400;
_camera camCommitPrepared 0;
waitUntil {(camCommitted _camera)};

_camera camPrepareTarget [-31061.73,-85771.82,-14697.76];
_camera camPreparePos [2022.29,7399.56,3.41];
_camera camPrepareFOV 0.900;
waitUntil {(camCommitted _camera)};

// **************************************** follow targets car
_camera camPrepareTarget [101775.13,1656.03,1767.59];
_camera camPreparePos [1949.64,7357.06,1.97];
_camera camPrepareFOV 0.700;
_camera camCommitPrepared 0;
waitUntil {(camCommitted _camera)};

_camera camPrepareTarget [82583.55,66510.97,1767.84];
_camera camPreparePos [1986.01,7335.44,2.61];
_camera camPrepareFOV 0.700;
_camera camCommitPrepared 10;
waitUntil {(camCommitted _camera)};

_camera camPrepareTarget [42781.30,91102.38,-36263.83];
_camera camPreparePos [2003.06,7353.03,15.62];
_camera camPrepareFOV 0.700;
_camera camCommitPrepared 15;
waitUntil {(camCommitted _camera)};

_camera camPrepareTarget [43132.45,91940.49,34023.32];
_camera camPreparePos [2005.70,7358.33,1.58];
_camera camPrepareFOV 0.700;
_camera camCommitPrepared 5;
waitUntil {(camCommitted _camera)};

_camera camPrepareTarget [39386.35,99675.91,-9033.34];
_camera camPreparePos [2011.09,7371.94,3.39];
_camera camPrepareFOV 0.700;
_camera camCommitPrepared 7.5;
waitUntil {(camCommitted _camera)};

sleep 0.5;

// go back to snipers
_camera camPrepareTarget [-70126.91,76862.30,-1921.02];
_camera camPreparePos [1794.44,7406.56,0.81];
_camera camPrepareFOV 0.700;
_camera camCommitPrepared 0;
waitUntil {(camCommitted _camera)};

sleep 5;

// Zoom in on target from sniper location
_camera camPrepareTarget general;
_camera camPreparePos (getmarkerpos "snipermark");
_camera camPrepareFOV 0.5;
_camera camCommitPrepared 0;
waitUntil {(camCommitted _camera)};

_camera camPrepareTarget general;
_camera camPreparePos (getmarkerpos "snipermark");
_camera camPrepareFOV 0.05;
_camera camCommitPrepared 5;
waitUntil {(camCommitted _camera)};

sleep 5;

// fire weapon
_handle = sniper action ["useWeapon", sniper, sniper, 0];

// go to black and end
titlecut [" ","BLACK OUT",0.1];

sleep 3;
_camera cameraeffect ["terminate","back"];
camdestroy _camera;

end1=true;
exit;