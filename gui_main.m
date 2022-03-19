clc
clear

disp('1123')

transponder = dbTransponder('L1SBAS');       % ������ (L1SBAS (���-5�,5�,5�) ��� L1SDCM/L5KFD/L3KFD/L1KFD (����� ��) ��� L3Sigal (���� ����������, ���������� ��������� � ������) ��� L1GLO/L2GLO/L3GLO)
user = dbUser('SARPs',transponder.signal);                       % ������������ (SARPs/Earth/�� �� ������������ ������)
%user = dbUser('Resurs',transponder.signal);                       % ������ (������ ������ 720 ��)


% ������������ �����
time = 0;
%time = 0:1/60:25;      % ��� �������
%time = 0:6;      	% ���� ������


% ����� ��
%[file,path] = uigetfile('*.txt','Select satellite file','sat_geo.txt');
%filepath = sprintf('%s\\%s',path,file);
filepath = 'sat_geo.dat';
sat_file = fopen(filepath,'r');
%C = textscan(sat_file,'%s %f %f %f');
C = textscan(sat_file,'%s %f');
fclose(sat_file);
% ����� ����
[indx,tf] = listdlg('PromptString','�������� ��','ListString',C{1},'CancelString','Exit');
if tf == 0
    return
end
ussinum = indx;

disp(ussinum)
disp(C{1}(ussinum))





% ����� �������


% ����� ������� �������










%satelite = create_sat_array('�������1','�������2','�������3');
%satelite = create_sat_array('5V');                                     
satelite = create_sat_array('5B','5V','5A', '80');                                     % ������������ �� "���-5�" � "���-5�"
%satelite = create_sat_array('�������-1','�������-2','�������-3'); 
%satelite = create_sat_array('5M1','5M2','5M3');     
%satelite = create_sat_array('80','140','95');
%satelite = create_sat_array('70','80','140','150');                        % �� ��� � ����������� ���������� ������������ ���������
%satelite = create_sat_array('��8','AM44','AM7','AM6','AM22','AM3','AM5');  % �� "��������-��"
%satelite = create_sat_array('QZSSmax-6','Tundra');                         % �� ���
%satelite = create_sat_array('RNISS-1','RNISS-2','RNISS-3','RNISS-4','RNISS-5','RNISS-6');
%satelite = create_sat_array('KFD-VKK-1','KFD-VKK-2','KFD-VKK-3');                         % �� ���
%satelite = create_sat_array('GLONASS',1:24);
%satelite = create_sat_array('Efir');

%satelite = create_sat_array('QZSS-1','QZSS-2','QZSS-3','QZSS-4','QZSS-5','QZSS-6');
%satelite = create_sat_array('QZSS-1','QZSS-2','QZSS-3');
%satelite = create_sat_array('QZSS-1');
%transponder.angle2north = 0;

%user = create_sat_array('Resurs');
%user = orbit_set(time,user);

sat_color = create_str_array('blue','blue','blue','green','green');
user_color = create_str_array('red');


% ����������� � �������� ������ �� TLE-������ ��� ������������ ��������� ������
%earth_sphere_3d(satelite);
%orbit_readtle('TLE.txt',38977);      % ������ ������������ ��������� ������ �� TLE-�����



%%------------------------------------------------------------------
% �������� ������ �� �����

% ����� �� ����� ��� �������������� ��� ��������� �� �� ����
%plotm_elevation(time,satelite,user,sat_color,[0,5],'newmap','plotfile');       

% ����� �� ����� ����� ��������� ��
%plotm_orbit(time,satelite,sat_color,'newmap','plotfile');

% ����� �� ����� ��������� �������� ��������� ��
%plotm_multi(time,satelite,user,5,sat_color);

% ����� �� ����� ����������� �������� ��
%plotm_availability(satelite,user,1);

% ������ ���������� �� ����� ������-�����
%plotm_power(time,satelite,transponder,user,1);

% ������ ���������� �� ����� ������-����� (����� ���� � ���� �������)
%plotm_power_line(time,satelite,transponder,user,1);

% ����� �� ����� ����� ���������� �� ��
%plotm_elevation_zone(time,satelite,user)

% ����� �� ����� ���� ������ ������ ������� 
%city = create_city_array('������','����������','���������');
%city = create_city_array('������');
%plotm_nles_zone(city,1100,5)

% ����� �� ����� ����� �� ��� ������� ��
%plotm_satangles(time,satelite,user,sat_color,'newmap','plotfile');


% ����� �� ����� ��� �������������� ��� ��������� �� �� ����
%gnss = create_sat_array('KFD-VKK-1','KFD-VKK-2','KFD-VKK-3');
%gnss = create_sat_array('GLO');
%plotm_gnssvisibility(time,satelite,gnss,user,sat_color,'newmap','plotfile');

% ����� �� ����� ����� ��������� ��
%plotm_satzones(time,satelite,sat_color,'newmap','plotfile');
%plotm_satzones(time,satelite,user);

%%------------------------------------------------------------------
% �������� ������ �� ������

% ���� ���������� �� � ����������� �� ������� �����������
%plot_ElofLong(0,satelite,user)

% �������� ������� � ����������� �� ���� ���������� ��
%plot_PowerofEl(time,satelite,transponder,user)

% �������� ������� � ����������� �� ������ �����������
%plot_PowerofLat(time,satelite,transponder,user)


%%------------------------------------------------------------------
% ��������, ���� �� ��������

% ����� ��������� �������, ���� ����� � ���������� ��� �����
%plot_time_aer(orbit_VKK1,point);

% ������ ������ � ��������� ������ �� ������� ��
%plot_time_h(orbit_VKK1);

% ����������� ���� �� ��� �� �� ����� �� �������
%plot_time_phi(orbit_VKK1,'������','��������','����������');

% ������ ����������� (������� �������, ����� ���� ����� �� �� ������ ����)
%calc_availability(time,satelite,user);

