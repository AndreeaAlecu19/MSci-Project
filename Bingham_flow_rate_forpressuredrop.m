%% Vary pressure drop and show that flow rate in Bingham is non-linear

R=15;
eta=5e-4;
tau0=0.005;
L=13000;
i=1;
DeltaP=1000;
DeltaPvec=[];
tauRvec=[];
for i=1:10
    tauR=DeltaP*R/(2*L);
    if (tau0<=tauR)
        tauRvec(i)=tauR;
        DeltaPvec(i)=DeltaP;
        tauRvec(i)=tauR;
        Qvec= pi*R*DeltaP/(8*eta*L)*(1-4/3*tau0/tauR+1/3*(tau0/tauR)^2);
        Qvec(i)=Qvec;
    end
    DeltaP=DeltaP+1;
    i=i+1;
end

figure('Renderer', 'painters', 'Position',[10 10 600 300])
hold all
grid on
plot(DeltaPvec,Qvec)
ax = gca;
ax.FontSize = 13;
xlabel('Pressure drop \Delta P (Pa)')
ylabel('Flow rate Q (\mum^3/s)')
%title({'Flow rate for Bingham fluid','for increasing pressure drop'})
hold off

%% Flow rate for pressure drop newtonian:
R=0.2;
Qvec=[];
DeltaPvec=[];
DeltaP=1;
for i=1:10
    DeltaPvec(i)=DeltaP;
    Q=DeltaP/R;
    Qvec(i)=Q;
    DeltaP=DeltaP+1;
    i=i+1;
end


figure('Renderer', 'painters', 'Position',[10 10 600 300])
hold all
grid on
plot(DeltaPvec,Qvec)
ax = gca;
ax.FontSize = 13;
xlabel('Pressure drop \Delta P (Pa)')
ylabel('Flow rate Q (\mum^3/s)')
%title({'Flow rate for Newtonian fluid','for increasing pressure drop'})
hold off



