figure(1);
clf;
hold on;

% Values
pd0 = -15.52;
beta = 1.719;

a = -90.55;
b = 0.1355;
c = 69.38;

p1 = -103.2;
p2 = -416.6;
q1 = 17.06;

% Plot the data points
h = scatter(dataX, dataY, 'x');
xlabel('Distance (m)');
ylabel('RSSI');

% Plot the log-normal
x = 0:0.01:60;
y = pd0 - 10 * beta * log(x);
h = plot(x,y,'-');
set(h, 'Color', 'r');

% Plot the power
y = a*power(x,b)+c;
h = plot(x,y,'-');
set(h, 'Color', 'g');

% Plot the rational (need a for loop because there is division)
for x = 0:0.01:60
    y = (p1*x + p2) / (x + q1);
    h = plot(x,y,'-');
    set(h, 'Color', 'c');
end;