%% Plot the Bingham Fluid velocity profile
close all, clear all  clc
format long, format compact
set(0,'defaulttextfontsize');
P1=10342.1;
P2=2000;
deltaP=P1-P2;
R=7.5;
eta=5e-4;
L=13000;
r=linspace(-R,R,100);
figure('Renderer', 'painters', 'Position',[10 10 600 300])
tau0vec=0:0.5:2;
N=length(tau0vec);
for i=1:N
    tau0=tau0vec(i);
    r0=2*L*tau0/deltaP;
    f=@(r) ((deltaP/(4*eta*L)*R.^2*(1-(r/R).^2)-tau0*R/eta*(1-r/R)).*(r>r0)+(deltaP*R.^2/(4*eta*L)*(1-r0/R).^2).*((r0>r)&(r>-r0))+(deltaP/(4*eta*L)*R.^2*(1-(r/R).^2)-tau0*R/eta*(1+r/R)).*((-r0>r)));
    plot(f(r),r,'LineWidth',1.5)
    hold on
end
ax = gca;
ax.FontSize = 13;
lgd=legend(strcat('\tau_0=',string(tau0vec)),'Orientation','horizontal','Location','NorthEast')
title(lgd,'Yield stress(Pa)')
grid on
xlabel('Velocity (\mum/s)')
ylabel('Radius (\mum)')
title({'Velocity profile for Bingham flow in a pipe for different values of yield stress (Pa)'})
saveas(gcf,'Bingham flow in a pipe for different values of tau0','png')