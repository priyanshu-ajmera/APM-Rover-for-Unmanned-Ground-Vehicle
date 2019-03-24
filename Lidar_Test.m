scansub = rossubscriber('/scan');
while(true)
    scan = receive(scansub);
    clf;
    [x,y] = fcn(scan,0,0);
    scatter(y,x);
    axis equal;
    grid on;
    axis([-20,20,-20,20]);
    pause(0.1);
end

function [x,y] = fcn(obj,range_min,range_max)
numReadings = numel(obj.Ranges);
angles = obj.AngleMin + (0:numReadings-1)' * obj.AngleIncrement;

if ((range_min==0 && range_max==0) || range_min>range_max)    
    range_min = obj.RangeMin;
    range_max = obj.RangeMax;
end
R = obj.Ranges;

% If no ranges are available, return right away
if isempty(R)
    x = 0;
    y = 0;
    return;
end

validIdx = isfinite(R) & R >= range_min & R <= range_max;
R = R(validIdx);
% angles = obj.readScanAngles();
cartAngles = angles(validIdx);
x = -cos(cartAngles) .* R(:,1);
y = sin(cartAngles) .* R(:,1);
end