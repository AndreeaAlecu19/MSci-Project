%% Setup
close all, clear all  clc
format long, format compact
set(0,'defaulttextfontsize');

%% 1. Newtonian flow in a single cylindrical channel (Poiseuille velocity profile)
%Equation: u(y)=G/(2mu)(a^2-y^2), which in polar coordinates is
%u(r)=G/(2mu)(a^2-r^2)=deltaP/(2mu L)*(a^2-r^2)
a=15;
%However, our maximum velocity is : delta P/(4muL)a^2. so we must have a
%pressure drop in order for the velocity to occur
%set pressure drop:
P1=11000;
P2m=1000;
%Need vmax to be positive, so:
deltaP=abs(P1-P2m);
L=13000;
G=deltaP/L;
mu=5e-4; % Viscosity of blood is roughly 5 times more than the viscosity of water, viscosity of water is 1.0016 milipascals x second
n=100; 
r=linspace(-a,a,n);

for i=1:length(r)
    umax=deltaP/(4*mu*L)*a.^2;
    u(i)=umax*(1-r(i).^2/a.^2);
    i=i+1;
end
figure()
hold all
grid on
ax = gca;
ax.FontSize = 13;
plot(u,r,'LineWidth',1.5)
title('Velocity profile of Poiseuille flow in a pipe')
xlabel('Velocity (\mum/s)');
ylabel('Radius (\mum)');
hold off
