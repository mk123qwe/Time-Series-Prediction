%--------------- Preparation
%clear all;
close all;
clc;
% signal
% s = [1,2,3,4,5,6,7,8,9,10,9,8,7,6,5,4,3,2,1,3,3,5,3,5,6,1,2,3,4,5,6,7,8,9,8,7,6,5,4,3,2,1];
s = csvread('D:\research\competition\prediction\data\PJME_hourly1.csv',0,0,[0,0,1999,0]);
signal = s';
% signal = s;

% Time Domain 0 to T
T = length(signal);
fs = 1/T;
%t = (1:T);
t = (1:T)/T;
fshift = (-T/2:T/2-1)*(fs/T); % zero-centered frequency range
%fshift = (-T/2:T/2-1)*(fs/T); % zero-centered frequency range
%freqs = 2*pi*(t-0.5-1/T)/(fs);
% center frequencies of components
% f_1 = 2;
% f_2 = 24;
% f_3 = 288;
% % modes
% v_1 = (cos(2*pi*f_1*t));
% v_2 = 1/4*(cos(2*pi*f_2*t));
% v_3 = 1/16*(cos(2*pi*f_3*t));
% % for visualization purposes
% wsub{1} = 2*pi*f_1;
% wsub{2} = 2*pi*f_2;
% wsub{3} = 2*pi*f_3;
% % composite signal, including noise
% f = v_1 + v_2 + v_3 + 0.1*randn(size(v_1));
% some sample parameters for VMD
alpha = 2000;        % moderate bandwidth constraint
tau = 0;            % noise-tolerance (no strict fidelity enforcement)
K = 5;              % 4 modes
DC = 0;             % no DC part imposed
init = 1;           % initialize omegas uniformly
tol = 1e-7;

%--------------- Run actual VMD code

[u, u_hat, omega] = VMD(s, alpha, tau, K, DC, init, tol);
ureal = real(u_hat);
ui = imag(u_hat);
%save D:\research\competition\prediction\code\a.txt -ascii u
%save D:\research\competition\prediction\code\b.txt -ascii ureal
%save D:\research\competition\prediction\code\c.txt -ascii ui

subplot(size(u,1)+1,2,1);
plot((1:T),signal,'k');grid on;
title('VMD分解');
subplot(size(u,1)+1,2,2);
plot(fshift,fftshift(abs(fft(signal))),'k','LineWidth',3);grid on;
%plot(t,abs(fft(signal)),'k');grid on;

title('对应频谱');
%ylim([0,80]);%对Y轴设定显示范围 
for i = 2:size(u,1)+1
        subplot(size(u,1)+1,2,i*2-1);
    plot((1:T),u(i-1,:),'k');grid on;
    subplot(size(u,1)+1,2,i*2);
    plot(fshift,fftshift(abs(fft(u(i-1,:)))),'k','LineWidth',3);grid on;
end
 %{ 
%---------------run EMD code
imf = emd(signal);
figure;
subplot(size(imf,1)+1,2,1);
plot((1:T),signal,'k');grid on;
title('EMD分解');
subplot(size(imf,1)+1,2,2);
plot(fshift,fftshift(abs(fft(signal))),'k','LineWidth',3);grid on;
title('对应频谱');
for i = 2:size(imf,1)+1
    subplot(size(imf,1)+1,2,i*2-1);
    plot((1:T),imf(i-1,:),'k');grid on;
    subplot(size(imf,1)+1,2,i*2);
    plot(fshift,fftshift(abs(fft(imf(i-1,:)))),'k','LineWidth',3);grid on;
end
%}