%% circle_intersection
% Find the "point in common" between two circles.
% For intersecting, the point is the middle of the intersection.
% For non-intersecting, the point is the middle of the space in between.
function point = circle_intersection(center1, radius1, center2, radius2)

    % Case 1: the circles intersect
    in = [0,0];
    out = [0,0];
    started = 0;
    ended = 0;
    for a = 0:0.01:2*pi
        p1 = center1 + radius1 * [cos(a), sin(a)];
        if pdist([p1; center2]) <= radius2
            if started == 0 && ended == 0
                in = p1;
                started = 1;
            end;
        else
            if started == 1 && ended == 0
                out = p1;
                ended = 1;
            end;
        end;
    end;
    point = (out + in) / 2;
    
    % Case 2: the circles don't intersect
    if started == 0
        % Find the points on each circle closest to each other. Do this by
        % drawing a line from the centers
        delta = center1 - center2;
        angle = atan2(delta(2), delta(1));
        p1 = center1 + radius1 * [cos(angle), sin(angle)];
        angle = angle + pi;
        p2 = center2 + radius2 * [cos(angle), sin(angle)];
        point = (p1 + p2) / 2;
    end;
end