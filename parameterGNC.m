%ROS Subsciber
global scansub 
scansub = rossubscriber('/scan');
% Navigation Parameters
% if we want the estimation parameters identical to actual parameters
VmaxDR = Vmax; 
rNominalDR = rNominal;
bDR = 1*b;
eTickDR = eTick;
TsampleEncoderDR = TsampleEncoder;
TauEncoderDR = 0.1;
%%

%%%%%%%%%%%%%%%%%%% control parameter %%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1:speed, 2:angle
KP1=10; %20;    % 1 is velocity controller
KP2=50;%3;%10;  %7 ->   % 2 is angle controller
KI1=.5;%10;%0.3; %0.001; %0.001;%10;
KI2=1; %0.1 %0.001; %0.001;%1; % 3 ->
KD1=0; %3; %0; %3; %0;%3;
KD2=3;% 3;%  %.5; %0; %0.5; %0;%0.5; %0.5 ->
Tsample = 1/100; %1/100; %1/10;   %sampling rate -> 0.01
Tmodel=Tsample;
Tau1 = 0.01;     %time constant of filter 1
Tau2 = 0.1;%0.1;       %time constant of filter 2

% wheel speed - DC conversion
dcArrayC = [-240 -220 -200 -150 -100 -80 -60 -50 -40 0 40 50    60    80   100   150 200 220 240];
wArrayC  = [-4.6279   -4.1707   -3.6703   -2.4511   -1.0693   -0.8382   -0.4348   -0.3287 -0.000001 0 0.000001 0.3292    0.4343    0.8065    1.0897    2.3927    3.6855    4.2037    4.6126]./rNominal;

%%%%%%%%%%%%%%%%%%% guidance parameter %%%%%%%%%%%%%%%%%%%%%%%%%%%
rp1 =  0.5; % 1 -> [m] proximity circle to start slowing down
rp2 =  0.2;  % [m] radius of wayPoint proximity circle to switch to the next wayPoint
Vcom = 3*VmaxDR/4; % [m/s] used when constant speed is commanded

%%%%%%%%%%%%%%%%%% Way Points %%%%%%%%%%%%%%%%%%%%%%%%%%%
% Y_array  = [0 2.22 2.22 0]; test square
% X_array  = [3 3 0 0]; 

%  X_array  = [4 7 11];   %Competition Points
%  Y_array  = [0 4 2]; 
 
 Y_array  = [0 0];    %Test case
 X_array  = [1.5 6];
%%%%%%%%%%%%%%%%%%% guidance parameter %%%%%%%%%%%%%%%%%%%%%%%%%%%
