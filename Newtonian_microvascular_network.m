%% Newtonian flow in a microvascular network

%% Find blood flow rate Q_{23} from various values of vascular resistance R_{23}:
% Flow rates are Q12, Q23, Q24;
% Vascular resistances are R12, R23, R24;
% Pressures at nodes 1,2,3,4 are P1, P2, P3, P4.
% Note that P1 is the initial pressure and P3=P4 (usually set to atmospheric pressure).

% Initialising pressures
P1= 10342.1;
P3= 0;
P4= 0;

% Initialising vascular resistances
R12= 0.0197;
R24= 0.0048;

Q23checkvec=zeros(); % Creating a vector for the flow rate Q23
R23vec=zeros();  % Initialising a vector for R23
N=300; %Number of iterations
R23=0.01; % Initialising R23 with a value close to the one for R12 and R24

for i=(1:N*N-1)    
    R23vec(i)=R23;
    Q23check= (R24.*(P1-P3))./(R12.*R23+R23.*R24+R12.*R24);
    Q23checkvec(i)=Q23check;  
    R23=R23+0.00001;
end

disp('---------')
fprintf("\n Maximum of Q_{23} is "+max(Q23checkvec)+"")
fprintf("\n Minimum of Q_{23} is "+min(Q23checkvec)+"" )
fprintf("\n Maximum of R_{23} is "+max(R23vec)+"")
fprintf("\n Minimum of R_{23} is "+min(R23vec)+"")

plot(R23vec,Q23checkvec,'LineWidth',1.5)
ax = gca;
ax.FontSize = 12;
grid on
%title({'Evolution of the flow rate Q_{23} for increasing vscular resistance R_{23}','in the experimental channel'});
xlabel(' Vascular resistance R_{23} (sPa/\mum^3)');
ylabel('Flow rate Q_{23} (\mum^3/s)');

%% Find vascular resistance R_{23} from blood flow rate Q_{23}:
P1= 10342.1;
P3= 0;
P4= 0;
R12= 0.0197; 
R24= 0.0048;
Q23=100000;
Q23vec=zeros();
Q23vecelbow=zeros();
R23vec=zeros();
R23vecelbow=zeros();
N=3000;
figure()

for i=(1:N*N-1)  
    R23=(R24.*(P1-P3)-R12.*R24.*Q23)./(Q23.*(R12+R24));
    R23e=(R24.*(P1-P3)-R12.*R24.*Q23)./(Q23.*(R12+R24));
    R23vec(i)=R23;
    if R23e>0
        R23vecelbow(i)=R23e;
        Q23vecelbow(i)=Q23;
    end
    Q23vec(i)=Q23;
    Q23=Q23+1;    
end

hold on
plot(Q23vecelbow,R23vecelbow,'LineWidth',1.5);
ax = gca;
ax.FontSize = 12;
grid on
xlabel('Flow rate Q_{23} (\mum^3/s) ');
ylabel('Vascular resistance R_{23} (sPa/\mum^3)');
%title('Behaviour of vascular resistance R_{23} for increasing flow rate Q_{23}')
hold off

disp('---------')
fprintf("\n Maximum of Q_{23} is "+max(Q23vec)+"")
fprintf("\n Minimum of Q_{23} is "+min(Q23vec)+"" )
fprintf("\n Maximum of R_{23} is "+max(R23vec)+"")
fprintf("\n Minimum of R_{23} is "+min(R23vec)+"")

%% 3. Inverting the matrix from the system Ax=b, where x contains the pressures, and b is a vector containing the initial conditions

% By applying the initial conditions, we have that A is 
A = [1,0,0,0;1./(1+R12.*(1./R24+1./R23)), -1, 1./(1+R23.*(1./R12+1./R24)), 1./(1+R24.*(1./R12+1./R23)); 0,0,1,0; 0,0,0,1];
x = @(P2)[P1; P2; P3; P4];
b = @(P1,P3,P4)[P1;0;P3;P4];
Ainv= inv(A);

% Compute  Ainv x = Ainv b:
x = Ainv*b (10342.1,0,0);
P2m= x(2,1); % Pressure P2 obtained in the matrix method
% Checking that P2m is the same as P2 from the analytical method.
P2check=(P1*R23*R24+P3*R12*R24+P4*R12*R23)/(R12*R23+R23*R24+R12*R24);


%% Comparing pressure results from the matrix method and analytical formula

P1= 10342.1;
P3= 0;
P4= 0;
R12= 0.0197;
R24= 0.0048;
N=200;
R23vec=zeros();
R23=0.01;
Q23mvec=zeros();
P2mvec=zeros();
P2checkvec=zeros();
Q23checkvec=zeros();
for i=(1:N*N-1)
A = [1,0,0,0;1./(1+R12.*(1./R24+1./R23)), -1, 1./(1+R23.*(1./R12+1./R24)), 1./(1+R24.*(1./R12+1./R23)); 0,0,1,0; 0,0,0,1];
x = @(P2)[P1; P2; P3; P4];
b = @(P1,P3,P4)[P1;0;P3;P4];
Ainv= inv(A);

% Compute  Ainv x = ainv b:
x = Ainv*b (10342.1,0,0);

P2mvec(i)=x(2,1);
P2check=(P1*R23*R24+P3*R12*R24+P4*R12*R23)/(R12*R23+R23*R24+R12*R24);
P2checkvec(i)=P2check;

Q23m=(x(2,1)-P3)./R23;
Q23mvec(i)=Q23m;
Q23check= (R24.*(P1-P3))./(R12.*R23+R23.*R24+R12.*R24);
Q23checkvec(i)=Q23check;

R23vec(i)=R23;
R23=R23+0.00001;
end

figure()
col1=[0.9290, 0.6940, 0.1250];
col2=[0, 0.4470, 0.7410];
plot(R23vec,P2mvec,'LineWidth',8,'Color',col1)
ax = gca;
ax.FontSize = 12;
%title({'Behaviour of pressure P_2 at the bifurcation node',' for increasing vascular resistance R_{23} in experimental channel'});
xlabel('Vascular resistance R_{23} (sPa/\mum^3)');
ylabel('Pressure P_2 (Pa)');
hold on
plot(R23vec,P2checkvec,'LineWidth',2,'Color',col2)
legend('Computational method', 'Analytical method','Location','southeast')
hold off

%% Using all of the experimental data to find the resistance and P2,and plot the pressure at the bifurcation node and the flow rates in the experimetal channel, for measured resistance in the experimental channel
%Setup
close all, clear all  clc
format long, format compact
set(0,'defaulttextfontsize');

P1= [10342.14, 10342.14,10342.14,9652.664,10342.14,9652.664,11031.616,8273.712,8273.712,8963.188,10342.14,11031.616];
P3= 0;
P4= 0;
R12=[0.017795,0.034959,0.029012,0.020721,0.029312,0.029738,0.028381,0.023578,0.023004,0.024334,0.028240,0.028227];
R24= [0.004304,0.008455,0.007016,0.005011,0.007089,0.007192,0.006864,0.005702,0.005563,0.005885,0.006830,0.006827];
Q23=[107831.2911,103439.5969,90534.75004,108441.3691,67977.40257,81647.78622,90601.98373,112680.6005,91764.45458,106360.7948,96027.00166,90601.98373; 176666.8292,109522.3682,142311.2801,140537.8684,116055.2116,116972.5259,172788.2912,129690.5514,122419.5495,159516.278,128121.6234,173634.0856;259244.674,131959.1373,159013.3876,207795.1317,157385.6085,144785.188,173381.6911,156528.7219,160431.0175,164301.7909,163357.6219,174328.5949; 261091.207,142882.9361,197299.2777,213129.4099,167337.4652,156063.1839,172834.384,171236.5237,156620.1578,170463.9112,162325.8996,173907.2717];
% first row of Q23 is for 0% concentration; second 6%, third 12%, fourth 21%

R23vec=zeros(4,12);
P2mvec=zeros(4,12);
P2vec=zeros(4,12);
Q23mvec=zeros(4,12);
Q23checkvec=zeros(4,12);
for i=1:size(Q23,1)
    for j=(1:12)
    R23=(R24(j).*(P1(j)-P3)-R12(j).*R24(j).*Q23(i,j))./(Q23(i,j).*(R12(j)+R24(j)));
    R23vec(i,j)=R23;
% We now have values of R2 stored in R2 vector above. Go to the matrix to
% input these R2 and output P.
    A = [1,0,0,0;1./(1+R12(j).*(1./R24(j)+1./R23)), -1, 1./(1+R23.*(1./R12(j)+1./R24(j))), 1./(1+R24(j).*(1./R12(j)+1./R23)); 0,0,1,0; 0,0,0,1];
    x = @(P2)[P1(j); P2; P3; P4];
    b = @(P1,P3,P4)[P1;0;P3;P4];
    Ainv= inv(A);
    
    x = Ainv*b (P1(j),P3,P4); % Compute  Ainv Ax = Ainv b:
    
    P2mvec(i,j)=x(2,1); % P2= x(2,1);
    P2check=(P1(j)*R23*R24(j)+P3*R12(j)*R24(j)+P4*R12(j)*R23)/(R12(j)*R23+R23*R24(j)+R12(j)*R24(j));
    P2vec(i,j)=P2check;
    
    Q23m=(x(2,1)-P3)./R23;
    Q23mvec(i,j)=Q23m;
    Q23check= (R24(j).*(P1(j)-P3)+(P4-P3)*R12(j))./(R12(j).*R23+R23.*R24(j)+R12(j).*R24(j));
    Q23checkvec(i,j)=Q23check;
    end

       
end
col1=[0, 0.4470, 0.7410]; %blue
col2=[0.8500, 0.3250, 0.0980]; %orange
col3=[0.9290, 0.6940, 0.1250]; %yellow
col4=[0.4660 0.6740 0.1880]; % green

figure('Renderer', 'painters', 'Position',[10 10 600 300])     
grid on
a0m=scatter(R23vec(1,:),Q23mvec(1,:),60, 'k'); hold on
a1m=scatter(R23vec(1,:),Q23mvec(1,:),60, 'MarkerEdgeColor',col1,'LineWidth',1.5); hold on
a2m=scatter(R23vec(2,:),Q23mvec(2,:),60, 'MarkerEdgeColor',col2,'LineWidth',1.5); hold on
a3m=scatter(R23vec(3,:),Q23mvec(3,:),60, 'MarkerEdgeColor',col3,'LineWidth',1.5); hold on
a4m=scatter(R23vec(4,:),Q23mvec(4,:),60, 'MarkerEdgeColor',col4,'LineWidth',1.5); hold on

hold on

a0c=scatter(R23vec(1,:),Q23checkvec(1,:), 10,'k','+'); hold on
a1c=scatter(R23vec(1,:),Q23checkvec(1,:), 10,'+','MarkerEdgeColor',col1); hold on
a2c=scatter(R23vec(2,:),Q23checkvec(2,:), 10,'+','MarkerEdgeColor',col2); hold on
a3c=scatter(R23vec(3,:),Q23checkvec(3,:), 10,'+','MarkerEdgeColor',col3); hold on
a4c=scatter(R23vec(4,:),Q23checkvec(4,:), 10,'+','MarkerEdgeColor',col4); hold on
ax=gca;
ax.FontSize = 13;

lgd1=legend([a1m a2m a3m a4m a0m a0c],{'0% O_2','6% O_2','12% O_2','21% O_2','Computational method','Analytical method'}, 'Location','northeast'); 
lgd1.FontSize=12;
title(lgd1,{'Oxygen tension (% O_2)',' and the method used'})

hold off
%title({'Blood flow rate in the experimental channel','for decreasing oxygen tension (% O_2)'});
xlabel('Vascular resistance R_{23} (sPa/\mum^3)');
ylabel('Flow rate Q_{23} (\mum^3/s)');

% Plotting the pressure and the vascular resistance 
figure('Renderer', 'painters', 'Position',[10 10 600 300])

grid on
b0m=scatter(R23vec(1,:),P2mvec(1,:),60, 'k'); hold on
b1m=scatter(R23vec(1,:),P2mvec(1,:),60, 'MarkerEdgeColor',col1,'LineWidth',1.5); hold on
b2m=scatter(R23vec(2,:),P2mvec(2,:),60, 'MarkerEdgeColor',col2,'LineWidth',1.5);hold on
b3m=scatter(R23vec(3,:),P2mvec(3,:),60, 'MarkerEdgeColor',col3,'LineWidth',1.5);hold on
b4m=scatter(R23vec(4,:),P2mvec(4,:),60, 'MarkerEdgeColor',col4,'LineWidth',1.5); hold on

hold on
b0c=scatter(R23vec(1,:),P2vec(1,:),10,'k','+'); hold on
b1c=scatter(R23vec(1,:),P2vec(1,:),10,'r','+','MarkerEdgeColor',col1);hold on
b2c=scatter(R23vec(2,:),P2vec(2,:),10,'g','+','MarkerEdgeColor',col1);hold on
b3c=scatter(R23vec(3,:),P2vec(3,:),10,'b','+','MarkerEdgeColor',col1);hold on
b4c=scatter(R23vec(4,:),P2vec(4,:),10,'m','+','MarkerEdgeColor',col1); hold on
ax=gca;
ax.FontSize = 13;
lgd2=legend([b1m b2m b3m b4m b0m b0c],{'0% O_2','6% O_2','12% O_2','21% O_2','Computational method','Analytical method'}, 'Location','southeast');
lgd2.FontSize=12;
title(lgd2,{'Oxygen tension (% O_2)',' and the method used'})
hold off

%title({'Pressure P_2 at the bifurcation node',' for decreasing oxygen tension (%) O_2'});
xlabel('Vascular resistance R_{23} (sPa/\mum^3)');
ylabel('Pressure at bifurcation node P_2 (Pa)');
