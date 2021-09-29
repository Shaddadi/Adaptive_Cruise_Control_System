clear
clc
close all
%addpath(fullfile(matlabroot,'examples','mpc','main'));
global mdl Ts T G_ego t_gap D_default v_set amin_ego amax_ego
global x0_lead v0_lead x0_ego v0_ego seed
mdl = 'mpcACCsystem';
open_system(mdl)

% Generate training data
[inputs_cell, output_cell] = generateOnetrace();
inputs_test = inputs_cell;
output_test = output_cell;
for i = 1:20
    [input1, output1] = generateOnetrace();
    inputs_cell = catsamples(inputs_cell, input1, 'pad');
    output_cell = catsamples(output_cell, output1, 'pad');
end


%% Construct RNN controller

net = elmannet(1:1,50);
net.inputs{1}.processFcns = {};
% net.layers{1}.transferFcn = 'poslin';
net.outputs{2}.processFcns = {};
[Xs,Xi,Ai,ts] = preparets(net,inputs_cell,output_cell);

% net.trainParam.lr = 0.01;
net.trainParam.epochs = 500;
net.trainParam.min_grad = 1e-10;

net = train(net,Xs,ts,Xi,Ai);
% view(net)
Y = net(Xs,Xi,Ai);
perf = perform(net,ts,Y)
gensim(net);


% net = elmannet(1:2,500);
% net = init(net);
% net.inputs{1}.processFcns = {};
% net.layers{1}.transferFcn = 'poslin';
% net.outputs{2}.processFcns = {};
% % net = configure(net,inputs_cell,output_cell);
% % net.plotFcns = {'plotperform','plottrainstate',...
% %     'ploterrhist','plotregression','plotresponse'};
% % net.trainFcn = 'trainlm';
% 
% [x_tot,xi_tot,ai_tot,t_tot] = ...
%             preparets(net,inputs_cell,output_cell);
% net.trainParam.epochs = 500;
% net.trainParam.min_grad = 1e-10;
% [net,tr] = train(net,x_tot,t_tot,xi_tot,ai_tot);
% Y = net(inputs_test);
% perf = perform(net,output_test,Y)

