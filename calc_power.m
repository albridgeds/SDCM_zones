%function P = calc_power (El,r,Teta,channel,receiver)
function P = calc_power (El,r,Teta,channel,receiver)
% ������ �������� ������� ��� ����� � ��������� �����, �����������

signal = channel.signal;
Ltx = channel.Ltx;
Lafu = channel.Lafu;
Lextra = channel.Lextra;
Ptx = channel.Ptx;
antenna = channel.antenna;
%Teta_05 = channel.antenna;
Freq = channel.freq_down;
Liq = channel.Liq;

Grec = 0;

% �������� ������� � ���������� �������������� �� SARPs
% if strcmp(signal,'L1SBAS') %&& strcmp(channel2,'L1SBAS')
%     Grec = power_AntennaRx(El);
% end
if strcmp(receiver.name,'SARPs')
    Grec = power_AntennaRx(El);
end



if (El<receiver.el)
    P = receiver.Pmin-1; 
    return
end


C = 299792458;


% ����� �����
Lambda = C/Freq;

% �������� �� ����� � ������� ��������
%Psat = 10*log10(Ptx) - Ltx - Lafu;

% ������ � ���������
Latm = power_AtmLoss(El);

% ������ �� ���������������
tmp = Lambda/(4*pi*r);
Lrasp = -10*log10(tmp*tmp);

% ����������� �������� ������� ��������
if strcmp(antenna,'Luch-5')
    Gsat = power_AntennaTx(Teta,signal);
elseif strcmp(antenna,'Enisei')
    Gsat = power_AntennaTx_Enisei(Teta,signal);
elseif strcmp(antenna,'Luch-5M')
    Gsat = power_AntennaTx_Luch5M(Teta,signal);
% else
%     Gsat = power_AntennaSimulate(Teta,signal,Teta_05);    % ���� �� ����� ��������, ����� �������� ������ �� ������
end

% �������� ������� � ������������ �����
P = 10*log10(Ptx) - Ltx - Lafu - Lextra + Gsat - Lrasp - Latm + Grec - Liq;
%P = Psat + Gsat - Lrasp - 0.5 + Grec - Liq - Lorb;

