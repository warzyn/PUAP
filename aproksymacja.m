close all

%% transmittance of process

t_sim = 100;
t = linspace(0,t_sim,1000);
G = G5(8);
y = step(G,t);

%% aproximation to the FOTD model

x0 = [1 1];

%figure()
%plot(t,y,t,odp_skokowa_modelu(x0,t));

x = lsqnonlin('wsk',x0,[],[],[],t,y');

figure()
plot(t,y,t,odp_skokowa_modelu(x,t));
legend('obiekt','aproksymacja');
hold on

T = x(1);
L = x(2);

%% finding 'a' parameter

x1 = L;
y1 = 0;

x2 = L+T;
y2 = odp_skokowa_modelu(x,x2);
%y_temp = step(P,T+L);
%y2 = y_temp(end);

a = double(find_a(x1,x2,y1,y2));
T_temp = double(find_T(x1,x2,y1,y2));
plot([0 T_temp],[-a 1],0,-a,'*',x2,y2,'*',T_temp,1,'*');
T_p = T_temp-L;

%% tuning PID controller

K = 0.6/a
Ti = 1.0*T_p
Td = 0.5*L

% K = 0.95/a;
% Ti = 1.4*T_p;
% Td = 0.47*L;

num = G.num{1,1};
den = G.den{1,1};

sim('model',t_sim);

figure()
plot(process_value.time,process_value.signals.values(:,1));
hold on
plot(process_value.time,process_value.signals.values(:,2));
legend('uk³ad otwarty','uk³ad z regulatorem PID');