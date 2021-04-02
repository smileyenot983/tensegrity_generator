function [points] = arc_grid2(n_rad,n_wid,n_ang);
% 

% n_rad=2;
% n_wid=2;
% n_ang = 10;

points = zeros(3,n_rad*n_wid*n_ang);
angle = linspace(0,pi,n_ang);

min_rad=3;
last_index=1;
for i=1:n_rad
    x = (i-1+min_rad)*cos(angle); 
    y = (i-1+min_rad)*sin(angle);
    
    for j=1:n_ang
        
        for k = 1:n_wid
            points(:,last_index) = [x(j);y(j);k];
            last_index =last_index+1;
        end
        
    end
    
end

end

