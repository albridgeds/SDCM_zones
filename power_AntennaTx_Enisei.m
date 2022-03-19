% ����������� �������� ���������� ������� ���� ��� � ����������� �� �����

function Gsat = power_AntennaTx_Enisei(Teta0,signal)

% ���� �� ��� ������� (� ��������)
TetaAnt = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15];

% ����������� �������� ���������� ������� �� ������

% switch signal
%     case 'L1SBAS'
%         GAnt = [18.7,18.8,19.0,19.3,19.5,19.8,19.9,19.7,19.2,18.5,17.5,16.0,14.4,12.2,9.9,7.3];
%     case 'L1SDCM'
%         GAnt = [18.7,18.8,19.0,19.3,19.5,19.8,19.9,19.7,19.2,18.5,17.5,16.0,14.4,12.2,9.9,7.3];
%     case 'L5SBAS'
%         GAnt = [16.7,16.8,16.9,17.0,17.2,17.5,17.6,17.7,17.7,17.6,17.4,17.0,16.5,15.8,14.9,13.9];
%     case 'L3SDCM'
%         GAnt = [16.7,16.8,16.9,17.0,17.2,17.5,17.6,17.7,17.7,17.6,17.4,17.0,16.5,15.8,14.9,13.9];
% end
        

if (strcmp(signal,'L1SBAS') || strcmp(signal,'L1SDCM'))
    GAnt = [18.7,18.8,19.0,19.3,19.5,19.8,19.9,19.7,19.2,18.5,17.5,16.0,14.4,12.2,9.9,7.3];
    
elseif (strcmp(signal,'L5SBAS') || strcmp(signal,'L3SDCM'))
    GAnt = [16.7,16.8,16.9,17.0,17.2,17.5,17.6,17.7,17.7,17.6,17.4,17.0,16.5,15.8,14.9,13.9];
     
end


Lafu = 2;
GAnt = GAnt - Lafu;

% ������������ 
Gsat = interp1(TetaAnt,GAnt,Teta0,'pchip');
