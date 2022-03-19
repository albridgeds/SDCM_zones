function color = dbColor (name)
%DATABASECITY Summary of this function goes here
%   Detailed explanation goes here


if strcmp(name,'r') || strcmp(name,'red')
    color = [1.0 0.0 0.0];
elseif strcmp(name,'g') || strcmp(name,'green')
    color = [0.0 1.0 0.0];
elseif strcmp(name,'b') || strcmp(name,'blue')
    color = [0.0 0.0 1.0];
    
% elseif strcmp(cityname,'Khabarovsk') || strcmp(cityname,'���������')
%     lat = 48.48;
%     long = 135.07;
% elseif strcmp(cityname,'Krasnoyarsk') || strcmp(cityname,'����������')
%     lat = 56.02;
%     long = 92.87;
% elseif strcmp(cityname,'Irkutsk') || strcmp(cityname,'�������')
%     lat = 52.28;
%     long = 104.13;
% elseif strcmp(cityname,'Vladivostok') || strcmp(cityname,'�����������')
%     lat = 43+07/60;
%     long = 131+54/60;
% elseif strcmp(cityname,'Magadan') || strcmp(cityname,'�������')
%     lat = 59+34/60;
%     long = 150+48/60;
% elseif strcmp(cityname,'Petropavlovsk') || strcmp(cityname,'�������������')
%     lat = 53+01/60;
%     long = 158+39/60;
% elseif strcmp(cityname,'Baikonur') || strcmp(cityname,'��������')
%     lat = 45+57/60;
%     long = 63+18/60;
% elseif strcmp(cityname,'Vostochniy') || strcmp(cityname,'���������')
%     lat = 51+53/60;
%     long = 128+20/60;
% elseif strcmp(cityname,'Managua') || strcmp(cityname,'Nicaragua') || strcmp(cityname,'�������') || strcmp(cityname,'���������')
%     lat = 12+9/60;
%     long = -86+16/60;
 
elseif strcmp(name,'none') || strcmp(name,'grey')
    color = [0.5 0.5 0.5];
    
elseif strcmp(name,'w') || strcmp(name,'white')
    color = [0.5 0.5 0.5];
    
elseif strcmp(name,'none')                          % ��� ����� (������ �����)
    color = [1.0 1.0 1.0];


elseif strcmp(name,'var')                           % ������ �����
    color = 0;
else                                                % ����������� ����
    sprintf('Error: unknown color - %s',name)       % ��������� �� ������
    color = [0.5 0.5 0.5];                          % ����� ����

end

