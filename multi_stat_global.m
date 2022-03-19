function [zone0,zone1,zone2,zone3] = multi_stat_global(lat,long,zone)


% ����� � ������� (��� �������� �������� ����������)
point_map = 0;


pi=3.1415926535;
Llong = 20004.274/180;                      % ����� ���� � 1 ������ �� ��������� (��)


size_lat = size(zone,1);
size_long = size(zone,2);


count0 = 0;
count1 = 0;
count2 = 0;
count3 = 0;


if (point_map) 
    worldmap = create_figure(44);
end


% �������� ���� ����� ����, ��� ������� �� ������� ������� �������� ������ �������������� �������� (��� ����� � ����� 1 ������)
for i=1:size_lat
    
    Llat = 111.3*cos(lat(i,1)*pi/180);      % ����� ���� � 1 ������ �� ��������� �� �������� ������ (��)
    S1 = Llong*Llat;                      % ������� ������� �� ������� ������
        
    for j = 1:size_long
        if (zone(i,j)==0)
            count0 = count0+S1;
            if (point_map) plotm(lat(i,j),long(i,j),'.r'); end
        elseif (zone(i,j)==1)
            count1 = count1+S1;
            if (point_map) plotm(lat(i,j),long(i,j),'.y'); end
        elseif (zone(i,j)==2)
            count2 = count2+S1;
            if (point_map) plotm(lat(i,j),long(i,j),'.g'); end
        elseif (zone(i,j)>=3)
            count3 = count3+S1;
            if (point_map) plotm(lat(i,j),long(i,j),'.b'); end
        end
    end
end

count_total = count0 + count1 + count2 + count3;    % ������� ������ �� ���� - 17,1 ��� ��2, ��� ���������� 17,6 ��� ��2 (�����: 510,1 � 511.7 ��� ��2 ��������������)


zone0 = count0/count_total*100;
zone1 = count1/count_total*100;
zone2 = count2/count_total*100;
zone3 = count3/count_total*100;

if (point_map)
	plot_map(worldmap);
	print(worldmap,'-dpng','pictures\\multi_points.png');
end


% ����� ���������� � ��������� ����
fprintf('\nGlobal visibility zones:\n');
fprintf('zone x0 = %.1f%%\n',zone0);
fprintf('zone x1 = %.1f%% (%.1f%%)\n',zone1,zone1+zone2+zone3);
fprintf('zone x2 = %.1f%% (%.1f%%)\n',zone2,zone2+zone3);
fprintf('zone x3 = %.1f%%\n',zone3);

end

