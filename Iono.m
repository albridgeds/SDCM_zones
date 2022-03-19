clc
clf
clear

satnum = [1:13,15:25];
satnum1 = [7:9,15:19];
satnum2 = [1,2,5,6,13,22,24,25];
satnum3 = [3,4,10:12,20,21,23];

% ������ ���� ������������ �������������
satelite = create_sat_array('5V');
user.h = 0;
plotm_elevation(0,satelite,user,'g',5,'newmap');

% ������ ������� - ���� �� ������ �����, ��������� �� ������ TLE
%time = 0:60*10:3600*24;         % ��� GPS - ����� � ����� 10 �����
time = 0:60*60:3600*24*7;         % ��� ������� - ������ � ����� 1 ���

% ���������� ����������� ����
%satelite = create_sat_system(time,'GPS',1:30);
satelite = create_sat_system(time,'GLO',satnum);
%plotm_orbit(-1,satelite,'b')


%city = create_city_array('�����������','�������������','�������','������������','�����','����������','�����','�����','����-���������','��������');         % ��� ���-5A
%city = create_city_array('������','��������','�����������','�����������','�������','������');                                                               % ��� ���-5�
city = create_city_array('������','������','�����������','��������','�����-����','���������','������','��������','�������','�������','�����','������������','�����-��������','������������');       % ��� ���-5�
for i = 1:length(city)
    plotm(city(i).lat,city(i).long,'or')
end

% ������ ����������� ����� ��� ��������� ��� (��� ������ ��� 0,4-8 � 9)
[ionogrid_lat,ionogrid_long] = create_ionogrid([0,4:9]);      % [0,4:9]
ionogrid = zeros(1,length(ionogrid_lat));
%plotm(ionogrid_lat,ionogrid_long,'.b')


%return


% ���������� �� ������� ��� ������� �������
for t = 1:length(time)
    
    % ������� ������ ����������� ����� ��� �������� ������� �������
    %tmp_ionogrid = zeros(length(ionogrid_lat),length(ionogrid_long));
    tmp_ionogrid = zeros(1,length(ionogrid_lat));
    
    % ���������� ��� ����� �� �����������
    for c = 1:length(city)

        lat_r = city(c).lat;
        long_r = city(c).long;
    
        % ���������� ��� ��������
        for s=1:length(satelite)

            % ���������� ����� ������� ��� ������� �������� �� ������� ������ �������
            [lat_ipp,long_ipp] = ipp_calc(lat_r,long_r,satelite(s).orbit(t,:));
            %plotm(lat_ipp,long_ipp,'xr')

            % ���� ��� ����� �������, ����������
            if lat_ipp >= 1000.0
                continue
            end

            % ��������� ����� ����� �������� �������
            delta_lat = ionogrid_lat-lat_ipp + (ionogrid_lat<=lat_ipp)*1000;	% ������� ������ � �������� ��� ����� ����� �������
            [lat,idlat] = min(delta_lat);                                       % ������ ����� ������� ����� ����� �� ������ �������� ������� (������ �����)
            idlat = find(ionogrid_lat==ionogrid_lat(idlat));                    % ������ ���� ����� ������� ����� ����� �� ������ �������� �������
            
            % ��������� ����� ����� � ������-������� �� �������
            delta_long = ionogrid_long(idlat)-long_ipp + (ionogrid_long(idlat)<=long_ipp)*1000; 	% ������� ������� � �������� ��� ����� �������� �������
            [~,idlong] = min(delta_long);                                                           % ������ ����� ������� ����� ����� �� ������� ��������� ������� (�� ����� ��������� � ������)
            id1 = idlat(idlong);                                                                    % ������ ��������� ����� � ������-������� �� ������� � �������� �������
            %plotm(ionogrid_lat(id1),ionogrid_long(id1),'.g')
            tmp_ionogrid(id1) = tmp_ionogrid(id1)+1;
            
            % ��������� ����� ����� � ������-������ �� �������
            delta_long = long_ipp-ionogrid_long(idlat) + (ionogrid_long(idlat)>=long_ipp)*1000; 	% ������� ������� � �������� ��� ����� ��������� �������
            [~,idlong] = min(delta_long);
            id2 = idlat(idlong);
            %plotm(ionogrid_lat(id2),ionogrid_long(id2),'.c')
            tmp_ionogrid(id2) = tmp_ionogrid(id2)+1;            
            
            % ��������� ����� ����� ����� �������
            delta_lat = lat_ipp-ionogrid_lat + (ionogrid_lat>=lat_ipp)*1000;    % ������� ������ � �������� ��� ����� �������� �������
            [lat1,idlat] = min(delta_lat);                                      % ������ ����� ������� ����� ����� �� ������ ����� ������� (������ �����)
            idlat = find(ionogrid_lat==ionogrid_lat(idlat));                    % ������ ���� ����� ������� ����� ����� �� ������ ����� �������

            % ��������� ����� ����� � ���-������� �� �������
            delta_long = ionogrid_long(idlat)-long_ipp + (ionogrid_long(idlat)<=long_ipp)*1000; 	% ������� ������� � �������� ��� ����� �������� �������
            [~,idlong] = min(delta_long);
            id3 = idlat(idlong);
            %plotm(ionogrid_lat(id3),ionogrid_long(id3),'.r')
            tmp_ionogrid(id3) = tmp_ionogrid(id3)+1;
            
            % ��������� ����� ����� � ���-������ �� �������
            delta_long = long_ipp-ionogrid_long(idlat) + (ionogrid_long(idlat)>=long_ipp)*1000; 	% ������� ������� � �������� ��� ����� ��������� �������
            [~,idlong] = min(delta_long);
            id4 = idlat(idlong);
            %plotm(ionogrid_lat(id4),ionogrid_long(id4),'.m')
            tmp_ionogrid(id4) = tmp_ionogrid(id4)+1;

        end
    end
    
    % ���� ����� ����������� ����� ���� ������������� ���� ��� ������ ������� � ������� ������ �������, ������������ ��
    ionogrid = ionogrid + (tmp_ionogrid>0);     
end



% ���������� � ������ ����������� ������������� ����� ����������� �����
ionogrid = ionogrid/length(time);

amount0 = 0;
amount10 = 0;
amount20 = 0;
amount30 = 0;
amount40 = 0;
amount50 = 0;

for i=1:length(ionogrid_lat)
    iono = ionogrid(i);
    if iono>0
        if iono>0.5
            color = '.m';
            amount50 = amount50+1;
        elseif iono>0.4
            color = '.r';
            amount40 = amount40+1;
        elseif iono>0.3
            color = '.y';
            amount30 = amount30+1;
        elseif iono>0.2
            color = '.g';
            amount20 = amount20+1;
        elseif iono>0.1
            color = '.c';
            amount10 = amount10+1;
        elseif iono>0
            color = '.b';
            amount0 = amount0+1;
        end
        plotm(ionogrid_lat(i),ionogrid_long(i),color)
    end
end

amount40 = amount40 + amount50;
amount30 = amount30 + amount40;
amount20 = amount20 + amount30;
amount10 = amount10 + amount20;
amount0 = amount0 + amount10;

fprintf('\n\n����� �����, ������������:')
fprintf('\n- ���� �� ���� ��� - %d',amount0)
fprintf('\n- �� ����� 10%% ������� - %d',amount10)
fprintf('\n- �� ����� 20%% ������� - %d',amount20)
fprintf('\n- �� ����� 30%% ������� - %d',amount30)
fprintf('\n- �� ����� 40%% ������� - %d',amount40)
fprintf('\n- �� ����� 50%% ������� - %d',amount50)

str = sprintf('>0%% - %d',amount0);
str = strcat(str,sprintf('\n>10%% - %d',amount10));
str = strcat(str,sprintf('\n>20%% - %d',amount20));
str = strcat(str,sprintf('\n>30%% - %d',amount30));
str = strcat(str,sprintf('\n>40%% - %d',amount40));
str = strcat(str,sprintf('\n>50%% - %d',amount50));

text(-1.75,-0.26,str,'EdgeColor','k','BackgroundColor','w');

