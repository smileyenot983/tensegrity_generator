function [] = visualize_solution(solution,n_fixed)
%VISUALIZE_GENERATION Summary of this function goes here
%   Detailed explanation goes here
    points = solution.points;
    C = solution.C;
    R = solution.R;
    n = size(points,2);
    for i=1:n
        P = points(:,i);
        
        text(P(1), P(2), P(3), num2str(i) ,'HorizontalAlignment','left','FontSize',16);
        for j=1:n
            if C(i,j)==1
                P1 = points(:,i);
                P2 = points(:,j);
                plot3([P1(1), P2(1)], [P1(2), P2(2)], [P1(3), P2(3)], ...
                    'LineWidth', 2, 'Color', [147,112,219]/255); hold on;
            
            end
            
            if R(i,j)==1
                P1 = points(:,i);
                P2 = points(:,j);
                plot3([P1(1), P2(1)], [P1(2), P2(2)], [P1(3), P2(3)], ...
                    'LineWidth', 7, 'Color', [128,128,0]/255); hold on;
                
            end

        end
        
    end
    
    plot3(points(1, :)', points(2, :)', points(3, :)', 'o', 'MarkerFaceColor', 'r')
    plot3(points(1, 1:n_fixed)', points(2, 1:n_fixed)', points(3, 1:n_fixed)', 'o', 'MarkerFaceColor', 'g')

    axis equal

    
end

