function [time_target, target_motion] = random_targets_generation(T_end,T_unit,Ts_sim)
%Computes the random trajectory for the SRL targets


%Size limits for the discrete steps
max_step = 60/180*pi; %[rad]
min_step = 20/180*pi; %[rad]

%Number of targets
n_units = floor(T_end/T_unit);

%Samples for each target and ramp
samples_unit = floor(T_unit/Ts_sim);
samples_ramp = floor(3/Ts_sim);

%Create polynomial ramp from 0 to 1 (amplitude)
time_ramp = linspace(0,1,samples_ramp);
ramp_poly = 10*time_ramp.^3-15*time_ramp.^4+6*time_ramp.^5;

%Time vector for the generated trajectory
time_target = 0:Ts_sim:(T_unit*n_units-Ts_sim);

%Initializations
target_pos = zeros(1,length(time_target));
target_prev = 0; %[rad]
target_next = 0; %[rad]

%Iterations
for i_c=1:1:n_units
    
    %Create the current segment of the trajectory
    target_pos(((i_c-1)*samples_unit+1):i_c*samples_unit) = ...
    [target_prev+ramp_poly*(target_next-target_prev)  ones(1,samples_unit-samples_ramp)*target_next];
    
    %Update the previous and next targets
    target_prev = target_next;
    step = rand*(max_step-min_step)+min_step; %always positive
    target_next = target_prev + sign(rand-0.5)*step; %decide sign here
    
    %Saturate targets
    %(to +-50deg in order to leave room for errors in both directions) 
    if target_next>50/180*pi
        target_next = 50/180*pi; %[rad]
    elseif target_next<-50/180*pi
        target_next = -50/180*pi; %[rad]
    end
    
    %Avoid that the target stops on the bounds for more than one segment
    if (target_prev==50/180*pi)&&(target_next==50/180*pi)
        target_next = target_next-step;
    elseif (target_prev==-50/180*pi)&&(target_next==-50/180*pi)
        target_next = target_next+step;
    end
    
    %Make sure that the last target is 0 [rad]
    if i_c==(n_units-1)
        target_next = 0; %[rad]
    end
    
end

%Compute velocity
target_vel = [0 diff(target_pos)/Ts_sim];

%Compute acceleration
target_acc = [0 diff(target_vel)/Ts_sim];

%Unite the computed vectors into a single matrix
target_motion = [target_pos' target_vel' target_acc'];

%Transpose time vector
time_target = time_target';


