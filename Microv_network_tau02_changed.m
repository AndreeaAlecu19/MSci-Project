%%  Flow rates in the microvascular networks when the yield stress in the experimental channel varies
%%
P1=10342.1;
P3= 0;
P4= 0;
% Radius is in microns
R12=15; 
R23=7.5;
R24=7.5;
% The length is measured in microns
L1=150000; 
L2=13000; 
L3=13000; 
eta=5.008e-4;
tau01=5e-3; 
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
i=1;
for tau02=0:0.01:2
    if i==155
        break
    end
[P2vec(i),fvalvec(i)] = fsolve(@(P2) fP2(P2,P1,P3,P4,L1,L2,L3,R12,R23,R24,tau01,tau03,tau02,eta), 10^5);
tauR1vec(i)=(P1-P2vec(i))*R12/(2*L1);
tauR2vec(i)=(P2vec(i)-P3)*R23/(2*L2);
tauR3vec(i)=P2vec(i)*R24/(2*L3);
    if (tau01<=tauR1vec(i))&&(tau02<=tauR2vec(i))&&(tau03<=tauR3vec(i))
         Q12=(pi.*R12.^4.*(P1-P2vec(i)))./(8.*eta.*L1).*(1-(4.*tau01)/(3.*tauR1vec(i))+(tau01.^4)/(3.*tauR1vec(i).^4));
         Q12vec(i)=Q12;
         Q23=(pi.*R23.^4.*(P2vec(i)-P3))./(8.*eta.*L2).*(1-(4.*tau02)/(3.*tauR2vec(i))+(tau02.^4)./(3.*tauR2vec(i).^4));
         Q23vec(i)=Q23;
         Q24vec(i)=Q12vec(i)-Q23vec(i);
    end
    %same pressure drop, same radius, same geometries in figure 4.1 ; newtonian computation, put 3 black dots on the y axis for yield stress being 0 caption
    %see figure 4.1, consider newtonian and use the same parameters
    if tau02==0
        tau01N=0;
        tau02N=0;
        tau03N=0;
        Q12N=(pi.*R12.^4.*(P1-P2vec(i)))./(8.*eta.*L1).*(1-(4.*tau01)/(3.*tauR1vec(i))+(tau01.^4)/(3.*tauR1vec(i).^4));
        Q23N=(pi.*R23.^4.*(P2vec(i)-P3))./(8.*eta.*L2).*(1-(4.*tau02)/(3.*tauR2vec(i))+(tau02.^4)./(3.*tauR2vec(i).^4));
        Q24N=Q12N-Q23N;
    end
tau02vec(i)=tau02;
i=i+1;
end
figure('Renderer', 'painters', 'Position',[800 500 800 400])
grid on
xlabel('Yield stress in experimental channel \tau_{02} (Pa)')
%title({'Flow rates in the microvascular network',' for increasing yield stress in the experimental channel'})
hold all
yyaxis left
ylabel('Flow rates Q (\mum^3/s)')
ha=plot(tau02vec(abs(fvalvec)<1e-5),Q23vec(abs(fvalvec)<1e-5),'LineWidth',1.5);
scatter(tau02N,Q23N,70,'o','filled');
ax=gca;
ax.FontSize = 13;
%b0c=scatter(R23vec(1,:),P2vec(1,:),10,'k','+'); hold on
ylim([0 900000]);

yyaxis right
ylabel('Flow rates Q (\mum^3/s)')
hb=plot(tau02vec(abs(fvalvec)<1e-5),Q24vec(abs(fvalvec)<1e-5),'LineWidth',1.5)
hc=plot(tau02vec(abs(fvalvec)<1e-5),Q12vec(abs(fvalvec)<1e-5),'LineWidth',1.5)
scatter(tau03N,Q24N,100,'o','filled');
scatter(tau01N,Q12N,70,'o','filled');
ax=gca;
ax.FontSize = 13;

%scatter(tau02N,Q23N,50,'o','filled');
xlim([-0.1 1.6]);


legend([ha hb hc],'Q_{23} - experimental channel','Q_{24} - bifurcation channel','Q_{12} - inflow channel')
hold off
saveas(gcf,'Flow rate for different values of yield stress tau02 in the experimental channel','png')

%%
function G=fP2(P2,P1,P3,P4,L1,L2,L3,R12,R23,R24,tau01,tau03,tau02,eta)
P1=10342.1;
P3= 0;
P4= 0;
% Radius is in microns
R12=15; 
R23=7.5;
R24=7.5;

% The length is measured in microns
L1=150000; 
L2=13000; 
L3=13000; 
eta=5.008e-4;
tau01=5e-3; 
tau03=5e-3;

Q12=(pi.*R12.^4.*(P1-P2))./(8.*eta.*L1).*(1-(4.*tau01)/(3.*(P1-P2)*R12/(2*L1))+(tau01.^4)/(3.*((P1-P2)*R12/(2*L1)).^4));
Q23=(pi.*R23.^4.*(P2-P3))./(8.*eta.*L2).*(1-(4.*tau02)/(3.*(P2)*R23/(2*L2))+(tau02.^4)/(3.*(P2*R23/(2*L2)).^4));
Q24=(pi.*R24.^4.*(P2-P4))./(8.*eta.*L3).*(1-(4.*tau03)/(3.*(P2)*R24/(2*L3))+(tau03.^4)/(3.*(P2*R24/(2*L3)).^4));
G=Q12-Q23-Q24;
end

