close all;
clear all;
clc;


filename = "tmap_arc_10.mat";

load(filename);


num_nodes = 10:2:50;

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