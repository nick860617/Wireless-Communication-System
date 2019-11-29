%% Initialization
clear all;
close all;
clc;
%%  HW1-1
Channel_number = [1:20 200:220];
Blocking_rate = [0.01 0.03 0.05 0.1];
rho_table = zeros(length(Channel_number), length(Blocking_rate));

for i=1:length(Channel_number)
    for j=1:length(Blocking_rate)
        rho_table(i, j) = find_rho(Blocking_rate(j), Channel_number(i), 1);
    end
end

%% HW1-2-1

Channel_number_ = [1 3 5 15];
Blocking_rate_ = [0:0.05:0.65];
rho_table_ = zeros(length(Channel_number_), length(Blocking_rate_));

for i=1:length(Channel_number_)
    for j=1:length(Blocking_rate_)
        disp([i j]);
        rho_table_(i, j) = find_rho(Blocking_rate_(j), Channel_number_(i), 1);
    end
end

figure
for i=1:length(Channel_number_)
    plot(rho_table_(i, 1:end)/Channel_number_(i), Blocking_rate_, '-*'); 
    if i == 1
       hold on
    end
end

legend('m: 1 ', 'm: 3 ', 'm: 5 ', 'm: 20 ');
xlabel('rho / Channel') 
ylabel('Blocking rate(B)') 
grid on
%% HW1-2-2
for i=1:length(Channel_number_)
    plot(Blocking_rate_, rho_table_(i, 1:end).*(1-Blocking_rate_), '-*'); 
    if i == 1
       hold on
    end
end
hold off
legend('m: 1 ', 'm: 3 ', 'm: 5 ', 'm: 15 ');
xlabel('Blocking rate(B)') 
ylabel('Modified rho') 
grid on

%% HW1-3
operator = [1 2 3];
Blocking_rate = [0.01 0.03 0.05 0.1];
rho_table = zeros(length(operator), length(Blocking_rate));

for i=1:length(operator)
    for j=1:length(Blocking_rate)
        disp([i j]);
        rho_table(i, j) = find_rho(Blocking_rate(j), 120, operator(i));
    end
end

%% HW1-4

opers = [1 2 4 8 16 32 64 128];
rate = [0.01 0.03 0.05 0.1];
channs = 128;
data_ = zeros(length(rate),length(opers));
for i=1:length(opers)
    for j=1:length(rate)
        data_(i, j) = find_rho(rate(j), channs, opers(i))*opers(i);
    end
end

for i=1:length(rate)
    plot(log2(opers), data_(1:end, i), '-*');
    if i==1
        hold on
    end
end
hold off
legend('B: 0.01 ', 'B: 0.03 ', 'B: 0.05 ', 'B: 0.10 ');
xlabel('log2(operator)') 
ylabel('rho') 
grid on
