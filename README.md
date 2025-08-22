Deconvolution for Metabolic Chamber
This is the Matlab code for implementing an algorithm for human open-circuit whole-room indirect calorimetry by deconvolution with a regularization parameter.
AUTHORS:
Insung Park, [park.insung.ge@u.tsukuba.ac.jp]
International Institute for Integrative Sleep Medicine, University of Tsukuba, Japan.

Hitomi Ogata, [hitomi.ogata@gmail.com]
Graduate School of Humanities and Social Sciences, Hiroshima University, Japan.

Kumpei Tokuyama, [tokuyama.kumpei.gf@u.tsukuba.ac.jp]
International Institute for Integrative Sleep Medicine, University of Tsukuba, Japan.
       
REFERENCE:
"Algorithm for transient response of human open-circuit whole-room indirect calorimetry: a review and future perspective". 2025.

SOFTWARE LANGUAGE:
MATLAB (R2024a)

The MainDriver requires the following packages:

(1)	Regularization Tools by Per Christian Hansen.
 	https://jp.mathworks.com/matlabcentral/fileexchange/52-regtools

(2)	IR Tools by Silvia Gazzola.
https://jp.mathworks.com/matlabcentral/fileexchange/95008-irtools

(3)	AIR Tools by Per Christian Hansen.
https://github.com/jakobsj/AIRToolsII

MainDriver_forSample
1.	reads data of text file (raw_data.txt), which contains time (min), O2 concentration (%) and CO2 concentration (%), 
2.	assigns O2 and CO2 concentration at discrete time (0,1,2,3 …n),
3.	returns the follows:  
x_discrep: 	time course of O2 consumption rate (l/min) by discrepancy method.
x_tikh_l: 	time course of O2 consumption rate (l/min) by L-curve method.
cx_discrep: 	time course of CO2 production rate (l/min) by discrepancy method.
cx_tikh_l: 	time course of CO2 production rate (l/min) by L-curve method.
lambda_disc: 	gamma value for O2 consumption by discrepancy method.
lambda_l: 	ganna value for O2 consumption by L-curve method.
clambda_disc: 	gamma value for CO2 production by discrepancy method.
clambda_l: 	gamma value for CO2 production by discrepancy method.

MainDriver_ forSimulation 
1.	reads data of text file (rectangular.txt), in which time is already assigned as discrete value (0,1,2,3,…n).

Simulation data is in an Excel sheet “raw_data for simulation.xlsx”.




2025 August 20
