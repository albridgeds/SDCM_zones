function G = power_AntennaSimulate (teta,signal,Teta_05)
%ANTENNA Summary of this function goes here
%   Detailed explanation goes here


C = 299792458;
pi = 3.14159265359;


%Teta_05 = 22;               % ������� �������� ������ �� ��� ������� �� L1
%Teta_05 = Teta_05*pi/180;
teta = teta*pi/180;

f_L1 = 1575.42e6;
f_L1g = 1600.995e6;
f_L3 = 1202.025e6;
f_L5 = 1176.45e6;


lambda = C/f_L1;
Da = lambda/Teta_05*180/pi;        % ��������� ������ ������� ������ �� ������ �� ��� ������� �� L1
%Da = lambda/Teta_05;

switch signal
    case 'L3SDCM'
        lambda = C/f_L3;
        Teta_05 = lambda/Da*180/pi;
    case 'L5SBAS'
        lambda = C/f_L5;
        Teta_05 = lambda/Da*180/pi;
    case 'L1SDCM'
        lambda = C/f_L1g;
        Teta_05 = lambda/Da*180/pi;
end


Gmax = pi*pi*Da*Da/lambda/lambda;   % �� � ��������� �� ��� ������� ������� (����)

x = 220/Teta_05*sin(teta);
F = (1+cos(teta))/2*sin(x)/x;       % �� � �������� �� 0 �� 1

G = 10*log10(Gmax*F);                 % �� � ������ �� � ��������� �� (��)
%G = sin(x)/x;
%G = (1+cos(teta))/2;
%G = F;

%10*log10(Gmax)

end

