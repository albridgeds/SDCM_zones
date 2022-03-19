function fig = plotm_orbit (time,satelite,varargin)
% ������ ����� ������������� ���������� ��������� (satelite) � ������������ 
% ��������� �������� � ������������ ������ ������� (time). ���� ����� �
% ������� �������� ����������� (colorname)



% �������� �3 - ����� (�� ��������� - �����)
if nargin>=3
	colorname = varargin{1};
else
    colorname = 'b';
end

% ��������� �4 � �5 - �������� ������ ������� � ������ � ����
newmap = 0;
plotfile = 0;
for i=1:nargin-2
    if strcmp(varargin{i},'newmap')
        newmap = 1;
    elseif strcmp(varargin{i},'plotfile')
        plotfile = 1;
    end
end


size_sat = length(satelite);

fig = 47;
if (newmap)
    worldmap = create_figure(47);
    %clf
end


for i=1:size_sat
    
    %satName = satelite(i);
    %orbit = dbSat(satName);
    
    if strcmp(satelite(i).name,'none')   % ���� ��� ������, ���������� ���� ��
        continue
    end    
    
    orbit = satelite(i).orbit;    
    color = color_set(colorname,i);
    
    satlat = orbit(:,1);
    satlong = orbit(:,2);

    % ���� � �������� ���� ������ (�� ���)
    if (size(satlat,1)>1)
        
        plotm(satlat,satlong,'LineWidth',1,'Color',color)       % ������        
        
        % �����, ������������ ������� ��������� �������� (-1 - ��������� ����� �� ��������� ������)
        t = time_index(time,orbit);
        if time==-1
            t = length(satlat);
        end

        % ������ �������� ��������� ��������
        if satelite(i).cur_active==-1                                                   % ������������� ������� �� �����������
            plotm(satlat(t),satlong(t),'d','LineWidth',1,'MarkerEdgeColor',color)     
        elseif orbit_checkWorkzone(satelite(i),orbit(t,:))                              % ������� � ������� ���� (���������)
            plotm(satlat(t),satlong(t),'d','LineWidth',1,'MarkerEdgeColor','k','MarkerFaceColor',color)
        else
            plotm(satlat(t),satlong(t),'d','LineWidth',1,'MarkerEdgeColor',color)       % ������� �� ��������� ������� ���� (�� �����������)
        end
        
        
    % ���� ��� (���������� ���������)
    else
        plotm(satlat,satlong,'d','LineWidth',1,'MarkerEdgeColor','k','MarkerFaceColor',color)               % �������
        
% ������� - �������� �� � ��� ����������� �������
%         textm(satlat-5,satlong-3,satelite(i).name);
%         satpos = num2str(abs(satelite(i).long));
%         if satelite(i).long<0
%             satpos = strcat(satpos,'W');
%         else
%             satpos = strcat(satpos,'E');
%         end
%         textm(satlat-10,satlong-3,satpos);
    end

end


% ���������� ����� � ����
if (newmap)
    plot_map(worldmap);
end
if (plotfile)
    print(worldmap,'-dpng','pictures\\orbit.png');
end