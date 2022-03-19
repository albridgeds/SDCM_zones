function [zone0,zone1,zone2,zone3] = multi_stat(lat,long,zone)


% ����� � ������� (��� �������� �������� ����������)
point_map = 0;


pi=3.1415926535;

Llong = 20004.274/180;                      % ����� ���� � 1 ������ �� ��������� (��)


%size_lat = size(zone,1);
%size_long = size(zone,2);


russia_zone = load('russia_zone.dat');          % ������ ����� � ����� 1 ������ �� ������ � �������, ����������� ��� ���������� ��
long_rus = russia_zone(:,1);
lat_rus = russia_zone(:,2);
len = length(lat_rus);



count0 = 0;
count1 = 0;
count2 = 0;
count3 = 0;


if (point_map) 
    worldmap = create_figure(44);
end


% �������� ���� ����� ����, ��� ������� �� ������� ������� �������� ������ �������������� ��������
%for i=1:size_lat
%    for j = 1:size_long
    

% �������� ���� ����� � �������� ������ (��� �������, ��� ������ ������ � ����)
for i=1:len
        
%         f1 = find(lat_rus==lat(i,j));
%         if isempty(f1)
%             continue
%         end
%         f2 = find(long_rus==long(i,j));
%         if isempty(f2)
%             continue
%         end
%         f = intersect(f1,f2);
%         if isempty(f)
%             continue
%         end

        f1 = find(lat==lat_rus(i));         % ������� ����� ������� ����, ����������� � ������� ������ �� ���������� �� �� ������ 
        f2 = find(long==long_rus(i));       % ������� ����� ������� ����, ����������� � ������� ������ �� ���������� �� �� �������
        f = intersect(f1,f2);               % ������ ����� ������� ���� ��, ����������� � ������� ������ �� ���������� ��
        if isempty(f)
            continue
        end

        Llat = 111.3*cos(lat(i)*pi/180);      % ����� ���� � 1 ������ �� ��������� �� �������� ������ (��)
        S1 = Llong*Llat;                      % ������� ������� �� ������� ������ � �������
        
        if (zone(f)==0)
            count0 = count0+S1;
            if (point_map) plotm(lat(f),long(f),'.r'); end
        elseif (zone(f)==1)
            count1 = count1+S1;
            if (point_map) plotm(lat(f),long(f),'.y'); end
        elseif (zone(f)==2)
            count2 = count2+S1;
            if (point_map) plotm(lat(f),long(f),'.g'); end
        elseif (zone(f)>=3)
            count3 = count3+S1;
            if (point_map) plotm(lat(f),long(f),'.b'); end
        end
   % end
end

count_total = count0 + count1 + count2 + count3;    % ������� ������ �� ���� - 17,1 ��� ��2, ��� ���������� 17,6 ��� ��2


zone0 = count0/count_total*100;
zone1 = count1/count_total*100;
zone2 = count2/count_total*100;
zone3 = count3/count_total*100;

if (point_map)
	plot_map(worldmap);
	print(worldmap,'-dpng','pictures\\multi_points.png');
end

% ����� ���������� � ��������� ����
fprintf('\nVisibility zones for Russia:\n');
fprintf('zone x0 = %.1f%%\n',zone0);
fprintf('zone x1 = %.1f%% (%.1f%%)\n',zone1,zone1+zone2+zone3);
fprintf('zone x2 = %.1f%% (%.1f%%)\n',zone2,zone2+zone3);
fprintf('zone x3 = %.1f%%\n',zone3);


end

