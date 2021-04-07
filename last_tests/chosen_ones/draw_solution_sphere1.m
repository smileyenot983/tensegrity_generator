path = "sphere";
solutions = dir(path);
valid_solutions = string.empty;
title = "without constraints";

img_indicator = ".png";
for i=3:size(solutions,1)
    if  ~contains(solutions(i).name,img_indicator)
        valid_solutions(end+1) = strcat(path,"/",solutions(i).name); 
    end
end

name = mfilename;
solution_num = name(end);

current_solution = valid_solutions(str2double(solution_num));

load(current_solution);

visualize_solution(sol,3,title,title);
