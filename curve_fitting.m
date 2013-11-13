% Load data to use with the curve fitting tool
data = xlsread('Readings.xlsx');
dataX = data(:, 1);
dataY = data(:, 2);

% Run the curve fitting tool with 'cftool'
% From data I collected it looks like p_d0 is -18.12
% The best beta is 1.634

p_d0 = -18.12;
beta = 1.634;

% Plot the curve
% Prepare the figure
figure(1);
clf;
hold on;
axis([0, 60, -90, -25]);

% Draw the data
h = plot(dataX, dataY, 'x');
set(h, 'Color', 'r');
p = -90:0.1:-20;
d = predict_distance(p, p_d0, beta);
h = plot(d, p, '-');
set(h, 'Color', 'g');