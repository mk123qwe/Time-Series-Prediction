%去掉频谱最大值，方便观察
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
plot(fshift,y)
%axis([-inf, inf, 0, 3000000]); % Y = fftshift(X);
%plot(t,x)

