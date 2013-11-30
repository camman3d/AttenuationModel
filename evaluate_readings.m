% This script evaluates the readings

% Load data
data = xlsread('Full Readings 2 Averaged.xlsx');
apLocations = xlsread('Access Point Locations.xlsx');
img = imread('FlippedFloor1Map.jpg');

% Constants
% p_d0 = -18.12;
% beta = 1.634;

p_d0 = -21.76470588;
beta = 1.46;

clear M;

err_bi = 0;
err_amm = 0;
err_ml = 0;

% Iterate over each reading
for i = 1:size(data,1)
    reading = data(i, :);
    location = [reading(1), reading(2)];

    % Estimate how far away from each AP we are
    distances = zeros(1, size(apLocations,1));
    for j=1:size(apLocations,1)
        powerReading = reading((j+1)*2);
        if powerReading == 0
            distances(j) = 0;
        else
            distances(j) = predict_distance(powerReading, p_d0, beta);
        end;
%         distances(j) = reading(j*2 + 1); % Actual distance
    end;

    % Plot the access points
    figure(1);
    clf;
    % imshow(img);
    hold on;
    axis equal;
    axis([-20, 100, -20, 60]);
    
    % Filter the points
    filteredPoints = [];
    filteredDistances = [];
    for j=1:size(distances,2)
        if distances(j) ~= 0
            filteredPoints = [filteredPoints; apLocations(j, :)];
            filteredDistances = [filteredDistances, distances(j)];
        end;
    end;
    
    if size(filteredPoints, 1) > 1
        % Get the estimations
        estimate = ml_solve(filteredPoints, filteredDistances, 1);
        h = plot(estimate(1), estimate(2), 'o');
        set(h, 'Color', 'g');
        t1 = estimate(1) - location(1);
        t2 = estimate(2) - location(2);
        err_ml = err_ml + sqrt(t1.^2 + t2.^2);
        
        estimate = estimate_location_barycentric_interpolation(filteredPoints, filteredDistances);
        h = plot(estimate(1), estimate(2), 'o');
        set(h, 'Color', 'r');
        t1 = estimate(1) - location(1);
        t2 = estimate(2) - location(2);
        err_bi = err_bi + sqrt(t1.^2 + t2.^2);

        estimate = estimate_location_ave_min_margin(filteredPoints, filteredDistances);
        h = plot(estimate(1), estimate(2), 'o');
        set(h, 'Color', 'c');
        t1 = estimate(1) - location(1);
        t2 = estimate(2) - location(2);
        err_amm = err_amm + sqrt(t1.^2 + t2.^2);

    end;
    
    % Plot the actual location and the access points
    plot_access_points(apLocations, distances);
    h = plot(location(1), location(2), '*');
    set(h, 'Color', 'k');
    
    % Save the frame
%     M(2*i - 1) = getframe;
%     M(2*i) = getframe;
    saveas(gcf, strcat('./results/', num2str(i), '.jpg'));
    M(i) = getframe;
end;

fprintf(' -- Total Error -- \n');
fprintf('Barycentric Interpolation: %.1f\n', err_bi);
fprintf('Averaged Min Margin: %.1f\n', err_amm);
fprintf('Multilateration: %.1f\n', err_ml);

fprintf('\n -- Average Error -- \n');
fprintf('Barycentric Interpolation: %.2f\n', err_bi / size(data,1));
fprintf('Averaged Min Margin: %.2f\n', err_amm / size(data,1));
fprintf('Multilateration: %.2f\n', err_ml / size(data,1));