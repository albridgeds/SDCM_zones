% ������ ���������� ���, ������������ ������� ������������, ����������� � ���� ������������ ��������-�������������
function plotm_gnssvisibility (time,satelite,gnss,varargin)


% ������� �������� �4 - ������������ (�� ��������� - ���������, ������ 0)
if nargin>=4
	user_h = varargin{1}.h;
else
    user_h = 0;
end


% ������� �������� �3 - ����� �������� (�� ��������� - �����)
if nargin>=5
	colorname = varargin{2};
else
    colorname = 'b';
end


% ������� ��������� �4 � �5 - �������� ������ ������� � ������ � ����
newmap = 0;
plotfile = 0;
for i=1:nargin-3
    if strcmp(varargin{i},'newmap')
        newmap = 1;
    elseif strcmp(varargin{i},'plotfile')
        plotfile = 1;
    end
end


min_el_sbas = 5;
min_el_gnss = 5;

colorname_sbas = 'b';
colorname_gnss = 'g';


% �������� ����, ��� ������� ������� ������
[lat,long] = zone_earth();

size_gnss = length(gnss);
size_time = length(time);


satnum = zeros(1,size_time);


% ������� ������������ � ��-��������������
satelite = satelite(1);
sbas_orbit = satelite.orbit;
if strcmp(satelite.name,'none')   % ���� ��� ������, ���������� ���� ��
    fprintf('plotm_gnssvisibility: invalid sbas satelite')
    return
end  

t1=0;
for time_=time
    
    t1=t1+1;
    
    if (size(sbas_orbit,1)>1)    % ���� ������ ������ � ���� ������� ����� �� ������� (�� ���)
        ts = time_index(time_,sbas_orbit);
        sbas_orbit = sbas_orbit(ts,:);
    end
    sbas_el = calc_elevation(lat,long,sbas_orbit,user_h);                   % ������� ������ ���� �����
    sbas_zone = sbas_el > min_el_sbas;                                      % ����� �� ��� ��������� ���� ��������� �� ���� ����� ������ 5 ��������
  	sbas_zone = sbas_zone.*(lat>-30);                                       % �������������� ����������� ���� �� ������
    
    % ���������� ��� �� ����
    for j=1:size_gnss
        
        % ������ 
        tg = time_index(time_,gnss(j).orbit);
        gnss_orbit = gnss(j).orbit(tg,:);
        gnss_el = calc_elevation(lat,long,gnss_orbit,user_h);               % ������� ������ ���� ����� ��� �� ����
        gnss_zone = zone_sum(sbas_zone,gnss_el,'>=',min_el_gnss);       	% ����������� ��� �� ��� � �� ����
        
        % ���, ��� ���� ������������, ����� 2
        if max(max(gnss_zone))>1
            satnum(t1) = satnum(t1)+1;
            gnss(j).cur_active = 1;
        else
            gnss(j).cur_active = -1;
        end

        
        % ����� ��� ������� ���������� �� ����
%         worldmap = create_figure(100+j);
%         color_multi(gnss_zone);         % ������� �� ������ ��������� ��������
%         k = max(gnss_zone(:));
%         contourfm(lat,long,gnss_zone,k+1,'LineStyle','none');
%         plot_map(worldmap);
%        
%         % ���� ������������ ��-�������������
%         %color = color_set(colorname,i);
%         contourm(lat,long,sbas_el,[min_el(1) min_el(1)],'LineColor',colorname_sbas,'LineWidth',2)
%         plotm_orbit(time_,satelite(1),colorname_sbas);
%             
%         % ����� �� ������ ������ �� ����
%         plotm_orbit(time_,gnss(j),'g');
%         contourm(lat,long,gnss_el,[min_el min_el],'LineColor',colorname_gnss,'LineWidth',2)
        
    end
    
    
    % ��������� �����
    if (newmap)
        worldmap = create_figure(46);
        %color = color_set(colorname_sbas,1);
        contourm(lat,long,sbas_el,[min_el_sbas min_el_sbas],'LineColor',colorname_sbas,'LineWidth',2)
        plotm_orbit(time_,satelite,colorname_sbas);
        plotm_orbit(time_,gnss,colorname_gnss);
        plot_map(worldmap); 
        
        % ���������� ����� � ����
      	if (plotfile)
            filename = sprintf('pictures\\gnss_visibility_t%02g.png',time_);
            print(worldmap,'-dpng',filename);
        end       
        
    end


   
end

satnum