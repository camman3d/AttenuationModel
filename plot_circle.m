% Circle plotter
% The argument circ is a vector containing x, y, and radius in that order
function plot_circle(circ)
%0.01 is the angle step, bigger values will draw the circle faster but
%you might notice imperfections (not very smooth)
ang=0:0.01:2*pi; 
xp=circ(3)*cos(ang);
yp=circ(3)*sin(ang);
plot(circ(1)+xp,circ(2)+yp);
end


