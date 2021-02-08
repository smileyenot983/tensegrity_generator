clc;
close all;
cvx_clear;
cvx_solver Gurobi_2;

%TODO:
% 1. new grid(sphere, cylinder) DONE!!
% 2. avoid unconnected solutions DONE!!
% 3. save results and make it reproducible DONE!!



%% GRID

grid_structure = "cylinder";

switch grid_structure
    case "cube"
        N=3;
        points = cube_grid(N);
    case "sphere"
        n = 50;
        radius = 10;
        points = sphere_grid(radius,n);
    case "cylinder"
        n = 100;
        radius = 10;
        points = cylinder_grid(radius,n);
    otherwise
        n = 10;
        points = randn(3,n);
        
end

% plotting grid structure
scatter3(points(1,:),points(2,:),points(3,:));


%%

% after building grid of some shape we choose n points in this grid, to
% generate tensegrity
n = size(points,2);
m = 2;
n_nodes= 8;
available_slots = 1:n;
random_permutation = randperm(numel(available_slots));
chosen_slots = random_permutation(1:n_nodes);


chosen_points = points(:,chosen_slots);
n = n_nodes;
points = chosen_points;

Dir = zeros(n, n, 3);
for i = 1:n
    for j = 1:n
        
        Dir(i, j, :) = reshape( (points(:, i) - points(:, j)), [1, 1, 3] );
        
    end
end
Dir_t = permute(Dir, [3, 2, 1]);



% figure('Color', 'w', 'Name', 'arrow array')
% for i = 1:n
%     for j = 1:n
%         
%         arrow3d(...
%             'start', [i; j; 0], ...
%             'stop',  [i; j; 0] + reshape(Dir(i, j, :), [3, 1, 1]), ...
%             'ang', 15); 
%         hold on;
%         
%     end
% end
% 
% axis equal;
   
%%
external_force = repmat([0;0;-9.8], [1, n]);    

big_M = 10;

cvx_begin

variable R(n, n) binary
variable C(n, n) binary
% variable Q(n, n)

variable f(n, n)
variable g(3, m)


minimize( sum(C(:)) )
subject to

    C == C';
    R == R';
    
    diag(R) == zeros(n, 1);
    diag(C) == zeros(n, 1);
    
    sum(R, 1) == ones(1, n);
    sum(R, 2) == ones(n, 1);
    
    P = C+R;
    P(:) <= ones(n*n, 1);
    

    for i = 1:n
        for j = 1:n
           f(i, j) <= big_M * C(i, j);
          -f(i, j) <= big_M * R(i, j);
        end
    end
    
    g_ext = [g, zeros(3, n-m)];
    
    for i = 1:n
        Dir_t(:, :, i) * f(i, :)' == external_force(:, i) + g_ext(:, i);
    end
    
    
%     forces = zeros(3, n);
%     for i = 1:n
%         for j = 1:n
%            forces(:, i) = forces(:, i) + reshape(Dir(i, j, :), [3, 1, 1])*f(i, j);
%         end
%     end
%     
%     forces == external_force;
    
cvx_end

C = full(C);
R = full(R);
f = full(f);

%%
% Checking if all nodes are connected
% Using depth-first search(DFS)

current_graph = graph(C + R);
connection_check = dfsearch(current_graph,1);
if size(connection_check,1) ~= n
    warning("Not all nodes are connected");
end


%% Saving into a file

solution.points = points;
solution.C = C;
solution.R = R;

filename = "good_shape.mat";
save(filename,"solution");

load(filename);
points = solution.points;
C = solution.C;
R = solution.R;

%% 

visualize = true;
if visualize
    visualize_solution(solution,m);
end


