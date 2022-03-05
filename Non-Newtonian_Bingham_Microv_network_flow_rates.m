%% Bingham fluid - flow rates for varying inflow pressure

%%
P1vec=[];
P3= 0;
P4= 0;
%Radiae for Bingham in microns
R12=15; 
R23=7.5; 
R24=7.5;
% The length is measured in microns
L1=150000; 
L2=13000; 
L3=13000; 
eta=5e-4;
tau01=5e-3; 
tau02=0.05;
tau03=5e-3;
P2vec=[];
fvalvec=[];
tauR1vec=[];
tauR2vec=[];
tauR3vec=[];
Q12vec=[];
Q23vec=[];
Q24vec=[];
tau02vec=[];
DeltaPvec=[]; 

%% Loop through P1 from high to low and use the previous solution of P2 as initial guess
P1v=1:1:2000;
i=length(P1v);
for P1=2000:-1:1
    P1vec(i)=P1;
    P1
    if i==length(P1v)
        [P2vec(i),fvalvec(i)] = fsolve(@(P2) fP2(P2,P1,P3,P4,L1,L2,L3,R12,R23,R24,tau01,tau03,tau02,eta), 10^3);
        P1
        tauR1vec(i)=abs(P1-P2vec(i))*R12/(2*L1);
        tauR2vec(i)=abs(P2vec(i)-P3)*R23/(2*L2);
        tauR3vec(i)=abs(P2vec(i))*R24/(2*L3);
        if (tau01<=tauR1vec(i))&&(tau02<=tauR2vec(i))&&(tau03<=tauR3vec(i))
             Q12=(pi.*R12.^4.*abs(P1-P2vec(i)))./(8.*eta.*L1).*(1-(4.*tau01)/(3.*tauR1vec(i))+(tau01.^4)/(3.*tauR1vec(i).^4));
             Q12vec(i)=Q12;
             Q23=(pi.*R23.^4.*abs(P2vec(i)-P3))./(8.*eta.*L2).*(1-(4.*tau02)/(3.*tauR2vec(i))+(tau02.^4)./(3.*tauR2vec(i).^4));
             Q23vec(i)=Q23;
             Q24vec(i)=Q12vec(i)-Q23vec(i);
        end
    
     else
       
        [P2vec(i),fvalvec(i)] = fsolve(@(P2) fP2(P2,P1,P3,P4,L1,L2,L3,R12,R23,R24,tau01,tau03,tau02,eta), P2vec(i+1));
        tauR1vec(i)=abs(P1-P2vec(i))*R12/(2*L1);
        tauR2vec(i)=abs(P2vec(i)-P3)*R23/(2*L2);
        tauR3vec(i)=abs(P2vec(i))*R24/(2*L3);
        if (tau01<=tauR1vec(i))&&(tau02<=tauR2vec(i))&&(tau03<=tauR3vec(i))
             Q12=(pi.*R12.^4.*abs(P1-P2vec(i)))./(8.*eta.*L1).*(1-(4.*tau01)/(3.*tauR1vec(i))+(tau01.^4)/(3.*tauR1vec(i).^4));
             Q12vec(i)=Q12;
             Q23=(pi.*R23.^4.*abs(P2vec(i)-P3))./(8.*eta.*L2).*(1-(4.*tau02)/(3.*tauR2vec(i))+(tau02.^4)./(3.*tauR2vec(i).^4));
             Q23vec(i)=Q23;
             Q24vec(i)=Q12vec(i)-Q23vec(i);
        else
             Q12=(pi.*R12.^4.*abs(P1-P2vec(i)))./(8.*eta.*L1).*(1-(4.*tau01)/(3.*tauR1vec(i))+(tau01.^4)/(3.*tauR1vec(i).^4));
             Q12vec(i)=Q12;
             Q23=0;
             Q23vec(i)=Q23;
             Q24vec(i)=Q12vec(i)-Q23vec(i);
             
         end
        
    end
i=i-1;
end


%% Plot flow rates in the inflow, experimental and bifurcation channels for the inflow pressure
col1=[0, 0.4470, 0.7410]; %blue
col2=[0.8500, 0.3250, 0.0980]; %orange
col3=[0.9290, 0.6940, 0.1250]; %yellow
col4=[0.6350, 0.0780, 0.1840]; %burgundy
figure('Renderer', 'painters', 'Position',[10 10 600 300])
hold all
grid on
plot(P1vec,Q12vec,'Color',col3,'LineWidth',1.5)
plot(P1vec,Q24vec,'Color',col2,'LineWidth',1.5)
plot(P1vec(abs(fvalvec)<1e-20),Q23vec(abs(fvalvec)<1e-20),'Color',col1,'LineWidth',1.5)
xlim([100 2000])
ax = gca;
ax.FontSize = 13;
xlabel('Inflow pressure P_1 (Pa)')
ylabel('Flow rates Q (\mum^3/s)')
title({'Flow rates in each channel of the microvascular network','for increasing values of initial pressure in the inflow channel'})
lgd=legend('Q_{12} - inflow channel','Q_{24} - bifurcation channel','Q_{23} - experimental channel','Location','NortheastOutside')
title(lgd,'Flow rates (\mum^3/s)')

hold off

%% Plotting P_2 for P_1
figure()
hold all
grid on
plot(P1vec(abs(fvalvec)<1e-5),P2vec(abs(fvalvec)<1e-5),'LineWidth',1.5)
xlim([120 2000])
ax = gca;
ax.FontSize = 13;
xlabel('Inflow pressure P_1 (Pa)')
ylabel('Pressure at bifurcation node P_2 (Pa)')
title({'Behaviour of pressure at the bifurcation node','for increasing values of initial pressure in the inflow channel'})
hold off

%% Plotting the wall shear stress for the inflow pressure (input parameter)
figure()
hold all
grid on
plot(P1vec(abs(fvalvec)<1e-5),tauR2vec(abs(fvalvec)<1e-5),'LineWidth',1.5)
plot(P1vec(abs(fvalvec)<1e-5),tauR3vec(abs(fvalvec)<1e-5),'LineWidth',1.5)
plot(P1vec(abs(fvalvec)<1e-5),tauR1vec(abs(fvalvec)<1e-5),'LineWidth',1.5)
xlim([100 2000])
ax = gca;
ax.FontSize = 13;
xlabel('Inflow pressure P_1 (Pa)')
ylabel('Wall shear stress for each vessel \tau_R (Pa)')
title({'Behaviour of the wall shear stress in each channel','in the microvscular network for increasing the inflow pressure'})
lgd=legend('\tau_{R_{2}} - experimental channel','\tau_{R_{3}} - bifurcation channel','\tau_{R_{1}} - inflow channel','Location','NortheastOutside')
title(lgd,'Wall shear stress (Pa)')
hold off
%% Function of mass conservation at the bifurcation node
function G=fP2(P2,P1,P3,P4,L1,L2,L3,R12,R23,R24,tau01,tau03,tau02,eta)
P3= 0;
P4= 0;
% Radius is in microns for Binham
R12=15; 
R23=7.5; 
R24=7.5;
% The length is measured in microns
L1=150000; 
L2=13000; 
L3=13000;  
eta=5e-4;
tau01=5e-3; 
tau02=0.05;
tau03=5e-3; 
% if statement with wall shear stress 
tauR1=abs(P1-P2)*R12/(2*L1);
tauR2=abs(P2-P3)*R23/(2*L2);
tauR3=abs(P2)*R24/(2*L3);
if (tau01<=tauR1)&&(tau02<=tauR2)&&(tau03<=tauR3)
    Q12=(pi.*R12.^4.*(abs(P1-P2)))./(8.*eta.*L1).*(1-(4.*tau01)/(3.*tauR1)+(tau01.^4)/(3.*(tauR1).^4));
    Q23=(pi.*R23.^4.*(abs(P2-P3)))./(8.*eta.*L2).*(1-(4.*tau02)/(3.*tauR2)+(tau02.^4)/(3.*(tauR2).^4));
    Q24=(pi.*R24.^4.*(abs(P2-P4)))./(8.*eta.*L3).*(1-(4.*tau03)/(3.*tauR3)+(tau03.^4)/(3.*(tauR3).^4));

elseif (tau03>=tauR3)
    Q12=(pi.*R12.^4.*(abs(P1-P2)))./(8.*eta.*L1).*(1-(4.*tau01)/(3.*tauR1)+(tau01.^4)/(3.*(tauR1).^4));
    Q23=(pi.*R23.^4.*(abs(P2-P3)))./(8.*eta.*L2).*(1-(4.*tau02)/(3.*tauR2)+(tau02.^4)/(3.*(tauR2).^4));
    Q24=0;
elseif (tau02>=tauR2)
    Q12=(pi.*R12.^4.*(abs(P1-P2)))./(8.*eta.*L1).*(1-(4.*tau01)/(3.*tauR1)+(tau01.^4)/(3.*(tauR1).^4));
    Q23=0;
    Q24=(pi.*R24.^4.*(abs(P2-P4)))./(8.*eta.*L3).*(1-(4.*tau03)/(3.*tauR3)+(tau03.^4)/(3.*(tauR3).^4));
elseif (tau01>=tauR1)
    Q12=0;
    Q23=(pi.*R23.^4.*(abs(P2-P3)))./(8.*eta.*L2).*(1-(4.*tau02)/(3.*tauR2)+(tau02.^4)/(3.*(tauR2).^4));
    Q24=(pi.*R24.^4.*(abs(P2-P4)))./(8.*eta.*L3).*(1-(4.*tau03)/(3.*tauR3)+(tau03.^4)/(3.*(tauR3).^4));

    
end
G=Q12-Q23-Q24;
end