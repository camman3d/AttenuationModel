function evaluate_data(points, locations, entries)

    p_d0 = -18.12;
    beta = 1.634;

    % Evaluate each entry separately
    for i = 1:size(entries, 1)
        
        figure(i);
        clf;
        hold on;
        axis equal;
        
        % Plot the access points
        measurements = entries(i, :);
        distances = predict_distance(measurements, p_d0, beta);
        plot_access_points(points, distances);
        
        % Plot the location
        h = plot(locations(i, 1), locations(i, 2), 'o');
        set(h, 'Color', 'g');
        
        % Compute the new location and plot it
        estimate = estimate_location_multilateration(points, distances);
        h = plot(estimate(1), estimate(2), 'o');
        set(h, 'Color', 'r');
        
        % Do it again with a different technique
        estimate = estimate_location_josh(points, distances);
        h = plot(estimate(1), estimate(2), 'o');
        set(h, 'Color', 'c');
        
    end;

end