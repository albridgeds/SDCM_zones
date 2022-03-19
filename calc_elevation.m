function [zone_e] = calc_elevation (lat,long,orbit,user_h)
% ������� ������ ���� �����
% ������ ������ ��� ������ �� ������� zone_geometry


satlat = orbit(:,1);
satlong = orbit(:,2);
sath = orbit(:,3);

% ������ �������, ���������� � ���������� ��� ������ ����� ����
%h = 0;
spheroid = referenceEllipsoid('WGS 84');
[~,zone_e,~] = geodetic2aer(satlat,satlong,sath,lat,long,user_h,spheroid);




