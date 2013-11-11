function box = circle_inter_box(circles)

minx = inf;
miny = inf;
maxx = -inf;
maxy = -inf;

% Go around the first circle
for i = 0:0.05:2*pi
    % Get the point on the circumference
    point = [circles(1, 1) + circles(1, 3) * cos(i), circles(1, 2) + circles(1, 3) * sin(i)];

    % If the point is within a radius length of the center of the second
    % circle then it's 'contained' in the circle
    dist = sqrt((point(1) - circles(2, 1))^2 + (point(2) - circles(2, 2))^2);
    if (dist <= circles(2, 3))
        % Contained in the circle update the history of bounding box
        minx = min(minx, point(1));
        miny = min(miny, point(2));
        maxx = max(maxx, point(1));
        maxy = max(maxy, point(2));
    end
end

box = [minx, miny, maxx - minx, maxy - miny];


% box(1) = min(circ1(1) - circ1(3), circ2(1) - circ2(3));
% box(2) = min(circ1(2) - circ1(3), circ2(2) - circ2(3));
% box(3) = max(circ1(1) + circ1(3), circ2(1) + circ2(3)) - box(1);
% box(4) = max(circ1(2) + circ1(3), circ2(2) + circ2(3)) - box(2);

end