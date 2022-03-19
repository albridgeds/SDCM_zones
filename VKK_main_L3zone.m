clc
clear


% ������ (L1SBAS (���-5�,5�,5�), L1SDCM/L5KFD/L3KFD/L1KFD (����� ��) ��� L3Sigal (���� ����������, ���������� ��������� � ������) ��� L1GLO/L2GLO/L3GLO)
transponder = dbTransponder('L3Sigal');       

% ����������� (SARPs - �� ������ ������, ������������ � SARPs / Earth - �� ������ ������� 0 �� / �� �� ������������ ������)
user = dbUser('Earth', transponder.signal);  


% ������������ �����
time = 0;

% ��������
satelite = create_sat_array('5M1','5M2','5M3');     

% �����
sat_color = create_str_array('blue');
user_color = create_str_array('red');

% ������ ���������� �� ����� ������-�����
plotm_power(time,satelite,transponder,user,1);

% �������� ������� � ����������� �� ���� ���������� ��
plot_PowerofEl(time,satelite,transponder,user)