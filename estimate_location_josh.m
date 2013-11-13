function estimate = estimate_location_josh(points, distances)
    
    % Find the point of interest for each pair of points
    pois = [];
    for i = 1:size(points,1)
        for j = i+1:size(points,1)
            if i ~= j
                p = circle_intersection(points(i, :), distances(i), points(j, :), distances(j));
                pois = [pois; p];
            end;
        end;
    end;
    
    estimate = [sum(pois(:,1)), sum(pois(:,2))];
    estimate = estimate / size(pois, 1);
end