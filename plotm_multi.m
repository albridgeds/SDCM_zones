% ������ � ����� �� ����� ��������� �������� ���������
function plotm_multi (time,satelite,user,min_el,satcolor)

% time - ������ ������, ��� ������� ����� ���������� ������ (�� ����� ��� ���)
% satelite - �������� ���������
% min_el - ���� ����������, �� �������� ������������ ����




% �������� ����, ��� ������� ������� ������
[lat,long] = zone_earth();

% ���������� ��
size_sat = size(satelite,2);



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
        
        zone_work = zone_sum(zone_work,el,'>=',min_el);     % ����������� ��� ���������
    end
    
    


    % ����� � ������������ ������
    worldmap = create_figure(45);
    color_multi(zone_work);         % ������� �� ������ ��������� ��������
    
    k = max(zone_work(:));
    contourfm(lat,long,zone_work,k+1,'LineStyle','none');
    
    plotm_elevation(time_,satelite,user,satcolor,min_el);      % ��������: ���� ����� ��� �������������� �����, �� �� ����� ����� ���������� �������, ��� ��� ���� ��� ������ 
    plot_map(worldmap);
    
    
    % ������ ��������� �������� ���������� ��
    [stat0,stat1,stat2,stat3] = multi_stat(lat,long,zone_work);    
	s_title = sprintf('SDCM zones for Russia: 1x - %.1f%%, 2x - %.1f%%, 3x - %.1f%%',stat1+stat2+stat3,stat2+stat3,stat3);
    %s_title = sprintf('%s\n111',s_title);
    xlabel(s_title)
 
    
    % ���������� ����� � ����
    filename = sprintf('pictures\\multi_t%02g.png',time_);
    print(worldmap,'-dpng',filename);
    
    % ������ ��������� ����������� ��������
    multi_stat_global(lat,long,zone_work);
    
    
end




end

