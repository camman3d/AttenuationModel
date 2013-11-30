% Load data to use with the curve fitting tool
readings1 = xlsread('Readings.xlsx');
readings2 = xlsread('Readings2.xlsx');
readings3 = xlsread('ReadingsAveraged.xlsx');
outdoorData = xlsread('Outdoor readings.xlsx');
combinedData = [outdoorData; readings1; readings2; readings3];

dataX = combinedData(:, 1);
dataY = combinedData(:, 2);
%cftool(dataX, dataY)

% Use the equation:
% -21.76470588 - 10 * beta * log(x)

% That means that the constants are:
p_d0 = -21.76470588;
beta = 1.46;
beta_low = 1.427;
beta_high = 1.493;

beta_in = 1.487;
beta_in_low = 1.456;
beta_in_high = 1.519;

beta_out = 1.336;
beta_out_low = 1.234;
beta_out_high = 1.439;


% This creates the plot of the data
figure(1);
clf;
hold on;
axis([0, 60, -90, -25]);

% Draw several versions of the curve
p = -90:0.1:-20;

% Combined
for b = beta_low:0.001:beta_high
    d = predict_distance(p, p_d0, b);
    h_range = plot(d, p, '-');
    set(h_range, 'Color', [.9,.9,1]);
end;

d = predict_distance(p, p_d0, beta);
h_combined = plot(d, p, '-');
set(h_combined, 'Color', 'b');

% Indoor

d = predict_distance(p, p_d0, beta_in);
h_indoor = plot(d, p, '-');
set(h_indoor, 'Color', 'r');

% Outdoor

d = predict_distance(p, p_d0, beta_out);
h_outdoor = plot(d, p, '-');
set(h_outdoor, 'Color', 'g');

legend([h_indoor, h_outdoor, h_combined, h_range], 'Indoor', 'Outdoor', 'Combined', '95% Confidence');

% d = predict_distance(p, p_d0, beta + 0.1);
% h = plot(d, p, '-');
% set(h, 'Color', 'y');
% 
% d = predict_distance(p, p_d0, beta - 0.1);
% h = plot(d, p, '-');
% set(h, 'Color', 'y');
% 
% d = predict_distance(p, p_d0, beta + 0.2);
% h = plot(d, p, '-');
% set(h, 'Color', [0.94, 0.66, 0.06]);
% 
% d = predict_distance(p, p_d0, beta - 0.2);
% h = plot(d, p, '-');
% set(h, 'Color', [0.94, 0.66, 0.06]);
% 
% d = predict_distance(p, p_d0, beta + 0.3);
% h = plot(d, p, '-');
% set(h, 'Color', 'r');
% 
% d = predict_distance(p, p_d0, beta - 0.3);
% h = plot(d, p, '-');
% set(h, 'Color', 'r');
% 
% d = predict_distance(p, p_d0, beta + 0.4);
% h = plot(d, p, '-');
% set(h, 'Color', [1,0,1]);
% 
% d = predict_distance(p, p_d0, beta - 0.4);
% h = plot(d, p, '-');
% set(h, 'Color', [1,0,1]);



h = plot(combinedData(:,1), combinedData(:,2), 'x');
set(h, 'Color', 'k');