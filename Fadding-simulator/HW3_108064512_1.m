%% HW3-1
clear all;
close all;
clc;

%%
DopplerTime = [0.01, 0.1, 0.5];
Times = 1:1:10^4;
plotlength = 300;
gi = zeros(length(DopplerTime), length(Times));
gq = zeros(length(DopplerTime), length(Times));
envelope = zeros(length(DopplerTime), length(Times));
envelope_dB =  zeros(length(DopplerTime), length(Times));

auto_correlation = cell(length(DopplerTime), 1);
Tau = cell(length(DopplerTime), 1);

figure(1)
for i= 1:length(DopplerTime)
    zeta =  2 - cos(pi*DopplerTime(1,i)/2) - ((2-cos(pi*DopplerTime(1,i)/2))^2-1)^0.5;
    wi = normrnd(0, ((1+zeta)/(1-zeta)/2)^0.5, 1 ,length(Times));
    wq = normrnd(0, ((1+zeta)/(1-zeta)/2)^0.5, 1 ,length(Times));
    
    % Initialization
    gi(i, 1) = (1-zeta)*wi(1);
    gq(i, 1) = (1-zeta)*wq(1);
    
    for k = 2:length(Times)   % the low pass filter model
        gi(i,k) = zeta*gi(i,k-1) + (1-zeta)*wi(1, k);   
        gq(i,k) = zeta*gq(i,k-1) + (1-zeta)*wq(1, k);   
        envelope(i, k) = gi(i,k) + 1j*gq(i,k); 
        envelope_dB(i, k) = 10*log10(abs(envelope(i, k)));
    end 
    auto_correlation{i} = autocorr(envelope(i, :), 10/DopplerTime(1, i)) ;
    Tau{i} = 0:DopplerTime(1, i):10;
    
    subplot(length(DopplerTime), 1, i);
    plot(Times(1:plotlength), envelope_dB(i, 1:plotlength));
    title(['fmT = ',num2str(DopplerTime(1, i))]);
    xlabel('Time,t/T');
    ylabel('Envelope Level (dB)');
    grid on
end

figure(2)
for k = 1:length(DopplerTime)
    plot(Tau{k}, auto_correlation{k});
    if k ~= length(Times)
        hold on
    end
    grid on
end
legend('fmT = 0.01','fmT = 0.1','fmT = 0.5');
xlabel('fm*£n');
ylabel('Autocorrelation');
title('Comparsion of Autocorrelation');


