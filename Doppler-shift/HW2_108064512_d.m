%% Initialization
clear all;
close all;
clc;

%%  ====================  HW2-(d)  ==========================
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
    if mod(i, 10)==0
        i
    end
    Cumulative_number = 0;
    for j=1:length(Fd)
        if Fd(j)>benchmark(i)
            Cumulative_number = Cumulative_number + 1;
        end
    cdf_s(i) = 1-Cumulative_number/length(r);
    end
end

pdf_s = smooth(diff(cdf_s));

error = 10;
for i=0:0.0005:0.1
    if abs(1-sum(pdf_s+i)*(max(Fd)-min(Fd))/point)<error
        error = abs(1-sum(pdf_s+i)*(max(Fd)-min(Fd))/point);
        Bias = i;
    end
end

subplot(2,2,1);
yyaxis left
plot(benchmark(2:end), pdf_s+Bias); hold on
ylim([min(pdf_s+Bias), max(pdf_s+Bias)]);

yyaxis right
plot(benchmark, cdf_s); hold off

yyaxis right
ylim([0, 1]);

xticks(round(benchmark(1):(benchmark(end)-benchmark(1))/10:benchmark(end)))
grid on
xlabel("Doppler Shift (Hz)");
legend({"PDF", "CDF"})
title("Simulation Result (a)")

gamma = (-1:0.000001:1);
mod_gamma = Fm*(-1:0.001:1);
pdf_t = (1/pi)./sqrt(1-(mod_gamma./Fm).^2);
cdf_t = 1-(acos(mod_gamma./Fm)/pi);

subplot(2,2,3);
yyaxis left
plot(mod_gamma, pdf_t); hold on

yyaxis right
ylim([0, 1]);
plot(mod_gamma, cdf_t); hold off

yyaxis left
ylim([0, 2]);

yyaxis right
ylim([0, 1]);

xticks(round(mod_gamma(1):(mod_gamma(end)-mod_gamma(1))/10:mod_gamma(end)))
grid on
xlabel("Doppler Shift (Hz)");
legend({"PDF", "CDF"})
title("Theoretical Result (a)") 

% ===================================================================

V = 90;         % km/hr
C = 3*10^8;     % m/s 
Fc = 26*10^9;    % 1/s
Fm = ((V*(1000/3600))/C)*Fc;
sample = 10^4;
point = 10^3;

r = unifrnd(-pi, pi, [1, sample]);
Fd = cos(r).*Fm;
benchmark = min(Fd):(max(Fd)-min(Fd))/point:max(Fd);
cdf_s = zeros(1, length(benchmark));

for i=1:length(cdf_s)
    if mod(i, 10)==0
        i
    end
    Cumulative_number = 0;
    for j=1:length(Fd)
        if Fd(j)>benchmark(i)
            Cumulative_number = Cumulative_number + 1;
        end
    cdf_s(i) = 1-Cumulative_number/length(r);
    end
end

pdf_s = smooth(diff(cdf_s));

error = 10;
for i=0:0.0005:0.1
    if abs(1-sum(pdf_s+i)*(max(Fd)-min(Fd))/point)<error
        error = abs(1-sum(pdf_s+i)*(max(Fd)-min(Fd))/point);
        Bias = i;
    end
end

subplot(2,2,2);
yyaxis left
plot(0.01*benchmark(2:end), pdf_s+Bias); hold on
ylim([min(pdf_s+Bias), max(pdf_s+Bias)]);

yyaxis right
plot(0.01*benchmark, cdf_s); hold off

yyaxis right
ylim([0, 1]);

xticks(round(0.01*(benchmark(1):(benchmark(end)-benchmark(1))/10:benchmark(end))))
grid on
xlabel("Doppler Shift (100Hz)");
legend({"PDF", "CDF"})
title("Simulation Result (b)")

gamma = (-1:0.000001:1);
mod_gamma = Fm*(-1:0.001:1);
pdf_t = (1/pi)./sqrt(1-(mod_gamma./Fm).^2);
cdf_t = 1-(acos(mod_gamma./Fm)/pi);

subplot(2,2,4);
yyaxis left
plot(0.01*mod_gamma, pdf_t); hold on

yyaxis right
ylim([0, 1]);
plot(0.01*mod_gamma, cdf_t); hold off

yyaxis left
ylim([0, 2]);

yyaxis right
ylim([0, 1]);

xticks(round(0.01*(mod_gamma(1):(mod_gamma(end)-mod_gamma(1))/10:mod_gamma(end))))
grid on
xlabel("Doppler Shift (100Hz)");
legend({"PDF", "CDF"})
title("Theoretical Result (b)") 

print("-djpeg", "-r600", "d.jpg");
