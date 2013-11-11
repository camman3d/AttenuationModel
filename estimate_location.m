%% estimate_location:   Wireless location estimation using distances
% points :  This is a matrix where each row is a location (x, y) of an
%           access point.
% 
% distances :   This is a vector where each entry is the estimated distance
%               from the corresponding access point.
function estimate = estimate_location(points, distances)

    % Begin by normalizing the distances so that they sum to one and that a
    % weight of 1 means that the estimated location is at that access point
    normDist = 1 - distances / sum(distances);
    weights = normDist / sum(normDist);

    % Now interpolate over the positions using the weights
    estimate = [0,0];
    for i=1:size(points, 1)
        estimate = estimate + points(i,:) * weights(i);
    end;
end