%% MainDriver_sim.m
%prompt="n = ";% size of signal and impulse response function
%n=input(prompt);
%n=1480;

prompt="Chamber Volume = ";
ChamberVolume=input(prompt);% ChamberVolume (L)
%ChamberVolume=16626;

prompt="Fo = "; 
Fo = input(prompt);%62; % flow rate (L/min)
%Fo=109;
FV=Fo/ChamberVolume;

prompt="last data min = ";
lastMin=input(prompt);% 
n=lastMin;

%prompt="noise% = ";
%noise=input(prompt);% noise = 0.002%
noise=0.002;

noise=noise/100*ChamberVolume;
error_norm=sqrt((noise^2)*n);

% -------- impulse response function --------
    for j = 1 : n
        t=j-1;
        h(j)=exp(-FV*t); %%% debug for eq 5
    end
    ht=transpose(h);
    
    % -------- Define H matrix --------
    Hfull = matrixH(ht,'zero'); % zero, periodic or reflexive

    % -------- read data --------
    gas=fopen('raw_data.txt');
    g=textscan(gas,'%f %f %f');
    
    g=cell2mat(g);
    t=g(:,1);
    bb=g(:,2);
    cc=g(:,3);

    prompt="fresh O2 = ";
    fO2 = input(prompt);
    %fO2=20.93;
    prompt="fresh CO2 = "; 
    fCO2 = input(prompt);
    %fCO2=0.03;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
iO2(1)  = bb(1);
iCO2(1) = cc(1);

BBB=[]; 
CCC=[];  

j=1;
k=1;
for i = 1:lastMin-1
    j=1;  %%%%%% temporary %%%%%%%%%
    while t(j)<i+1
        if  t(j)>=i-1
            BBB(k)=bb(j); CCC(k)=cc(j);k=k+1;
        end;
        j=j+1;
    end;  
    
    i=i+1;    
    iO2(i)=median(BBB); iCO2(i)=median(CCC);
    BBB=[]; CCC=[]; 
    j=1;k=1;
    end;   

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for i=1:n
        % -----------20250727----------------
        b(i,1)=(fO2-iO2(i)-ht(i)*((fO2-iO2(1))))/100*ChamberVolume;
        % -----------20250727----------------
    end
    [U,s,V] = csvd(Hfull);
    [x_discrep,lambda_disc] = discrep(U,s,V,b,error_norm);

    lambda_l = l_curve(U,s,b,'Tikh');  
    x_tikh_l = tikhonov (U, s, V, b, lambda_l);

    figure
    subplot(2,1,1),
    plot(x_discrep, 'LineWidth',1.5),title('x discrepancy'),hold on
    subplot(2,1,2),
    plot(x_tikh_l, 'LineWidth',1.5),title('x L-curve'),hold off

    for i=1:n
        % -----------20250727----------------
        c(i,1)=(iCO2(i)-fCO2-ht(i)*((iCO2(1)-fCO2)))/100*ChamberVolume;
        % -----------20250727----------------
    end
    [U,s,V] = csvd(Hfull);
    [cx_discrep,clambda_disc] = discrep(U,s,V,c,error_norm);

    clambda_l = l_curve(U,s,c,'Tikh');  
    cx_tikh_l = tikhonov (U, s, V, c, clambda_l);

    figure
    subplot(2,1,1),
    plot(cx_discrep, 'LineWidth',1.5),title('cx discrepancy'),hold on
    subplot(2,1,2),
    plot(cx_tikh_l, 'LineWidth',1.5),title('cx L-curve'),hold off