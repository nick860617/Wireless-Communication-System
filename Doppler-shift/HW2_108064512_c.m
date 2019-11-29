%% Initialization
clear all;
close all;
clc;

%% ===========================  HW2-(c)  ===============================
sample = 10^5;
Fc_ = 2*10^9;
C = 3*10^8;
point = 10^3;
theta = unifrnd(-pi, pi, [1, sample]);
vs = (1000/3600)*unifrnd(20, 90, [1, sample]);
Fms = (1/C)*Fc_*vs;
Fds = cos(theta).*Fms;

benchmark_ = min(Fds):(max(Fds)-min(Fds))/point:max(Fds);
cdf_s = zeros(1, length(benchmark_));

for i=1:length(cdf_s)
    if mod(i, 10)==0
        i
    end
    Cumulative_number = 0;
    for j=1:length(Fds)
        if Fds(j)>benchmark_(i)
            Cumulative_number = Cumulative_number + 1;
        end
    cdf_s(i) = 1-Cumulative_number/length(theta);
    end
end
pdf_s = smooth(diff(cdf_s));

error = 10;
for i=0:0.0005:0.1
    if abs(1-sum(pdf_s+i)*(max(Fds)-min(Fds))/point)<error
        error = abs(1-sum(pdf_s+i)*(max(Fds)-min(Fds))/point);
        Bias = i;
    end
end

figure
yyaxis left
plot(benchmark_(2:end), pdf_s+Bias); hold on

yyaxis right
plot(benchmark_, cdf_s, 'LineWidth', 3); hold off

yyaxis right
ylim([0, 1]);

xticks(round(benchmark_(1):(benchmark_(end)-benchmark_(1))/10:benchmark_(end)))
grid on
xlabel("Doppler Shift (Hz)");
legend({"Probability Density Function", "Cumulative Distribution Function"})
title("Simulation Result")
print("-djpeg", "-r600", "c.jpg");