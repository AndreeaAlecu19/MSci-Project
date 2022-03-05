%% Setup
close all, clear all  clc
format long, format compact
set(0,'defaulttextfontsize');

%% 1. Newtonian flow in a single cylindrical channel (Poiseuille velocity profile)
%Equation: u(y)=G/(2mu)(a^2-y^2), which in polar coordinates is
%u(r)=G/(2mu)(a^2-r^2)=deltaP/(2mu L)*(a^2-r^2)
a=0.08;
%However, our maximum velocity is : delta P/(4muL)a^2. so we must have a
%pressure drop in order for the velocity to occur
%set pressure drop:
P1=10;
P2m=60;
%Need vmax to be positive, so:
deltaP=abs(P1-P2m);
L=1;
mu=5.008e-4; % Viscosity of blood is roughly 5 times more than the viscosity of water, viscosity of water is 1.0016 milipascals x second
n=100; 
r=linspace(-a,a,n);
%We must find the maximum velocity, which occurs at r=0.
umax=deltaP/(4*mu*L)*a.^2;
%The mean velocity:
u=umax*(1-r.^2/a.^2);
figure()
grid on;
ax = gca;
ax.FontSize = 13;
set( ax, 'XLim', [0,1e3] )
hold all
if P1==P2m
    disp('There is no pressure difference, so there is no velocity in the vessel');    
else  % for different pressures:
    for t=1:6
        displacement=u*t;
        plot(ax,displacement,r,'Color', '#0072BD','LineWidth',1.5);
        title('Velocity profile of Poiseuille flow in a pipe')
        xlabel('Velocity (\mum/s)');
        ylabel('Radius (\mum)');
        pause(1)
    end  
end
