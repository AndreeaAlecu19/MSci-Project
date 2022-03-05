%% Plotting the network of blood vessels
close all, clear all  clc
format long, format compact
set(0,'defaulttextfontsize');
figure
syms x y;
x=linspace(0,5);
y=0; 
figure(1)
plot(x,y); 
line(xlim, [0,0],'Color', 'k', 'LineWidth', 2); % Draw line for X axis.
xlim([-2 12]);
ylim([-7 7]);
text(2,-.5,'R_{12}')
text(2,0.5,'Q_{12}') 
hold on;
x=0;
y=0;
plot(x,y,'o', 'MarkerSize', 10, 'Color', 'b')
text(-.5,-1,' P_{1}')
axis off
hold on
x = linspace(5, 10);
y1 = x-5;
plot(x, y1,'Color', 'k','LineWidth', 2)
text(7,1.5,'R_{23}')
text(7,3.5,'Q_{23}') 
hold on;
x=5;
y=0;
plot(x,y,'o', 'MarkerSize', 10, 'Color', 'b')
text(4.5,-1,' P_{2}')
x=10;
y=5;
plot(x,y,'o', 'MarkerSize', 10, 'Color', 'b')
text(10.5,5,' P_{3}')
hold on
x = linspace(5, 10);
y2= -x+5;
plot(x,y2,'Color', 'k','LineWidth', 2)
text(7,-3.5,'R_{24}')
text(7,-1.5,'Q_{24}')
hold on;
x=10;
y=-5;
plot(x,y,'o', 'MarkerSize', 10, 'Color', 'b')
text(10.5,-5,' P_{4}')