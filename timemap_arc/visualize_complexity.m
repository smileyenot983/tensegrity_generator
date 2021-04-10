close all;
clc;


filename = "timemap_arc_5seeds.mat";

load(filename);


num_nodes = 10:2:50;

figure();
plot(num_nodes,timemap_simple);
xlabel("number of nodes");
ylabel("time taken[s]");
title("Without constraints");

figure();
plot(num_nodes,timemap_constr);
xlabel("number of nodes");
ylabel("time taken[s]");
title("With constraints");