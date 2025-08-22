%% MainDriver_sim.m
%% -------- Size of signal and Set noise level --------
n=300;
ChamberVolume=16626;
Fo = 62;
noise=0.002; noise=noise/100*ChamberVolume;

error_norm=sqrt((noise^2)*n);
FV=Fo/ChamberVolume;

%prompt="fresh O2"; 
%fO2 = input(prompt)
fO2 =20.93;

%prompt="fresh CO2"; 
%fCO2 = input(prompt)
fCO2 =0.03;
 
% -------- impulse response function --------
for j = 1 : n
        t=j-1;
        h(j)=exp(-FV*t); 
end
ht=transpose(h);

% -------- Define H matrix --------
Hfull = matrixH(ht,'zero'); % zero, periodic or reflexive

rng(0)
gas=fopen('rectangular.txt');
g=textscan(gas,'%f %f %f');
g=cell2mat(g);
t=g(:,1);
bb=g(:,2);
cc=g(:,3);

fO2 =20.93;
    
for i=1:n
    b(i,1)= (fO2-bb(i))/100*ChamberVolume;
    c(i,1)= (cc(i)-fCO2)/100*ChamberVolume;
end

A=Hfull;

[U,s,V] = csvd(A);
[x_discrep,lambda_disc] = discrep(U,s,V,b,error_norm);

lambda_l = l_curve(U,s,b,'Tikh');  
x_tikh_l = tikhonov (U, s, V, b, lambda_l);

figure
subplot(2,1,1),
plot(x_discrep, 'LineWidth',1.5),title('x discrepancy'),hold on

subplot(2,1,2),
plot(x_tikh_l, 'LineWidth',1.5),title('x L-curve'),hold off

[U,s,V] = csvd(Hfull);
[cx_discrep,clambda_disc] = discrep(U,s,V,c,error_norm);

clambda_l = l_curve(U,s,c,'Tikh');  
cx_tikh_l = tikhonov (U, s, V, c, clambda_l);

figure
subplot(2,1,1),
plot(cx_discrep, 'LineWidth',1.5),title('cx discrepancy'),hold on
subplot(2,1,2),
plot(cx_tikh_l, 'LineWidth',1.5),title('cx L-curve'),hold off