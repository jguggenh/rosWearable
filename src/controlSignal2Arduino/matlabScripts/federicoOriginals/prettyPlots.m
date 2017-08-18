%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Saving and plotting the data of the experiment

%Save the data
%(all variables from current workspace)
save('JG_Phase2_Day3_Trial5')

%Variables of interest
%-> time_simulation (1 vector) [s]:
%   the time vector of the simulation, at 250Hz
%   (for all signals except for position_human_actual)
%-> normalized_EMG (matrix with 10 columns) [adimensional]:
%   the normalized EMG signals recorded from the user
%-> position_actual (matrix with 2 columns) [rad]:
%   the actual position of the SRL limbs
%-> data_human_actual (structure, matrix with 4 columns) [rad]:
%   the actual position of the human, from the accelerometers, at 25hz
%-> position_target (matrix with 4 columns) [rad]:
%   the position trajectory of the targets

%Extract the human position data (from accelerometers)
time_simulation_human = data_human_actual.time; %[s]
position_human_actual = data_human_actual.signals.values; %[rad]

%Plot the variables of interest
figure(101)
subplot(5,3,1)
hold on
plot(time_simulation,position_target(:,1)/pi*180,'r')
plot(time_simulation,position_actual(:,1)/pi*180,'b')
ylabel('R position [deg]')
legend('target','actual')
subplot(5,3,4)
hold on
plot(time_simulation,position_target(:,2)/pi*180,'r')
plot(time_simulation,position_actual(:,2)/pi*180,'b')
ylabel('L position [deg]')
legend('target','actual')
subplot(5,3,7)
hold on
plot(time_simulation,position_target(:,3)/pi*180,'r')
plot(time_simulation_human,position_human_actual(:,1)/pi*180,'b')
ylabel('HR position [deg]')
legend('target','actual')
subplot(5,3,10)
hold on
plot(time_simulation,position_target(:,4)/pi*180,'r')
plot(time_simulation_human,position_human_actual(:,2)/pi*180,'b')
ylabel('HL position [deg]')
legend('target','actual')
subplot(5,3,13)
hold on
plot(time_simulation_human,position_human_actual(:,3)/pi*180,'c')
plot(time_simulation_human,position_human_actual(:,4)/pi*180,'m')
ylabel('torso position [deg]')
legend('sagittal','frontal')
xlabel('time [s]')
indices_plots = [2 3 5 6 8 9 11 12 14 15];
for count=1:1:10
    subplot(5,3,indices_plots(count))
    plot(time_simulation,normalized_EMG(:,count))
    ylabel(['norm. EMG ' num2str(count)])
    if (count+5==14) || (count+5==15)
        xlabel('time [s]')
    end
end





