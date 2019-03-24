clear;
close all;

%%%%%%%%%%%%%%% Track Vehicle Parameter %%%%%%%%%%%%%%%%%%%%%%%%%
%b = 0.3299 ; % [m] Effective Platform Width = Diagonal length
             % Actual Width = 0.3556 m
b = 0.4375 + 0.00625;
rNominal = 0.128/2; % [m] Nominal Wheel Radius

Vmax = 3.9878; %132/866.1417; % [m/s] Maximum speed of the vehicle
% wMax = Vmax/rNominal; % [rad/s] Maximum angular speed of wheels % NOT USED

rr = 1*rNominal; %% Effective vehicle right wheel 
rl = 1*rNominal; %%  1%% Effective vehicle left wheel to represent inaccuracy in the vehicle

%%%%%%%%%%%%%%% Encoder Parameter %%%%%%%%%%%%%%%%%%%%%%%%%
eTick = 4054.282871;% 3584.954577; %900; % 866.1417-905.5118; % [ticks/m] number of ticks per 1 m of vehicle translation % from 22-23 [ticks/inch]
TsampleEncoder = 1/100; %1/100; % 0.1 [s] Encoder sample time
%%
%%%%%%%%%%%%%%% Duty Cycle -> Speed - Conversion %%%%%%%%%%%%%%%%%%%%%%%%%
dcArray = [-240 -220 -200 -150 -100 -80 -60 -50 -40 0 40 50    60    80   100   150 200 220 240];
wArray  = 1 .*[-4.6279   -4.1707   -3.6703   -2.4511   -1.0693   -0.8382   -0.4348   -0.3287 -0.000001 0 0.000001 0.3292    0.4343    0.8065    1.0897    2.3927    3.6855    4.2037    4.6126]./rNominal;


%%%%%%%%%%%%%%%%%% Initial Conditions %%%%%%%%%%%%%%%%%%%%%%%%%%%
xIC = 0;
yIC = 0;
thetaIC = 0*(pi/180);

%%%%%%%%%%%%%%%%% Reset timer and encoders %%%%%%%%%%%%%%%%%%%%%%%%%%%
reset_pub = rospublisher('/reset_t_enco','std_msgs/Int16');
pause(2)    %Wait to ensure publisher is registered
reset_msg = rosmessage(reset_pub);
reset_msg.Data = 1;
send(reset_pub,reset_msg);