function [points] = arc_grid(radius,n_points)

angle = linspace(0,pi,n_points);
x = radius*cos(angle);
y = radius*sin(angle);
% width \in [0,4]


% points = [x;y];

width = 4;
z = 1:width;

points = zeros(3,n_points*width);

for i=1:n_points-1
   points(:,4*i) = [x(i);y(i);z(1)];
   points(:,4*i+1) = [x(i);y(i);z(2)];
   points(:,4*i+2) = [x(i);y(i);z(3)];
   points(:,4*i+4) = [x(i);y(i);z(4)];
end

end

