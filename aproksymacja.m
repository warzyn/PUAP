close all

t = linspace(0,20,1000);

%transmittance of process
%P = tf(1,conv([1 1],conv([2 1],[2 1])));
P = tf(1,conv([1 1],conv([1 1],conv([1 1],[1 1]))));
y = step(P,t);

%aproximation to the FOTD model
figure()
x0 = [1 1];
plot(t,y,t,odp_skokowa_modelu(x0,t));

x = lsqnonlin('wsk',x0,[],[],[],t,y');

figure()
plot(t,y,t,odp_skokowa_modelu(x,t));

T = x(1);
L = x(2);

%finding 'a' parameter
x1 = L;
y1 = 0;

x2 = L+T; 
y_temp = step(P,T+L);
y2 = y_temp(end);

a = double(find_a(x1,x2,y1,y2));

%tuning PID controller
K = 0.95/a;
Ti = 2.4*L;
Td = 0.42*L;