
for i = 1:size(entries,1)
    measurements = entries(i, :);
    distances = predict_distance(measurements, p_d0, beta);

    % Set up the plot
    figure(i);
    clf;
    hold on;
    axis equal;
    
    estimate = ml_solve(points, distances, 1);
    
    % Plot the estimate and the actual point
    h = plot(estimate(1), estimate(2), 'o');
    set(h, 'Color', 'r');
    h = plot(locations(i,1), locations(i,2), 'o');
    set(h, 'Color', 'g');
end;