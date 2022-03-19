function avail = avail_stat_russia(lat,long,zone,limit)


pi=3.1415926535;
Llong = 20004.274/180;                      % ����� ���� � 1 ������ �� ��������� (��)

russia_zone = load('russia_zone.dat');          % ������ ����� � ����� 1 ������ �� ������ � �������, ����������� ��� ���������� ��
long_rus = russia_zone(:,1);
lat_rus = russia_zone(:,2);
len = length(lat_rus);

count0 = 0;
count1 = 0;


% �������� ���� ����� � �������� ������ (��� �������, ��� ������ ������ � ����)
for i=1:len
    f1 = find(lat==lat_rus(i));         % ������� ����� ������� ����, ����������� � ������� ������ �� ���������� �� �� ������ 
    f2 = find(long==long_rus(i));       % ������� ����� ������� ����, ����������� � ������� ������ �� ���������� �� �� �������
    f = intersect(f1,f2);               % ������ ����� ������� ���� ��, ����������� � ������� ������ �� ���������� ��
    if isempty(f)
        continue
    end

    Llat = 111.3*cos(lat(i)*pi/180);      % ����� ���� � 1 ������ �� ��������� �� �������� ������ (��)
    S1 = Llong*Llat;                      % ������� ������� �� ������� ������ � �������

    if (zone(f)>=limit)
        count1 = count1+S1;
    else
        count0 = count0+S1;
    end
end

avail = count1/(count0+count1)*100;


% ����� ���������� � ��������� ����
fprintf('\nAvailability zone for Russia: %.1f%%\n',avail);


end

