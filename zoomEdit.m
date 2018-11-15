figure
index = 0<times & times<35;
plot(times(index),a_ego_nn(index),'r')
hold on
plot(times(index),a_ego(index),'b')
hold off

figure
index = 0<times & times<25;
plot(times(index),v_ego_nn(index),'r')
hold on
plot(times(index),v_ego(index),'b')
hold off


figure
index = 0<times & times<25;
plot(times(index),d_rel_nn(index),'r')
hold on
plot(times(index),d_rel(index),'b')
plot(times(index),safe_distance(index),'-.k')
hold off