function channel = dbTransponder (name)


switch name
 
    case {'L1SBAS','L1SBAS-5A'}
        channel = TRANSPONDER();
        channel.signal = 'L1SBAS';
        channel.band = 20;
        channel.freq_up = 14415.42E6;
        channel.freq_down = 1575.42E6;
        channel.angle2north = 7;
        channel.angle2east = 0;        
        channel.Ptx = 57;
        channel.Ltx = 1.5;
        channel.antenna = 'Luch-5';
    
    case {'L1SBAS-5B'}
        channel = TRANSPONDER();
        channel.signal = 'L1SBAS';
        channel.band = 20;
        channel.freq_up = 14415.42E6;
        channel.freq_down = 1575.42E6;
        channel.angle2north = 7;
        channel.angle2east = 0;        
        channel.Ptx = 57;
        channel.Ltx = 1.5;
        channel.Liq = 0;
        channel.antenna = 'Luch-5';
    
    case {'L1SBAS-5V'}
        channel = TRANSPONDER();
        channel.signal = 'L1SBAS';
        channel.band = 4;
        channel.freq_up = 14775.42E6;
        channel.freq_down = 1575.42E6;
        channel.angle2north = 7;
        channel.angle2east = 0;        
        channel.Ptx = 57;
        channel.Ltx = 1.5;
        channel.antenna = 'Luch-5';

        
        
    case {'L1SDCM'}
        channel = TRANSPONDER();
        channel.signal = 'L1SBAS';
        channel.band = 4;
        channel.freq_up = 12825.42E6;
        channel.freq_down = 1575.42E6;
        channel.angle2north = 7;
        channel.Ptx = 60;
        channel.Ltx = 1.0;              % ������ ����� �� � ������������ � ������ �����������
        channel.Lafu = 0.7;             % ������ � ������ ��� (������� �� ������������ ���� � ���)
        channel.Liq = 0;
        channel.Lextra = 0.5;           % ��������������� ��� �������������� ������ � �������
        channel.antenna = 'Luch-5M';
        
    case {'L5KFD'}
        channel = TRANSPONDER();
        channel.signal = 'L5KFD';
        channel.band = 20;
        channel.freq_up = 12991.45E6;
        channel.freq_down = 1176.45E6;
        channel.angle2north = 7;
        channel.Ptx = 60;
        channel.Ltx = 1.0;              % ������ ����� �� � ������������ � ������ �����������
        channel.Lafu = 0.7;             % ������ � ������ ��� (������� �� ������������ ���� � ���)
        channel.Liq = 0;
        channel.Lextra = 0.5;           % ��������������� ��� �������������� ������ � �������
        channel.antenna = 'Luch-5M';

    case {'L3KFD'}
        channel = TRANSPONDER();
        channel.signal = 'L3Sigal';
        channel.band = 20;
        channel.freq_up = 12957.025E6;
        channel.freq_down = 1202.025E6;
        channel.angle2north = 7;
        channel.Ptx = 120;              % �������� �� ������ �����������, ��
        channel.Ltx = 1.0;              % ������ ����� �� � ������������ � ������ �����������
        channel.Lafu = 0.7;             % ������ � ������ ��� (������� �� ������������ ���� � ���)
        channel.Liq = 0;                % ������ �� ���� ������� �������� ������� ����� ����� ������������
        channel.Lextra = 0.5;           % ��������������� ��� �������������� ������ � �������
        channel.antenna = 'Luch-5M';
        
    case {'L1KFD'}
        channel = TRANSPONDER();
        channel.signal = 'L1KFD';
        channel.band = 20;
        channel.freq_up = 12957.025E6;
        channel.freq_down = 1600.995E6;
        channel.angle2north = 7;
        channel.Ptx = 60;
        channel.Ltx = 1.0;              % ������ ����� �� � ������������ � ������ �����������
        channel.Lafu = 0.7;             % ������ � ������ ��� (������� �� ������������ ���� � ���)
        channel.Liq = 0;
        channel.Lextra = 0.5;           % ��������������� ��� �������������� ������ � �������
        channel.antenna = 'Luch-5M';
        
    
    % ����������� ���� �������� � ����� ������� - �������������� ������ � ���
    case {'L1SDCM_SHARED'}
        channel = TRANSPONDER();
        channel.signal = 'L1SBAS';
        channel.band = 4;
        channel.freq_up = 12825.42E6;
        channel.freq_down = 1575.42E6;
        channel.angle2north = 7;
        channel.Ptx = 60;
        channel.Ltx = 1.0;              % ������ ����� �� � ������������ � ������ �����������
        channel.Lafu = 1.2;             % ������ � ������ ��� (������� �� ������������ ���� � ���)
        channel.Liq = 0;
        channel.Lextra = 0.5;           % ��������������� ��� �������������� ������ � �������
        channel.antenna = 'Luch-5M'; 
        
    case {'L5KFD_SHARED'}
        channel = TRANSPONDER();
        channel.signal = 'L5KFD';
        channel.band = 20;
        channel.freq_up = 12991.45E6;
        channel.freq_down = 1176.45E6;
        channel.angle2north = 7;
        channel.Ptx = 60;
        channel.Ltx = 1.0;              % ������ ����� �� � ������������ � ������ �����������
        channel.Lafu = 1.8;             % ������ � ������ ��� (������� �� ������������ ���� � ���)
        channel.Liq = 0;
        channel.Lextra = 0.5;           % ��������������� ��� �������������� ������ � �������
        channel.antenna = 'Luch-5M';
        
    case {'L3KFD_SHARED'}
        channel = TRANSPONDER();
        channel.signal = 'L3KFD';       
        channel.band = 20;
        channel.freq_up = 12957.025E6;
        channel.freq_down = 1202.025E6;
        channel.angle2north = 7;
        channel.Ptx = 120;
        channel.Ltx = 1.0;              % ������ ����� �� � ������������ � ������ �����������
        channel.Lafu = 1.8;             % ������ � ������ ��� (������� �� ������������ ���� � ���)
        channel.Liq = 0;
        channel.Lextra = 0.5;           % ��������������� ��� �������������� ������ � �������
        channel.antenna = 'Luch-5M';
        
    case {'L1KFD_SHARED'}
        channel = TRANSPONDER();
        channel.signal = 'L1KFD';
        channel.band = 20;
        channel.freq_up = 12957.025E6;
        channel.freq_down = 1600.995E6;
        channel.angle2north = 7;
        channel.Ptx = 120;
        channel.Ltx = 1.0;              % ������ ����� �� � ������������ � ������ �����������
        channel.Lafu = 1.2;             % ������ � ������ ��� (������� �� ������������ ���� � ���)
        channel.Liq = 0;
        channel.Lextra = 0.5;           % ��������������� ��� �������������� ������ � �������
        channel.antenna = 'Luch-5M';
        
end





















