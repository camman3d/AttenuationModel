%% plot_access_points: Plots access points with range
% points :  This is a matrix where each row is a location (x, y) of an
%           access point.
% 
% distances :   This is a vector where each entry is the estimated distance
%               from the corresponding access point.
function plot_access_points(points, distances)

    % Draw the endpoints
    plot(points(:,1), points(:,2), 'x');

    % Draw circles (distances from) each endpoints
    d = 0:0.01:2*pi;
    for i=1:size(distances, 2)
        circum = distances(i);
        x = circum * cos(d) + points(i, 1);
        y = circum * sin(d) + points(i, 2);
        plot(x, y, '-');
    end;
end