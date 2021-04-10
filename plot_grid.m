grid_structure = "cube";
grid_structure = "cube stacks";
grid_structure = "sphere";
grid_structure = "cylinder";
grid_structure = "arc";

switch grid_structure
    case "cube"
        N=3;
        points = cube_grid(N);
    case "cube stacks"
        N=3;
        stacks = 2;
        points = cube_stack_grid(N,stacks);
    case "sphere"
        n = 500;
        radius = 10;
        points = sphere_grid(radius,n);
    case "cylinder"
        n = 100;
        radius = 2;
        points = cylinder_grid(radius,n);
    case "arc"        
        n_rad=2;
        n_wid=3;
        n_ang = 10;
        points = arc_grid2(n_rad,n_wid,n_ang);
    otherwise
        disp("Unknown grid")
        
end

        
scatter3(points(1,:),points(2,:),points(3,:));