function orbit = orbit_my(sat)
%ORBIT_VKK Summary of this function goes here
%   Detailed explanation goes here


name = strcat(sat,'.txt');

orbi
orbit = load(name);

if ()


% N = 3;
% orbit_period = 86160;                               % ������ � �������� ��� ����������� ������ �� ��
% sat_time_step = orbit_period/N/3600;                % ��������� ��������� �������� � �����
% 
% if strncmp(sat,'QZSS',4)
%     sat_time_shift = 1.2;                           % ����� ������� ��� ��������, ����� ������ �� ��� � ������ ����� � 12 �����
%     sat_time_shift2 = N/2+sat_time_shift;           % ����� ������� ��� ��������, ����� ��������� �� ������ � ������� ������� ����� � 12 �����
%     sat_long0 = 92;                                 % ������� ����������� ���� � sp3 �������
% elseif strncmp(sat,'Tundra',6)
%     sat_time_shift = 3.2;                           % ����� ������� ��� ��������, ����� ������ �� ��� � ������ ����� � 12 �����
%     sat_time_shift2 = N/2+sat_time_shift;           % ����� ������� ��� ��������, ����� ��������� �� ������ � ������� ������� ����� � 12 �����
%     sat_long0 = 63;                                 % ������� ����������� ���� � sp3 �������
% else
%     sat_time_shift = 0;
%     sat_time_shift2 = 0;
%     sat_long0 = 0;
% end

sat_time_shift = 0;
long1 = 0;
sat_long0 = 0;

orbit = sp3togeodetic (orbit,sat_time_shift,long1-sat_long0);


% switch num
%     case 1
%         orbit = sp3togeodetic (orbit,sat_time_shift,long1-sat_long0);                      % 60 �������� �1
%     case 2
%         orbit = sp3togeodetic (orbit,sat_time_shift+sat_time_step,long1-sat_long0);        % 60 �������� �2
%     case 3
%         orbit = sp3togeodetic (orbit,sat_time_shift+2*sat_time_step,long1-sat_long0);      % 60 �������� �3
%     case 4
%         orbit = sp3togeodetic (orbit,sat_time_shift2,long2-sat_long0);                     % 120 �������� �1
%     case 5
%         orbit = sp3togeodetic (orbit,sat_time_shift2+sat_time_step,long2-sat_long0);       % 120 �������� �2
%     case 6
%         orbit = sp3togeodetic (orbit,sat_time_shift2+2*sat_time_step,long2-sat_long0);     % 120 �������� �3
% end

