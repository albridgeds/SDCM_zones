% ������ � ����� �� ����� ��������� �������� ���������
function plotm_availability (satelite,user,min_mult)

% time - ������ ������, ��� ������� ����� ���������� ������ (�� ����� ��� ���)
% satelite - �������� ���������
% min_mult - ����������� ��������� ��������, ��� ������� ��������� ����


% ����������� ���� ����������, �� �������� ������������ ����
min_el = user.el;


time = 0:0.2:23.8;

% �������� ����, ��� ������� ������� ������
[lat,long] = zone_earth();

% ���������� ��
size_sat = size(satelite,2);

zone2 = zeros(size(lat));

for time_=time

    zone_work = zeros(size(lat));
    for i=1:size_sat
        
        if strcmp(satelite(i).name,'none')   % ���� ��� ������, ���������� ���� ��
            continue
        end  
        
        orbit = satelite(i).orbit;
       
        if (size(orbit,1)>1)    % ���� ������ ������ � ���� ������� ����� �� ������� (�� ���)
            t = time_index(time_,orbit);
            orbit = orbit(t,:);
        end
        
        el = calc_elevation(lat,long,orbit,user.h);                % ������� ������ ���� ����� ��� �������� ��
        
        % �������� ��� ���, �� ����� �� �� �� ������� ������� ����
        if ~orbit_checkWorkzone(satelite(i),orbit)
            el = zeros(size(lat))-1000;         % ���� ����� ������ �������������, ����� �� ��������� ���� �� � ��������� ���� ��������
        end
        
        zone_work = zone_sum(zone_work,el,'>=',min_el);      % ��������� �������� � ����� ����� ������ ������������
    end
    
    zone_work = zone_work >= min_mult;                      % ���������� ������� "�����������/���������� ��������"
    zone2 = zone_sum(zone2,zone_work);                      % ���������� �� �������
    
end
    

%     % ������ ��������� �������� ���������� ��
%     [stat0,stat1,stat2,stat3] = multi_stat(lat,long,zone_work);
%     
%     % ����� ���������� � ��������� ����
%     fprintf('\nSDCM zones for Russia:\n');
%     fprintf('zone x0 = %.1f%%\n',stat0);
%     fprintf('zone x1 = %.1f%% (%.1f%%)\n',stat1,stat1+stat2+stat3);
%     fprintf('zone x2 = %.1f%% (%.1f%%)\n',stat2,stat2+stat3);
%     fprintf('zone x3 = %.1f%%\n',stat3);
%     stat2 = stat2+stat3;
%     stat1 = stat1+stat2;


zone2 = zone2/length(time);
avail_stat_russia(lat,long,zone_work,0.9);
avail_stat_global(lat,long,zone_work,0.9);



%����� ����������� � ������������ ������
worldmap = create_figure(45);
%color_multi(zone_work);         % ������� �� ������ ��������� ��������
colormap pink
contourfm(lat,long,zone2,0:0.1:1,'LineStyle','none');
contourcbar
%contourm(lat,long,zone2,[0.95 0.95],'LineColor','b');       % ����������� �� ������ 0.95
plot_map(worldmap);
plotm_orbit(0,satelite,'b'); 


% ���������� ����� � ����
filename = sprintf('pictures\\availability.png');
print(worldmap,'-dpng',filename);


    
        





