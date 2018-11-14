close all
mdl = 'test_mpcACCsystem';
open_system(mdl)

%Define the sample time, Ts, and simulation duration, T, in seconds.
Ts = 0.1;
T = 400;
seed = randi([1001,2000]);
%Specify the linear model for ego car.
G_ego = tf(1,[0.5,1,0]);

%Specify the initial position and velocity for the two vehicles.
x0_lead = 50;   % initial position for lead car (m)
v0_lead = 25;   % initial velocity for lead car (m/s)

x0_ego = 10;   % initial position for ego car (m)
v0_ego = 20;   % initial velocity for ego car (m/s)

t_gap = 1.4;
D_default = 10;

%Specify the driver-set velocity in m/s.
v_set = 30;

%The acceleration is constrained to the range [-3,2] (m/s^2).
amin_ego = -3;
amax_ego = 2;

%% Run the simulation with actual controller .
sim(mdl)

v_ego = logsout.get(4).Values.Data; % input3
d_rel = logsout.get(7).Values.Data; % input4
v_lead = logsout.get(5).Values.Data;
v_rel = v_lead - v_ego; % input5

a_ego = logsout.get(1).Values.Data; % output1


%% Run the simulation with NN controller .
sim('test_nncACCsystem')

v_ego_nn = logsout.get(1).Values.Data; % input3
d_rel_nn = logsout.get(5).Values.Data; % input4
v_lead_nn = logsout.get(3).Values.Data;
v_rel_nn = v_lead_nn - v_ego_nn; % input5

a_ego_nn = logsout.get(2).Values.Data; % output1


%%
figure
hold on
plot(v_ego_nn,'r')
plot(v_ego, 'b')
title('ego velocity')
legend('v\_ego from NNcontoller', 'v\_ego from the actual controller')
hold off

figure
hold on
plot(d_rel_nn,'r')
plot(d_rel, 'b')
title('relative distance')
legend('d\_rel from NNcontoller', 'd\_rel from the actual controller')
hold off

figure
hold on
plot(a_ego_nn,'r')
plot(a_ego, 'b')
title('ego acceleration')
legend('a\_ego from NNcontoller', 'a\_ego from the actual controller')
hold off
%% Remove example file folder from MATLAB path, and close Simulink model.
rmpath(fullfile(matlabroot,'examples','mpc','main'));