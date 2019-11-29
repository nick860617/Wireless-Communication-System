%% Initialization
clear all;
close all;
clc;

%% HW2
V = 20;         % km/hr
C = 3*10^8;     % m/s 
Fc = 2*10^9;    % 1/s
Fm = ((V*(1000/3600))/C)*Fc;
sample = 10^4;
point = 10^3;

r = unifrnd(-pi, pi, [1, sample]);
Fd = cos(r).*Fm;
benchmark = min(Fd):(max(Fd)-min(Fd))/point:max(Fd);
cdf_s = zeros(1, length(benchmark));

for i=1:length(cdf_s)
    Cumulative_number = 0;
    for j=1:length(Fd)
        if Fd(j)>benchmark(i)
            Cumulative_number = Cumulative_number + 1;
        end
    cdf_s(i) = 1-Cumulative_number/length(r);
    end
end

pdf_s = smooth(diff(cdf_s));

%% ===========================  HW2-(a)  ===============================
error = 10;
for i=0:0.0005:0.1
    if abs(1-sum(pdf_s+i)*(max(Fd)-min(Fd))/point)<error
        error = abs(1-sum(pdf_s+i)*(max(Fd)-min(Fd))/point);
        Bias = i;
    end
end

figure
yyaxis left
plot(benchmark(2:end), pdf_s+Bias); hold on

yyaxis right
plot(benchmark, cdf_s); hold off

yyaxis right
ylim([0, 1]);

xticks(round(benchmark(1):(benchmark(end)-benchmark(1))/10:benchmark(end)))
grid on
xlabel("Doppler Shift (Hz)");
legend({"Probability Density Function", "Cumulative Distribution Function"})
title("Simulation Result")
print("-djpeg", "-r600", "a.jpg");
