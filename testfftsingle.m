%分开显示图，方便观察
s = csvread('D:\research\competition\prediction\data\PJME_hourly1.csv',0,0,[0,0,1999,0]);
signal = s';
T = length(signal);
fs = 1/T;
%t = (1:T);
t = (1:T)/T;
x = abs(fft(signal));
y = fftshift(x);
%max = max(y);
%y(find(a==max(y)))=[];
ind = find(y == max(y));
y(ind) = 0;
% fs = 100;               % sampling frequency
% t = 0:(1/fs):(10-1/fs); % time vector
% S = cos(2*pi*15*t);
% n = length(S);
% X = fft(S);
% f = (0:n-1)*(fs/n);     %frequency range
% %power = abs(X).^2/n;    %power
% plot(f,abs(X))

fshift = (-T/2:T/2-1)*(fs/T); % zero-centered frequency range
%powershift = abs(Y).^2/n;     % zero-centered power
% plot(fshift,y)
%axis([-inf, inf, 0, 3000000]); % Y = fftshift(X);
%plot(t,x)

% some sample parameters for VMD
alpha = 2000;        % moderate bandwidth constraint
tau = 0;            % noise-tolerance (no strict fidelity enforcement)
K = 3;              % 4 modes
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

% subplot(size(u,1)+1,2,1);
figure(1);

plot((1:T),signal,'k');grid on;
figure(2);
title('VMD分解');
% subplot(size(u,1)+1,2,2);
plot(fshift,fftshift(abs(fft(signal)))','LineWidth',1.6);grid on;
%plot(t,abs(fft(signal)),'k');grid on;
%plot(fshift,fftshift(abs(fft(signal))),'k','LineWidth',3);grid on;

title('对应频谱');
%ylim([0,80]);%对Y轴设定显示范围 
for i = 2:size(u,1)+1
%         subplot(size(u,1)+1,2,i*2-1);
    figure(3+i-2);
    plot((1:T),u(i-1,:),'k');grid on;
%     subplot(size(u,1)+1,2,i*2);
 

for n = 2:size(u,1)+1
    figure(size(u,1)+1+n);
    plot(fshift,fftshift(abs(fft(u(n-1,:)))),'LineWidth',1.6);grid on;
%     plot(fshift,fftshift(fft(u(i-1,:))),'k','LineWidth',3);grid on;

end



end