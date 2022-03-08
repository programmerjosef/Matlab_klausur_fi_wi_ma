%%%%%%%%%%%%%%%%%%%%%%%%%%% Einbinden der Tabellen %%%%%%%%%%%%%%%%%%%%%%%


Height = load("Hoehe.txt");
Velocity = load("Geschwindigkeit.txt");
Time = load("Zeit.txt");

%%%%%%%%%%%%%%%%%%%%%%%%% Einbinden der Motorkennlinie %%%%%%%%%%%%%%%%%%%%

table_efficiency = xlsread("Motorkennlinie.xlsx","B2:O13");
efficiency = xlsread("Motorkennlinie.xlsx","C3:O13");
RPM = table_efficiency(1,2:14);
torque = table_efficiency(2:12,1);
max_torque = xlsread("Motorkennlinie.xlsx","C16:O16");


%%%%%%%%%%%%%%%%%%%%%%%%%  Einbinden der Konstanten   %%%%%%%%%%%%%%%%%%%%%
m = 2000;    %Masse [kg]
p = 1.2;     %Luftdichte [kg/m^3]
g = 9.81;    %Gewichtskraft [m/s^2]
j = 0.14;    %Treägheitsmoment [kg*m^2]
A = 2.5;     %Projizierte Stirnfläche [m^2]
d = 0.6;     %Durchmesser Rad [m]
cw = 0.4;    %Strömungswiderstandkoeffizient
fr = 0.015;  %Rollwiderstandkoeffizient
ng = 0.98;   %Wirkungsgrad des Getriebes
P = 1050;    %Leistung der Verbraucher [W]
i1 = 12.5;
i2 = 5;

out = sim("Simulink_Hausarbeit.slx");

Acceleration = out.Acceleration;

GradAngle= out.GradAngle;

AngVeloWheel = out.AngVeloWheel;

TorqueWheel = out.TorqueWheel;

nEMachine =out.nEMachine;

TorqueMotor = out.TorqueMotor;

AngVeloMotor = out.AngVeloMotor;

PowerEMachine = out.PowerEMachine;

GearRatio = out.GearRatio;

GearRatioAllow = out.GearRatioAllow;

GearRatioMax = out.GearRatioMax;

RPMEMachine = out.RPMEMachine;

close all;

%%%%%%%%%%%%%%%%%%%%%%%%%%% Diagramme erstellen %%%%%%%%%%%%%%%%%%%%%%      

nexttile;
plot(Time, Velocity);
title("Velocity");
grid on;
xlabel("Time (s)");
ylabel("Velocity (m/s)");

nexttile;
plot(Time, Height);
title("Height");
grid on;
xlabel("Time (s)");
ylabel("Height (m)");

nexttile;
plot(Time, Acceleration);
title("Acceleration");
grid on;
xlabel("Time (s)");
ylabel("Acceleration (m/s²)");

nexttile;
plot(Time, GradAngle);
title("Gradient angle");
grid on;
xlabel("Time (s)");
ylabel("Gradient angle (radians)");

nexttile;
plot(Time, AngVeloWheel);
title("Angular Velocity Wheel");
grid on;
xlabel("Time (s)");
ylabel("ω (grad/s)");

nexttile;
plot(Time, AngVeloMotor);
title("Angular Velocity E-Machine");
grid on;
xlabel("Time (s)");
ylabel("ω (grad/s)");

nexttile;
plot(Time, TorqueWheel);
title("Torque Wheel");
grid on;
xlabel("Time (s)");
ylabel("Torque (M)");

nexttile;
plot(Time, TorqueMotor);
title("Torque E-Machine");
grid on;
xlabel("Time (s)");
ylabel("Torque (M)");

nexttile;
plot(Time, nEMachine);
title("Efficency factor E-Machine");
grid on;
xlabel("Time (s)");
ylabel("Efficency factor (η)");

nexttile;
plot(Time, PowerEMachine);
title("Power E-Machine");
grid on;
xlabel("Time (s)");
ylabel("Power (W)");


nexttile;
plot(Time, GearRatioMax);
title("Gear Ratio Max");
grid on;
xlabel("Time (s)");
ylabel("Gear Ratio (i)");

nexttile;
contourf(MKL_Drehzahl, MKL_Drehmoment, MKL_Daten_max, 50,'edgecolor','none');
shading interp;
hold on;

title("Efficency factor (η) on the E-Maschine");

scatter(RPMEMachine, abs(TorqueMotor),'.k');
xlabel("RPM (min^-^1)");
ylabel("Torque at the motor (Nm)");
zlabel("Efficency factor (η)");
h = colorbar;
h.Label.String = "Efficency factor (η)";
hold off;