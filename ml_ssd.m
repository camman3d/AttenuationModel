%% ml_ssd : Given a point and a number of circles, it returns the SSD
function ssd = ml_ssd(points, distances, point)
    ssd = 0;
    for i = 1:size(points,1)
        ssd = ssd + (pdist([points(i,:); point]) - distances(i))^2;
    end;
end