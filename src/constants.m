clear all;

%=================%
% Motor Constants %
%=================%
Km = 0.0452;          % Torque constant
Kb = 1/22.09592;      % Back EMF constant - need to invert to match units from datasheet
R = 7.25;             % Winding resistance
L = 7.46e-7;          % Motor inducatance
J = 8.82e-7;          % Rotor inertia
B = 1.25e-7;          % Motor damping
J_PENDULUM = 2.23e-5; % 3.9774e-6;

% Electrical Impedance %
ZE_NUM = [1];
ZE_DEN = [L R];

% Mechanical Impedance %
ZM_NUM = [1];
ZM_DEN = [(J_PENDULUM + J) B];
% If no load, just do 8.82e-7 (rotor inertia)

%================%
% Misc Constants %
%================%
DRIVER_SAT = 16;
CONTROLLER_SAT = 5;
SENSOR_GAIN = 1024 / 2*pi;  % ENX 16 EASY

% Motor System TF
a = L*J
b = (L*B + R*J);
c = (R*B + Km*Kb);
motor = tf([Km], [a b c]);

% Driver System TF
DAMPING = 0.61511;
Wn = 3.515e7;
DRIVER_GAIN = 4.7464;
amp = DRIVER_GAIN * tf([Wn^2], [1 (2*DAMPING*Wn) Wn^2]);

plant = amp*motor