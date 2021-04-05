clc;
close all;
clear all;
cvx_clear;
cvx_solver Gurobi_2;


% seed = 3;
% exp_num = 1;
% rng(seed);


% cube grid constraints : 
% strut_max_length = 4; 
% cable_max_length = 4; 
% projection_max_length = 4;

% % arc constraints:
% strut_max_length = 5; 
% cable_max_length = 5; 
% projection_max_length = 5;
 
% % cylinder constraints:
% strut_max_length = 4;
% cable_max_length = 4;
% projection_max_length = 4;

% sphere constraints
strut_max_length = 15; 
cable_max_length = 15; 
projection_max_length = 15;

strut_constraint = false;
cable_constraint = false;
projection_constraint=false;


%% GRID
    
% test cases without projection constraint:
% test_cases = [false,false,false;true,false,false;false,true,false;true,true,false];
% 
test_cases = [false,false,false;true,true,true];

% test_cases = [false,false,false; true,false,false; false,true,false; true,true,false;...
%     false,false,true; false,false,true; false,false,true; false,false,true];


grid_structure = "sphere";

n_nodes=20;

titles = ["without constraints","rod constraint","cable constraint","cable + rod constraint",...
    "x axis constraint","y axis constraint","z axis constraint","x+y axis constraint"];

% titles = ["without constraints","x axis constraint","y axis constraint","z axis constraint"];

% timemap_simple = containers.Map;
% timemap_constr= containers.Map;

all_axis = ["x","y","z","xy"];

timemap_simple = [];
timemap_constr= [];


seed = 10;

% for seed=21:30
for n_nodes=10:2:50
    
    foldername = strcat("last_tests/",string(seed));
    mkdir(foldername);
    
    axis_ctr = 1;
    projection_axis = "0";

    for i=1:size(test_cases,1)

        strut_constraint = test_cases(i,1);
        cable_constraint = test_cases(i,2);
        projection_constraint=test_cases(i,3);
        
        if projection_constraint==true
            projection_axis = all_axis(axis_ctr);
            axis_ctr = axis_ctr +1;
        end
        
        
        start = tic;

        sol = run_experiment(seed,n_nodes,true,grid_structure,strut_constraint,strut_max_length,cable_constraint,cable_max_length,...
            projection_constraint,projection_axis,projection_max_length);
        
        stop = toc(start);

        if i==1
            timemap_simple(end+1) = stop;
        else
            timemap_constr(end+1) = stop;
        end
        
        
        
%         dataname = strcat(grid_structure,"_",string(seed),"_","c_constr:",string(cable_constraint),"_","s_constr:",string(strut_constraint),...
%             "_","proj_constr:",string(projection_constraint),"_ax:",projection_axis,".mat");

%         filename = strcat(foldername,"/",dataname);
%         save(filename,"sol");


%         check_title = strcat("cable:",string(cable_constraint)," strut:",string(strut_constraint),...
%             " projection:",string(projection_constraint)); 
%         visualize_solution(sol,3,filename,titles(i));

        close all;
    end
end
% saveas(figure1,strcat(foldername,"/",grid_structure,"exp:",string(exp_num),'.png'));
save("timemap_simple");
save(timemap_constr);


