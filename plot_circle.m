function plot_circle(c, r)
    a = 0:0.01:2*pi;
    points = [transpose(c(1) + r * cos(a)), transpose(c(2) + r * sin(a))];
    plot(points(:, 1), points(:, 2), '-');
end