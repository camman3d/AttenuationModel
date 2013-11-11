% Load the data
data = xlsread('Readings.xlsx');

% Break the data into training and evaluation sets
training = data(1:35, :);
evaluation = data(36:65, :);

% Plot the data points
figure(1);
clf;
hold on;
scatter(data(:,1), data(:,2))

% TODO: Pick the best n based off of the evaluation set
bestI = 0;
bestErr = Inf;
for i = 1:10

    % Fit a polynomial to the data
    p = polyfit(training(:,1), training(:,2), n);

    err = 0;
    for j = 1:size(evaluation, 1)
        est = polyval(p, evaluation(j, 1));
        err = err + abs(est - evaluation(j, 2));
    end;
    if err < bestErr
        bestErr = err;
        bestI = i;
    end;
end;

fprintf('Best i is %d\n', bestI);
p = polyfit(training(:,1), training(:,2), bestI);

% Plot the curve
px = 0:0.1:60;
py = polyval(p, px);
h = plot(px, py, '-');
set(h, 'Color', 'r');