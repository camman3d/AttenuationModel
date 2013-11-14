% This figures out and plots the multilateration technique
function estimate = ml_solve(points, distances, plot)

    % First start with creating a bounding box
    minX = min(points(:,1) - transpose(distances));
    maxX = max(points(:,1) + transpose(distances));
    minY = min(points(:,2) - transpose(distances));
    maxY = max(points(:,2) + transpose(distances));
    
    % Compute the score for each point and graph it
    granularity = 1;
    bestErr = Inf;
    estimate = [0,0];
    for x = minX:granularity:maxX
        for y = minY:granularity:maxY
            ssd = ml_ssd(points, distances, [x,y]);
            if ssd < bestErr
                estimate = [x,y];
                bestErr = ssd;
            end;
            
            if plot
                % Plot the square
                h = rectangle('Position', [x - granularity / 2, y - granularity / 2, granularity, granularity]);

                % Figure out a color based on the ssd
                score = min(ssd, 100) / 100;
                set(h, 'FaceColor', [1, 1, score], 'EdgeColor', [1, 1, score]);
            end;
        end;
    end;
    
%     if plot
%         % Plot the bounding box and circles
%         plot_access_points(points, distances);
%         rectangle('Position', [minX, minY, maxX - minX, maxY - minY]);
%     end;
end