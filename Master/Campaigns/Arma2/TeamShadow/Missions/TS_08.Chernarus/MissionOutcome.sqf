//////////////////////////////////////////////////////////////////
// Function file for Armed Assault
// Created by: TODO: Author Name
//////////////////////////////////////////////////////////////////

// If the Informant is dead, and TargetB is not eliminated
if ((taskstate InfEscort) == "FAILED" && (taskstate mainoobj) == "FAILED") then {
	endMission "END1";
};

// If the Informant is alive, and TargetB is not eliminated
if ((taskstate InfEscort) == "SUCCEEDED" && (taskstate mainoobj) == "FAILED") then {
	endmission "END2";
};

// If the Informant is dead, and TargetB has been eliminated
if ((taskstate InfEscort) == "FAILED" && (taskstate mainoobj) == "SUCCEEDED") then {
	endmission "END3";
};

// If the Informant is alive, and TargetB was eliminated
if ((taskstate InfEscort) == "SUCCEEDED" && (taskstate mainoobj) == "SUCCEEDED") then {
	endmission "END4";
};