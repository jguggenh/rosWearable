%% clear workspace
clear; close all; clc; delete(instrfind);
addpath(genpath(pwd));

%% start initializing parameters
%Simulation sampling time
Ts_sim = 0.004; %[s]

%Control strategy: always velocity control (PI)
%Input to the controller
%1: artificial input(for testing)
%2: real-time EMG from DAQ
input_type = 2;

%Phase of the experiment
%1: only natural arms
%2: only robotic arms
%3: both natural arms and robotic arms
phase_experiment = 2;

%Simulation time (if input_type = 1)
T_end = 10; %[s]

%Gains for the use of EMG signals
EMG2vel_gain = 1*pi; %[(rad/s)/alpha] (default: pi)

%Robot parameters
J   = 0.633684; %[Kg*m^2]

%Actuator limits
tau_max_cont = 21; %[Nm]

%Joint limits
thetaR1_max = 80/180*pi;  %[rad]
thetaR1_min = -80/180*pi; %[rad]
thetaL1_max = 80/180*pi;  %[rad]
thetaL1_min = -80/180*pi; %[rad]

%Gains used to enforce joint limits
xsi_stop = 0.95;
Tp_stop  = 0.3;                                 %[s]
omega_n_stop = pi/(Tp_stop*sqrt(1-xsi_stop^2)); %[rad/s]
k_stop = J*omega_n_stop^2;                      %[Nm/rad]
b_stop = 2*J*omega_n_stop*xsi_stop;             %[Nm/(rad/s)]

%Gravity compensation
g = 9.81;     %[m/s^2]
m_arm = 3.45; %[kg] --> CHANGE MEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE
thetaR1_rest = 94.175174862538100/180*pi;   %[rad]
delta_theta1 = thetaR1_rest - pi/2;         %[rad]
thetaR1_lift = 58.540811399866648/180*pi;   %[rad]
tau_lift     = -8.450711234563297;          %[Nm]
L_com = tau_lift/(-m_arm*g*cos(thetaR1_lift - delta_theta1)); %[m]

%Velocity control gains
Kp_vel = 7.5;  %[Nm/(rad/s)]
Ki_vel = 0.75; %[Nm/rad]

%Mapping from simulation angles to servo angles

%Servo 1
%Parameters
x1_1 = 0;   y1_1 = 90;
x2_1 = -60; y2_1 = 150;
%Line parameters
m1 = (y2_1-y1_1)/(x2_1-x1_1);
q1 = -x1_1*m1 + y1_1;

%Servo 3
%Parameters
x1_3 = 0;  y1_3 = 90;
x2_3 = 60; y2_3 = 30;
%Line parameters
m3 = (y2_3-y1_3)/(x2_3-x1_3);
q3 = -x1_3*m3 + y1_3;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Real-time EMG data from Humusoft and NI acquisition boards

%Initialize the calibration parameters (in case input_type is 1)
minFG   = zeros(1,4);
deltaFG = ones(1,4);
emgConst2 = 0; % fake input for now

%Execute these commands only if input_type is 2
if input_type==2
    
    %Show the start of calibration
    disp('********************** Start Calibration **********************')

    %Acquire calibration data using the Simulink model for calibration
    sim('forceGloveCalibration');
    
    %Show the end of calibration
    disp('********************** Stop Calibration ***********************')
    
    %Remove first second of calibration data
    %(the initial value of the raw EMG signals is zero)
    timeCal = timeCal(250:end);           %[s]
    forceGloveCal = double(forceGloveCal(250:end,:)); %[V] (4 channels)

    %Extract calbiration constants for real-time testing
    minFG   = double(min(forceGloveCal));
    deltaFG = double(max(forceGloveCal)-min(forceGloveCal));

    %Plot FG data after calibration
    figure(1)
    for count=1:1:4
        subplot(2,2,count)
        plot(timeCal, (forceGloveCal(:,count)-minFG(count))/deltaFG(count),'LineWidth',2)
        ylabel(['FG ' num2str(count)])
        if count==1
            subplot(2,2,1)
            title('Calibration data (2 FGS)')
        end   
    end
end
