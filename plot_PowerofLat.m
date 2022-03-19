function plot_PowerofLat (time,satelite,channel,receiver)
% ������ �������� ������� �� ��� ���� � ������������ ������� �������

% mode=0 - ��������� ����� ��� ������� ��
% mode=1 - ��������� ����� ��� ���� ��
% mode=2 - ��������� � ��������� �����


sat = satelite(1);

lat = -90:10:90;
size_lat = length(lat);

long = zeros(1,size_lat)+sat.long;


%size_long = length(long);

      
orbit = sat.orbit;
if (size(orbit,1)>1)    % ���� ������ ������ � ���� ������� ����� �� ������� (�� ���)
    t = time_index(time(1),orbit);      % ������ ������ ��� ������� ������� ������� 
    orbit = orbit(t,:);
end



% ���� �����, ���������� � 
[el,~,r,phi] = calc_geometry (lat,long,orbit,sat.angle2north,sat.angle2east,receiver.h);

% ������ �������� � ����
p = zeros(size(lat)) - receiver.Pmin;          % �������!!! ���� ��������� ���� ������, ������������ ��� ������� � �����������
if orbit_checkWorkzone(sat,orbit)       % ������ ���� �� � ������� ����
    for i=1:size_lat
        p(i) = calc_power(el(i),r(i),phi(i),channel,receiver);
    end
end

   

figure(47);
clf
hold on;
grid on;
xlim([-90 90]);
ylim([-165 -150]);
set(gca, 'xtick',-90:10:90)
set(gca, 'ytick',-165:1:150)
xlabel('Latitude, degree');
ylabel('Power, dBW');
plot(lat,p,'b','LineWidth',2)
plot(lat,-155.3,'--r','LineWidth',1)

        

    

    
    
    
    
%end



