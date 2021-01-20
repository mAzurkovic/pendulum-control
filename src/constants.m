clear all;

%=================%
% Motor Constants %
%=================%
Km = 0.0452;       % Torque constant
Kb = 1/22.09592;   % Back EMF constant - need to invert to match units from datasheet
R = 7.25;           % Winding resistance
L = 7.46e-7;        % Motor inducatance
J = 8.82e-7;        % Rotor inertia
B = 1.25e-7;        % Motor damping

% Electrical Impedance %
ZE_NUM = [1];
ZE_DEN = [L R];

% Mechanical Impedance %
ZM_NUM = [1];
ZM_DEN = [(3.9774e-6 + J) B];
% If no load, just do 8.82e-7 (rotor inertia)

%=================%
% Misc Constants %
%==================%
DRIVER_SAT = 24;
CONTROLLER_SAT = 5;


Tf_num = [Km];
Tf_den = [ L*J (L*B + R*J) (R*B + Km*Kb) ];
H = tf(Tf_num, Tf_den)