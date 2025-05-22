%% MainDriver_sim.m

%% -------- Size of signal and Set noise level --------
% size of signal and impulse response function
n=301;
ChamberVolume=16626;% ChamberVolume (L)
Fo = 62; % flow rate (L/min)
FV=Fo/ChamberVolume;

params = GetSetup_sim(n,FV);

A=params.Hfull;
A=A*100/ChamberVolume;
params.b=params.b;
bb=params.b;

[U,s,V] = csvd(A);
[x_discrep,lambda_disc] = discrep(U,s,V,bb,0.033);% 0.003 for norm of measurement error

lambda_l = l_curve(U,s,bb,'Tikh');  
x_tikh_l = tikhonov (U, s, V, bb, lambda_l);

figure
subplot(2,1,1),
plot(x_discrep, 'LineWidth',1.5),title('x discrepancy'),hold on

subplot(2,1,2),
plot(x_tikh_l, 'LineWidth',1.5),title('x L-curve'),hold off