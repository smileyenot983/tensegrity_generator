
% loading solutions with arc grid
arc_path = "last_tests/chosen_ones/arc";
arc_solutions = dir(arc_path);
arc_valid_solutions = string.empty;

img_indicator = ".png";
for i=3:size(arc_solutions,1)
    if  ~contains(arc_solutions(i).name,img_indicator)
        arc_valid_solutions(end+1) = strcat(arc_path,"/",arc_solutions(i).name); 
    end
end

mfilename('fullpath')
mfilename






% loading solutions with cube grid
% cube_path = "last_tests/chosen_ones/cube_stacks";
% cube_solutions = dir(cube_path);
% cube_valid_solutions = string.empty;
% 
% img_indicator = ".png";
% for i=3:size(cube_solutions,1)
%     if  ~contains(cube_solutions(i).name,img_indicator)
%         cube_valid_solutions(end+1) = strcat(cube_path,"/",cube_solutions(i).name); 
%     end
%     
% end
% 
% % loading solutions with cylinder grid
% cylinder_path = "last_tests/chosen_ones/cylinder";
% cylinder_solutions = dir(cylinder_path);
% cylinder_valid_solutions = string.empty;
% 
% img_indicator = ".png";
% for i=3:size(cylinder_solutions,1)
%     if  ~contains(cylinder_solutions(i).name,img_indicator)
%         cylinder_valid_solutions(end+1) = strcat(cylinder_path,"/",cylinder_solutions(i).name); 
%     end
%     
% end
% 
% 
% % loading solutions with sphere grid
% sphere_path = "last_tests/chosen_ones/sphere";
% sphere_solutions = dir(sphere_path);
% sphere_valid_solutions = string.empty;
% 
% img_indicator = ".png";
% for i=3:size(sphere_solutions,1)
%     if  ~contains(sphere_solutions(i).name,img_indicator)
%         sphere_valid_solutions(end+1) = strcat(sphere_path,"/",sphere_solutions(i).name); 
%     end
%     
% end


visualized_grid = "sphere";
solution_number = 1;

load(sphere_valid_solutions(1));
title = sphere_valid_solutions(1)'
visualize_solution(sol,3,title,title);



