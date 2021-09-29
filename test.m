% [x,t] = simplefit_dataset;
% net = feedforwardnet(20);
% net = train(net,x,t);
% y = net(x);
% perf = perform(net,t,y);
% gwb = bttderiv('dperf_dwb',net,x,t)
% jwb = bttderiv('de_dwb',net,x,t)

n = -5:0.1:5;
a = poslin(n);
plot(n,a)