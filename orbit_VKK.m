function [orbit1,orbit2,orbit3,orbit4,orbit5,orbit6] = orbit_VKK(sat,N,long1,long2)
%ORBIT_VKK Summary of this function goes here
%   Detailed explanation goes here


switch sat
    case 'QZSS'
        name = 'QZSS.txt';
    case 'QZSS1'
        name = 'QZSSmax.txt';
    case 'QZSS2'
        name = 'QZSSmin.txt';
    case 'Tundra'
        name = 'Tundra.txt';
    case 'Tundra1'
        name = 'Tundramax.txt';
    case 'Tundra2'
        name = 'Tundramin.txt';
end

%name = strcat(sat,'.txt');
orbit = load(name);

%N = 3;                                             % ���������� �� �� ����� ������
orbit_period = 86160;                               % ������ � �������� ��� ����������� ������ �� ��
sat_time_step = orbit_period/N/3600;                % ��������� ��������� �������� � �����

if strncmp(sat,'QZSS',4)
    sat_time_shift = 1.2;                           % ����� ������� ��� ��������, ����� ������ �� ��� � ������ ����� � 12 �����
    sat_time_shift2 = N/2+sat_time_shift;           % ����� ������� ��� ��������, ����� ��������� �� ������ � ������� ������� ����� � 12 �����
    sat_long0 = 92;                                 % ������� ����������� ���� � sp3 �������
elseif strncmp(sat,'Tundra',6)
    sat_time_shift = 3.2;                           % ����� ������� ��� ��������, ����� ������ �� ��� � ������ ����� � 12 �����
    sat_time_shift2 = N/2+sat_time_shift;           % ����� ������� ��� ��������, ����� ��������� �� ������ � ������� ������� ����� � 12 �����
    sat_long0 = 63;                                 % ������� ����������� ���� � sp3 �������
else
    sat_time_shift = 0;
    sat_time_shift2 = 0;
    sat_long0 = 0;
end



orbit1 = sp3togeodetic (orbit,sat_time_shift,long1-sat_long0);                      % 60 �������� �1
orbit2 = sp3togeodetic (orbit,sat_time_shift+sat_time_step,long1-sat_long0);        % 60 �������� �2
orbit3 = sp3togeodetic (orbit,sat_time_shift+2*sat_time_step,long1-sat_long0);      % 60 �������� �3
orbit4 = sp3togeodetic (orbit,sat_time_shift2,long2-sat_long0);                     % 120 �������� �1
orbit5 = sp3togeodetic (orbit,sat_time_shift2+sat_time_step,long2-sat_long0);       % 120 �������� �2
orbit6 = sp3togeodetic (orbit,sat_time_shift2+2*sat_time_step,long2-sat_long0);     % 120 �������� �3

time = 0:150:12*3600;
orbit1 = [orbit1,time'];

end

