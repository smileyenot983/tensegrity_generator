function [points] = cube_stack_grid(N,n_stacks)

    n = n_stacks * (N^3);
    points = zeros(3,n);
    
    points(:,1:n/n_stacks) = cube_grid(N);
    
    step_size = n/n_stacks;
    for i=2:n_stacks
        
        points(:,(i-1)*step_size+1:i*step_size) = cube_grid(N);

        points(3,(i-1)*step_size+1:i*step_size) = points(3,(i-1)*step_size+1:i*step_size) + points(3,(i-1)*step_size) + ...
            (points(3,(i-1)*step_size) - points(3,(i-1)*step_size-1));
        

    end