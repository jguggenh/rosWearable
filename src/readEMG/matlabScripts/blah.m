%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parameters for Simulink and SimMechanics simulation and control of the
% experiment
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear; close all; clc;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parameters

%Simulation sampling time
Ts_sim = 0.004 %[s]

%Accelerometers sampling time
Ts_acc = 0.04 %[s]

%Control strategy: always velocity control (PI)
%Input to the controller
%1: artificial input(for testing)
%2: real-time EMG from NI PCI-6036E data acquisition board
input_type = 1;

%Phase of the experiment
%1: only natural arms
%2: only robotic arms
%3: both natural arms and robotic arms
phase_experiment = 2

%Simulation time (if input_type = 1)
T_end = 5; %[s]

%Gains for the use of EMG signals
EMG2vel_gain = 1*pi; %[(rad/s)/alpha] (default: pi)

%Robot parameters
J   = 0.633684; %[Kg*m^2]

%Actuator limits
tau_max_cont = 21; %[Nm]

%Joint limits
thetaR1_max = 60/180*pi;  %[rad]
thetaR1_min = -60/180*pi; %[rad]
thetaL1_max = 60/180*pi;  %[rad]
thetaL1_min = -60/180*pi; %[rad]

%Gains used to enforce joint limits
xsi_stop = 0.95;
Tp_stop  = 0.3;                                 %[s]
omega_n_stop = pi/(Tp_stop*sqrt(1-xsi_stop^2)); %[rad/s]
k_stop = J*omega_n_stop^2;                      %[Nm/rad]
b_stop = 2*J*omega_n_stop*xsi_stop;             %[Nm/(rad/s)]

%Gravity compensation
g = 9.81;     %[m/s^2]
m_arm = 3.45; %[kg]
thetaR1_rest = 94.175174862538100/180*pi;   %[rad]
delta_theta1 = thetaR1_rest - pi/2;         %[rad]
thetaR1_lift = 58.540811399866648/180*pi;   %[rad]
tau_lift     = -8.450711234563297;          %[Nm]
L_com = tau_lift/(-m_arm*g*cos(thetaR1_lift - delta_theta1)); %[m]

%Velocity control gains
Kp_vel = 7.5;  %[Nm/(rad/s)]
Ki_vel = 0.75; %[Nm/rad]

%Low pass filter for EMG signals
%Cutoff frequncy
f_cutoff_low = 100; %[Hz]
%Build the filter
order_low = 2;
fs_filt = 1/Ts_sim;
f_Nyq = fs_filt/2;
Wn_low = f_cutoff_low/f_Nyq;
[B_butter_low, A_butter_low] = butter(order_low,Wn_low,'low');

%Low pass filter for the calibration of EMG signals
%Cutoff frequncy
f_cutoff_cal = 10; %[Hz]
%Build the filter
order_cal = 2;
Wn_cal = f_cutoff_cal/f_Nyq;
[B_butter_cal, A_butter_cal] = butter(order_cal,Wn_cal,'low');

%Low pass filter for accelerometer signals
%Cutoff frequncy
f_cutoff_acc = 10; %[Hz]
%Build the filter
order_acc = 2;
fs_filt_acc = 1/Ts_acc;
f_Nyq_acc = fs_filt_acc/2;
Wn_acc = f_cutoff_acc/f_Nyq_acc;
[B_butter_acc, A_butter_acc] = butter(order_acc,Wn_acc,'low');

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
% Arduino: Initialization

%Initialize serial connection for the Arduino controlling the target servos
s_targets = serial('COM7');
set(s_targets,'BaudRate',9600);
fopen(s_targets);

%Initialize serial connection for the Arduino controlling the SRL servos
s_SRL = serial('COM3');
set(s_SRL,'BaudRate',9600);
fopen(s_SRL);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Real-time EMG data from Humusoft and NI acquisition boards

%Initialize the calibration parameters (in case input_type is 1)
min_EMG_RT   = zeros(1,10);
delta_EMG_RT = ones(1,10);

%Execute these commands only if input_type is 2
if input_type==2
    
    %Show the start of calibration
    disp('********************** Start Calibration **********************')

    %Acquire calibration data using the Simulink model for calibration
    sim('A_Calibration_Acquisition');
    
    %Show the end of calibration
    disp('********************** Stop Calibration ***********************')
    
    %Remove first second of calibration data
    %(the initial value of the raw EMG signals is zero)
    time_calRT = time_calRT(250:end);           %[s]
    EMG_vect_calRT = EMG_vect_calRT(250:end,:); %[V] (10 channels)

    %Extract calbiration constants for real-time testing
    min_EMG_RT   = min(EMG_vect_calRT);
    delta_EMG_RT = max(EMG_vect_calRT)-min(EMG_vect_calRT);
    
    %Extract angle data
    time_acc_calRT = accel_data_calRT.time;           %[s]
    acc_vect_calRT = accel_data_calRT.signals.values; %[rad] (4 channels)
    
    %Remove first second of angle data
    time_acc_calRT = time_acc_calRT(25:end);
    acc_vect_calRT = acc_vect_calRT(25:end,:);

    %Plot EMG data after calibration
    figure(1)
    for count=1:1:10
        subplot(5,3,count+1)
        plot(time_calRT, (EMG_vect_calRT(:,count)-min_EMG_RT(count))/delta_EMG_RT(count),'LineWidth',2)
        ylabel(['norm. EMG ' num2str(count)])
        if count==1
            subplot(5,3,1)
            title('Calibration data (10 EMG and 4 angles)')
        end
        
    end
    
    %Plot angle data to identify bias
    for count=1:1:4
        subplot(5,3,count+11)
        plot(time_acc_calRT,acc_vect_calRT(:,count)/pi*180,'r','LineWidth',2)
        ylabel(['Angle ' num2str(count) ' [deg]'])
        if (count==2) || (count==3) || (count==4) 
            xlabel('time [s]')
        end
    end

end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create target trajectories

%Length of real-time test
T_end = 180; %[s]

%Duration of a target
T_unit = 15; %[s]

%Generate random trajectory for right target (for robot)
[time_target, targetR_motion] = random_targets_generation(T_end,T_unit,Ts_sim);
%Generate random trajectory for left target (for robot)
[~, targetL_motion]           = random_targets_generation(T_end,T_unit,Ts_sim);
%Generate random trajectory for right target (for hand)
[~, targetHR_motion]          = random_targets_generation(T_end,T_unit,Ts_sim);
%Generate random trajectory for left target (for hand)
[~, targetHL_motion]          = random_targets_generation(T_end,T_unit,Ts_sim);

%Prepare data for Simulink model
targets_motion = [time_target  targetR_motion  targetL_motion  targetHR_motion  targetHL_motion];

%Plot the random target trajectories
figure(3)
subplot(221)
hold on
axis([time_target(1) time_target(end) -60 60])
plot([time_target(1) time_target(end)],[1 1]*50,'k:')
plot([time_target(1) time_target(end)],[1 1]*(-50),'k:')
plot([time_target(1) time_target(end)],[1 1]*0,'k')
plot(time_target,targets_motion(:,5)/pi*180,'LineWidth',2)
ylabel('position [deg]')
xlabel('time[s]')
title('Random trajectory for left target (robot)')
subplot(222)
hold on
axis([time_target(1) time_target(end) -60 60])
plot([time_target(1) time_target(end)],[1 1]*50,'k:')
plot([time_target(1) time_target(end)],[1 1]*(-50),'k:')
plot([time_target(1) time_target(end)],[1 1]*0,'k')
plot(time_target,targets_motion(:,2)/pi*180,'LineWidth',2)
ylabel('position [deg]')
xlabel('time[s]')
title('Random trajectory for right target (robot)')
subplot(223)
hold on
axis([time_target(1) time_target(end) -60 60])
plot([time_target(1) time_target(end)],[1 1]*50,'k:')
plot([time_target(1) time_target(end)],[1 1]*(-50),'k:')
plot([time_target(1) time_target(end)],[1 1]*0,'k')
plot(time_target,targets_motion(:,11)/pi*180,'LineWidth',2)
ylabel('position [deg]')
xlabel('time[s]')
title('Random trajectory for left target (hand)')
subplot(224)
hold on
axis([time_target(1) time_target(end) -60 60])
plot([time_target(1) time_target(end)],[1 1]*50,'k:')
plot([time_target(1) time_target(end)],[1 1]*(-50),'k:')
plot([time_target(1) time_target(end)],[1 1]*0,'k')
plot(time_target,targets_motion(:,8)/pi*180,'LineWidth',2)
ylabel('position [deg]')
xlabel('time[s]')
title('Random trajectory for right target (hand)')

% figure(4)
% hold on
% plot(time_target, targets_motion(:,3)/pi*180)
% plot(time_target, targets_motion(:,6)/pi*180)
% plot(time_target, targets_motion(:,9)/pi*180)
% plot(time_target, targets_motion(:,12)/pi*180)
% ylabel('velocity [deg/s]')
% xlabel('time[s]')
% title('Random trajectory for targets')
% legend('right robot','left robot','right hand','left hand')
% 
% figure(5)
% hold on
% plot(time_target, targets_motion(:,4)/pi*180)
% plot(time_target, targets_motion(:,7)/pi*180)
% plot(time_target, targets_motion(:,10)/pi*180)
% plot(time_target, targets_motion(:,13)/pi*180)
% ylabel('acceleration [deg/s^2]')
% xlabel('time[s]')
% title('Random trajectory for targets')
% legend('right robot','left robot','right hand','left hand')


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Arduino: Closing

% %Close the serial port used for the Arduinos
% fclose(s_targets); fclose(s_SRL);
% *******************************************************************************************

