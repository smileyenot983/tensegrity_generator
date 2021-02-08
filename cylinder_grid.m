function [points] = cylinder_grid(radius,n_points)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%     radius fixed
    

    angle = linspace(0,6.28,n_points/4);
    height = linspace(0,4,4);
    
    [theta, r, h] = meshgrid(angle, radius, height);

    [x,y,z] = pol2cart(theta,r,h);
    
    points(1,:) = x(:);
    points(2,:) = y(:);
    points(3,:) = z(:);
    
    
end