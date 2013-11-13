
show_demo_1 = 1;
show_demo_2 = 1;
show_demo_3 = 1;


% Demo 1: Two points w/ varying distances
if show_demo_1 == 1
    figure(1);
    points = [2,2; 5,5];
    for k = 1:60
        clf;
        hold on;
        axis equal;
        axis([-2, 12, -2, 12]);

        distances = [k / 20, 3];
        plot_access_points(points, distances);
        estimate = estimate_location_multilateration(points, distances);
        h = plot(estimate(1), estimate(2), 'o');
        set(h, 'Color', 'r');

        M1(k) = getframe;
    end;
    for k = 1:50
        clf;
        hold on;
        axis equal;
        axis([-2, 12, -2, 12]);

        distances = [3, 3 - k / 20];
        plot_access_points(points, distances);
        estimate = estimate_location_multilateration(points, distances);
        h = plot(estimate(1), estimate(2), 'o');
        set(h, 'Color', 'r');

        M1(k + 60) = getframe;
    end;
    for k = 1:50
        clf;
        hold on;
        axis equal;
        axis([-2, 12, -2, 12]);

        distances = [3 - k / 20, 0.5];
        plot_access_points(points, distances);
        estimate = estimate_location_multilateration(points, distances);
        h = plot(estimate(1), estimate(2), 'o');
        set(h, 'Color', 'r');

        M1(k + 110) = getframe;
    end;
end;

% Demo 2: Three points showing how location and distance affet the
% prediction
if show_demo_2 == 1
    figure(2);
    clf;
    hold on;
    axis equal;
    axis([-2, 12, -2, 12]);
    
    points = [2,2; 6,2; 4,2*sqrt(3) + 2];
    distances = [2.5, 2.5, 2.5];
    plot_access_points(points, distances);
    
    estimate = estimate_location_multilateration(points, distances);
    h = plot(estimate(1), estimate(2), 'o');
    set(h, 'Color', 'r');
    
    % Pause for a sec at the beginning
    for k = 1:10
        M2(k) = getframe;
    end;
    
    % Change the location
    for k = 1:60
        
        points(1,1) = 2 + k / 20;
        
        clf;
        hold on;
        axis equal;
        axis([-2, 12, -2, 12]);
        plot_access_points(points, distances);
        
        estimate = estimate_location_multilateration(points, distances);
        h = plot(estimate(1), estimate(2), 'o');
        set(h, 'Color', 'r');
        
        M2(k + 10) = getframe;
    end;
    
    for k = 1:40
        
        distances(1) = 2.5 - k / 20;
        
        clf;
        hold on;
        axis equal;
        axis([-2, 12, -2, 12]);
        plot_access_points(points, distances);
        
        estimate = estimate_location_multilateration(points, distances);
        h = plot(estimate(1), estimate(2), 'o');
        set(h, 'Color', 'r');
        
        M2(k + 70) = getframe;
    end;
end;

% Demo 3: Lots of access points
figure(2);
clf;
hold on;
axis equal;
axis([-8, 8, -8, 8]);

radius = 4;
d = 0:pi/4:2*pi - pi/4;
points = radius * transpose([cos(d); sin(d)]);
distances = 2.65 * ones(1, 8);

plot_access_points(points, distances);

estimate = estimate_location_multilateration(points, distances);
h = plot(estimate(1), estimate(2), 'o');
set(h, 'Color', 'r');

% Pause for a sec at the beginning
for k = 1:10
    M3(k) = getframe;
end;

for k=1:30
    clf;
    hold on;
    axis equal;
    axis([-8, 8, -8, 8]);
    
    points(1, 1) = points(1, 1) + 0.1;
    plot_access_points(points, distances);

    estimate = estimate_location_multilateration(points, distances);
    h = plot(estimate(1), estimate(2), 'o');
    set(h, 'Color', 'r');
    
    M3(k + 10) = getframe;
end;
for k=1:30
    clf;
    hold on;
    axis equal;
    axis([-8, 8, -8, 8]);
    
    points(2, 1) = points(2, 1) + 0.1 * cos(pi/4);
    points(2, 2) = points(2, 2) + 0.1 * sin(pi/4);
    plot_access_points(points, distances);

    estimate = estimate_location_multilateration(points, distances);
    h = plot(estimate(1), estimate(2), 'o');
    set(h, 'Color', 'r');
    
    M3(k + 40) = getframe;
end;
for k=1:30
    clf;
    hold on;
    axis equal;
    axis([-8, 8, -8, 8]);
    
    points(3, 2) = points(3, 2) + 0.1;
    plot_access_points(points, distances);

    estimate = estimate_location_multilateration(points, distances);
    h = plot(estimate(1), estimate(2), 'o');
    set(h, 'Color', 'r');
    
    M3(k + 10) = getframe;
end;
for k=1:30
    clf;
    hold on;
    axis equal;
    axis([-8, 8, -8, 8]);
    
    points(4, 1) = points(4, 1) + 0.1 * cos(3*pi/4);
    points(4, 2) = points(4, 2) + 0.1 * sin(3*pi/4);
    plot_access_points(points, distances);

    estimate = estimate_location_multilateration(points, distances);
    h = plot(estimate(1), estimate(2), 'o');
    set(h, 'Color', 'r');
    
    M3(k + 40) = getframe;
end;