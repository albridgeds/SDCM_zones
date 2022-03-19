function plotm_satangles (time,satelite,receiver,varargin)
% ����� �� ����� ����� ���������� � ����� �� ��� �� �� �����



% ������� �������� �4 - ������������ (�� ��������� - ���������, ������ 0)
% if nargin>=3
% 	user_h = varargin{1}.h;
% else
%     user_h = 0;
% end


% ������� �������� �3 - ����� �������� (�� ��������� - �����)
if nargin>=4
	colorname = varargin{1};
else
    colorname = 'b';
end

% ������� �������� �4 - ����, �� �������� ������� ������ (�� ��������� - 5 ��������)
% if nargin>=5
% 	min_el = varargin{3};
% else
%     min_el = 5;
% end

% ������� ��������� �5 � �6 - �������� ������ ������� � ������ � ����
newmap = 0;
plotfile = 0;
for i=1:nargin-3
    if strcmp(varargin{i},'newmap')
        newmap = 1;
    elseif strcmp(varargin{i},'plotfile')
        plotfile = 1;
    end
end




% �������� ����, ��� ������� ������� ������
[lat,long] = zone_earth();

size_sat = length(satelite);


for time_=time
    
    if (newmap)
        worldmap = create_figure(46);
    end
    
    for i=1:size_sat
        sat = satelite(i);
        orbit = sat.orbit;
        
    	if strcmp(satelite(i).name,'none')   % ���� ��� ������, ���������� ���� ��
            continue
        end  
        
        if (size(orbit,1)>1)    % ���� ������ ������ � ���� ������� ����� �� ������� (�� ���)
            t = time_index(time_,orbit);
            orbit = orbit(t,:);
        end
        
        %el = calc_elevation(lat,long,orbit,user_h);                % ������� ������ ���� �����
        %[el,~,phi,~] = calc_geometry (lat,long,orbit(t,:));
        [el,~,~,phi] = calc_geometry (lat,long,orbit,sat.angle2north,sat.angle2east,receiver.h);
 
        color = color_set(colorname,i);
       


        % ���� �� ��� �������
        %my_phi = 5;
        %contourm(lat,long,phi,[my_phi my_phi],'g','LineWidth',2);
        contourm(lat,long,phi,0:1:10,'g','LineWidth',1);
        
        % ���� ��������� �� ���� 0 �������� 
        min_el = 0;
        contourm(lat,long,el,[min_el min_el],'LineColor',color,'LineWidth',2)
        
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










% % �������� ����, ��� ������� ������� ������
% [lat,long] = zone_earth();
% 
% min_el = 10;
% my_phi = 8.5;
% %my_phi = 5:1:9;
% 
% for time_=time
% 
%     t = time_index(time_);
%    
%     [el,~,phi,~] = calc_geometry (lat,long,orbit(t,:));
% 
% 
%     worldmap = figure(48);
%     clf
%     axesm('MapProjection','eqdcylin','Frame','on','Grid','on','MeridianLabel','on','ParallelLabel','on');
%     
%     % ��������� ����������� �����
%     set(worldmap,'Position',[10,50,1200,800]);
%     style = hgexport('factorystyle');
%     style.Bounds = 'tight';
%     hgexport(gcf,'-clipboard',style,'applystyle', true);
%     
%     load mapdata
%     geoshow(ll_world(:,1),ll_world(:,2),'Color','black')
%     russia = load('russia2.dat');
%     plotm(russia(:,1),russia(:,2),'-k','LineWidth',1);
%  
%     
%     % �������������� �� ���� �����
%     contourm(lat,long,el,[min_el min_el],'--b','LineWidth',1);              
%     
%     % ���� �� ��� ��
%     contourm(lat,long,phi,[my_phi my_phi],'-b','LineWidth',2);
%     %contourm(lat,long,phi,my_phi);
% 
%     % ������� �� ������ ������ ���������
%     plot_orbit(orbit,t,1);
%    
%     
%     % ���������� ����� � ����
%     filename = sprintf('pictures\\angles_t%04.1f.png',time_);
%     print(worldmap,'-dpng',filename);
%     
%     
%     
% end

