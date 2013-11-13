% This creates random toy data.

maxX = 30;
maxY = 30;
numAPs = 3;
numEntries = 10;

p_d0 = -18.12;
beta = 1.634;

% Create the access points
points = zeros(numAPs, 2);
for i = 1:numAPs
    points(i, 1) = rand * maxX;
    points(i, 2) = rand * maxY;
end;

% locations: Each row is an entry, col 1 is X, col 2 is Y
locations = zeros(numEntries, 2);

% entries: Each row will be an entry. Columns are the signal strength of the
% corresponding access point
entries = zeros(numEntries, numAPs);

% Create the entries with a randomized signal strength
for i = 1:numEntries
    
    % This randomly positions the client
%     locations(i, 1) = rand * maxX;
%     locations(i, 2) = rand * maxY;

    % This randomly positions the client about in the middle
    locations(i, 1) = normrnd(maxX / 2, 5);
    locations(i, 2) = normrnd(maxY / 2, 5);

    for j = 1:numAPs
        
        % Create the signal strength based on distance with some randomness
        p1 = locations(i, :);
        p2 = points(j, :);
        distance = pdist([p1; p2]);
        power = p_d0 - 10 * beta * log(distance);
        entries(i, j) = power + normrnd(0, 3);
    end;
end;