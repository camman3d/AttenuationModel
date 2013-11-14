function evaluate_data(points, locations, entries)

    p_d0 = -18.12;
    beta = 1.634;
    
    ml_total = 0;
    bi_total = 0;
    amm_total = 0;

    % Evaluate each entry separately
    for i = 1:size(entries, 1)
        
        measurements = entries(i, :);
        distances = predict_distance(measurements, p_d0, beta);
        
        figure(i);
        clf;
        hold on;
        axis equal;
        
        % Plot the multilateration estimate
        ml_estimate = ml_solve(points, distances, 1);
        ml_dist = pdist([ml_estimate; locations(i,:)]);
        ml_h = plot(ml_estimate(1), ml_estimate(2), 'o');
        set(ml_h, 'Color', 'g');
        
        
        % Plot the access points
        [x_handle, line_handle] = plot_access_points(points, distances);
        
        % Plot the location
        h = plot(locations(i, 1), locations(i, 2), '*');
        set(h, 'Color', 'k');
        
        % Compute the new location and plot it
        bi_estimate = estimate_location_barycentric_interpolation(points, distances);
        bi_dist = pdist([bi_estimate; locations(i,:)]);
        bi_h = plot(bi_estimate(1), bi_estimate(2), 'o');
        set(bi_h, 'Color', 'r');
        
        % Do it again with a different technique
        amm_estimate = estimate_location_ave_min_margin(points, distances);
        amm_dist = pdist([amm_estimate; locations(i,:)]);
        amm_h = plot(amm_estimate(1), amm_estimate(2), 'o');
        set(amm_h, 'Color', 'c');
        
        legend([ml_h, bi_h, amm_h, h, x_handle, line_handle], 'Multilateration', ...
            'Barycentric Interpolation', 'Averaged Min Margin', 'Actual Location', ...
            'Access Points', 'Estimated Distance');
        
        fprintf('Results for entry #%d\n', i);
        fprintf('  Multilateration: %.1f\n', ml_dist);
        fprintf('  Barycentric Interpolation: %.1f\n', bi_dist);
        fprintf('  Averaged Min Margin: %.1f\n', amm_dist);
        fprintf('\n');
        
        ml_total = ml_total + ml_dist;
        bi_total = bi_total + bi_dist;
        amm_total = amm_total + amm_dist;
        
    end;
    
    fprintf('Final results\n');
        fprintf('  Multilateration: %.1f\n', ml_total);
        fprintf('  Barycentric Interpolation: %.1f\n', bi_total);
        fprintf('  Averaged Min Margin: %.1f\n', amm_total);

end