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
% strut_max_length = 15; 
% cable_max_length = 15; 
% projection_max_length = 15;
% 
% strut_constraint = false;
% cable_constraint = false;
% projection_constraint=false;


%% GRID
    
% test cases without projection constraint:
% test_cases = [false,false,false;true,false,false;false,true,false;true,true,false];
% 
test_cases = [false,false,false;true,true,true];

% test_cases = [false,false,false; true,false,false; false,true,false; true,true,false;...
%     false,false,true; false,false,true; false,false,true; false,false,true];


% ___________________-HYPERPARAMETERS____________________________
grid_structure = "arc";
n_seeds = 10;
num_nodes = 10:2:5      0;
%___________________________________________________________________

switch grid_structure
    case "cube stacks"
        strut_max_length = 4; 
        cable_max_length = 4; 
        projection_max_length = 4;
    case "sphere"
        strut_max_length = 15; 
        cable_max_length = 15; 
        projection_max_length = 15;
    case "cylinder"
        strut_max_length = 4;
        cable_max_length = 4;
        projection_max_length = 4;
    case "arc"        
        strut_max_length = 6; 
        cable_max_length = 6; 
        projection_max_length = 6;
    otherwise
        warning("Wrong grid was chosen");
end

% n_nodes=20;

titles = ["without constraints","rod constraint","cable constraint","cable + rod constraint",...
    "x axis constraint","y axis constraint","z axis constraint","x+y axis constraint"];

% titles = ["without constraints","x axis constraint","y axis constraint","z axis constraint"];

% timemap_simple = containers.Map;
% timemap_constr= containers.Map;

all_axis = ["x","y","z","xy"];

% timemap_simple = [];
% timemap_constr= [];

timemap_simple = zeros(n_seeds,size(num_nodes,2));
timemap_constr= zeros(n_seeds,size(num_nodes,2));



% for seed=21:30

iteration = 1;
% for n_nodes=10:2:12
for n=num_nodes(1):2:num_nodes(end)
    
    
%     foldername = strcat("last_tests/",string(seed));
%     mkdir(foldername);
    
    axis_ctr = 1;
    projection_axis = "0";

    for i=1:size(test_cases,1)

        strut_constraint = test_cases(i,1);
        cable_constraint = test_cases(i,2);
        projection_constraint = test_cases(i,3);
        
        if projection_constraint==true
            projection_axis = all_axis(axis_ctr);
            axis_ctr = axis_ctr +1;
        end
        
%         timemap_node_simple = [];
%         timemap_node_constr = [];
        
        timemap_node = [];
        
        for seed=101:101+n_seeds-1
            
            start = tic;

            sol = run_experiment(seed,n,true,grid_structure,strut_constraint,strut_max_length,cable_constraint,cable_max_length,...
                projection_constraint,projection_axis,projection_max_length);

            stop = toc(start);

            timemap_node(end+1) = stop;
        
        end


        
        if i==1
%             timemap_simple(end+1) = mean(timemap_node);
            timemap_simple(:,iteration) = timemap_node;
        else
%             timemap_constr(end+1) = mean(timemap_node);
            timemap_constr(:,iteration) = timemap_node;
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
    iteration = iteration+1;
end
% saveas(figure1,strcat(foldername,"/",grid_structure,"exp:",string(exp_num),'.png'));
% save("timemap_arc_20seeds");
filename = strcat("tmap_",grid_structure,"_",string(n_seeds));
save(filename);
% save(timemap_constr);

figure();
simple_averages = mean(timemap_simple,1);
plot(num_nodes,simple_averages);
xlabel("number of nodes");
ylabel("time taken[s]");
title("Without constraints");

figure();
constr_averages = mean(timemap_constr,1);
plot(num_nodes,constr_averages);
xlabel("number of nodes");
ylabel("time taken[s]");
title("With constraints");



