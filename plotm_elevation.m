%function plotm_elevation (time,satelite,user,sat_color,min_el,newmap)
function plotm_elevation (time,satelite,varargin)


% ������� �������� �4 - ������������ (�� ��������� - ���������, ������ 0)
if nargin>=3
	user_h = varargin{1}.h;
else
    user_h = 0;
end


% ������� �������� �3 - ����� �������� (�� ��������� - �����)
if nargin>=4
	colorname = varargin{2};
else
    colorname = 'b';
end

% ������� �������� �4 - ����, �� �������� ������� ������ (�� ��������� - 5 ��������)
if nargin>=5
	min_el = varargin{3};
else
    min_el = 5;
end

% ������� ��������� �5 � �6 - �������� ������ ������� � ������ � ����
newmap = 0;
plotfile = 0;
for i=1:nargin-2
    if strcmp(varargin{i},'newmap')
        newmap = 1;
    elseif strcmp(varargin{i},'plotfile')
        plotfile = 1;
    end
end



% ������ ����� ����� � ����� ��� �������������� ��� ������������� ������� � ���������� ��
% �� ����� ������� ����� ������� ��������� ��������

% ������� ������ 1:
% plot_elevation2(0,satelite,5,'r')             % ��������� ��, ���� ������ �������, ���� ������, ���� ���� (�������� ������ ��� ���������� ������)

% ������� ������ 2:
% plot_elevation2(0,satelite,[5 10],'r')        % ��������� �������� ��� ������� ��

% ������� ������ 3:
% sat_color = create_str_array('green'); 
% plot_elevation2(0,satelite,5,sat_color)       % �������������� �����

% ������� ������ 4:
% sat_color = create_str_array('var'); 
% plot_elevation2(0,satelite,5,sat_color)       % ���� ���� ��� ������� ��

% ������� ������ 5:
% sat_color = create_str_array('g','b','b','red'); 
% plot_elevation2(0,satelite,5,sat_color)       % ������������ ���� ��� ������� ��

% ������� ������ 6:
% time = 0:6;
% plot_elevation2(time,satelite,5,sat_color)    % ��������� ������� ��� ������� ������� �������




% �������� ����, ��� ������� ������� ������
[lat,long] = zone_earth();

size_sat = length(satelite);


for time_=time
    
    if (newmap)
        worldmap = create_figure(46);
    end
    
    for i=1:size_sat
        %satName = satelite(i);
        %orbit = dbSat(satName);
        orbit = satelite(i).orbit;
        
    	if strcmp(satelite(i).name,'none')   % ���� ��� ������, ���������� ���� ��
            continue
        end  
        
        if (size(orbit,1)>1)    % ���� ������ ������ � ���� ������� ����� �� ������� (�� ���)
            t = time_index(time_,orbit);
            orbit = orbit(t,:);
        end
        
        el = calc_elevation(lat,long,orbit,user_h);                % ������� ������ ���� �����
 
        color = color_set(colorname,i);
       
        style = '-';
%         if (i==3)
%             
%             style = '--';
%         end
        
        % ������ ������ 
        contourm(lat,long,el,[min_el(1) min_el(1)],'LineColor',color,'LineWidth',2,'LineStyle',style)

        % ���� ������ ��������� �������� ���� ����������, ��������� ������� ������ ������ ������
        if (size(min_el,2)>1)
            contourm(lat,long,el,[min_el min_el],'LineColor',color,'LineWidth',1,'LineStyle',style);
        end
        
        % ����� �� ������ ������ ��
        plotm_orbit(time_,satelite,colorname);

    end
    
    
    % ��������� �����
    if (newmap)
        plot_map(worldmap);
    end
    
    % ���������� ����� � ����
    if (plotfile)
        filename = sprintf('pictures\\elevation_t%02g.png',time_);
        print(worldmap,'-dpng',filename);
    end
    
end

