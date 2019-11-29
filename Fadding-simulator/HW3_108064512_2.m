%% HW3-2
clear all;
close all;
clc;

%%
M = [8 16];
N = 4*M + 2;

bias = 1200;
Times = (1:1:10^4);parpool('local',core_number);
PlotLength = 300;
DopplerTime = [0.01, 0.1, 0.5];
alpha = 0;

beta = cell(length(M), 1);
theta = cell(length(M), 1);
gi = zeros(length(DopplerTime), length(M), length(Times));
gq = zeros(length(DopplerTime), length(M), length(Times));
gi_osc = zeros(length(DopplerTime), length(M), length(Times));
gq_osc = zeros(length(DopplerTime), length(M), length(Times));

envelope = zeros(length(DopplerTime), length(M), length(Times));
envelope_dB = zeros(length(DopplerTime), length(M), length(Times));

AutoCorr = cell(length(DopplerTime),length(M));
Tau = cell(length(DopplerTime));


for i = 1:length(M)
    figure(i)
    beta{i} = (pi/M(1, i)):(pi/M(1, i)):pi;
    theta{i} = (2*pi/N(1, i)):(2*pi/N(1, i)):(2*pi);
    for j = 1:length(DopplerTime)
        for k = 1+bias:bias+length(Times)
            for n = 1:M(1, i)
                gi_osc(j, i, k-bias) = 2^(0.5)*(2*cos(beta{i}(1, n))*cos(2*pi*DopplerTime(1, j)*k*cos(theta{i}(1, n)))) + gi_osc(j, i, k-bias);
                gq_osc(j, i, k-bias) = 2^(0.5)*(2*sin(beta{i}(1, n))*cos(2*pi*DopplerTime(1, j)*k*cos(theta{i}(1, n)))) + gq_osc(j, i, k-bias); 
            end
            gi(j, i, k-bias) = gi_osc(j, i, k-bias) + 2 * cos(alpha)*cos(2*pi*DopplerTime(1, j) * k);
            gq(j, i, k-bias) = gq_osc(j, i, k-bias) + 2 * sin(alpha)*cos(2*pi*DopplerTime(1, j) * k);
            envelope(j, i, k-bias) = (gi(j, i, k-bias) + 1j*(gq(j, i, k-bias)));
            envelope_dB(j, i, k-bias) = 10*log10(abs(envelope(j, i, k-bias)));
        end
        AutoCorr{j, i} = autocorr(reshape(envelope(j, i, :), [1, length(Times)]), 10/DopplerTime(1, j));
        Tau{j} = 0:DopplerTime(1,j):10;
        
        subplot(length(DopplerTime), 1, j)
        plot(1:300, reshape(envelope_dB(j, i, 1:PlotLength), [PlotLength, 1]));
        if j==1
            hold on
        end
        title(['channel output for fmT = ', num2str(DopplerTime(1, j))]);
        xlabel('Time (t/T)');
        ylabel('Envelope (dB)');
        grid on
    end   
end

for i = 1:length(M)
    figure(i+2)
    for j = 1:length(DopplerTime)
        plot(Tau{j}, reshape(AutoCorr{j, i}, [length(AutoCorr{j, i}), 1]));
        if j==1
            hold on
        end
        title(['M = ', num2str(M(i))]);
        xlabel('fm*£n');
        ylabel('Autocorrelation');
        grid on
    end
    legend('fmT = 0.01','fmT = 0.1','fmT = 0.5');
end





