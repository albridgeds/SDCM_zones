function plotm_power (time,satelite,channel,receiver,mode)
% ������ �������� ������� �� ��� ���� � ������������ ������� �������

% mode=0 - ��������� ����� ��� ������� ��
% mode=1 - ��������� ����� ��� ���� ��
% mode=2 - ��������� � ��������� �����

[lat,long] = zone_earth();

size_lat = size(lat,1);
size_long = size(lat,2);



satlen = length(satelite);
satzone_flag = zeros(1,satlen);




% ���������� ����� (�.�. ������� �� ��������, ���� ��� �� ���)
for time_=time

    % �� ������� ���������� ��������
    for s=1:satlen

        if strcmp(satelite(s).name,'none')   % ���� ��� ������, ���������� ���� ��
            continue
        end
        
        sat = satelite(s);
%         chanlen = length(sat.channel);
% 
%         % ������� � �������� �����, ���������� � ������ ��������
%         channel_flag=0;
%         for c=1:chanlen
%             satchannel = sat.channel(c).signal;
%             if (strcmp(satchannel,signal))
%                 channel_flag=1;
%                 channel = sat.channel(c);
%             end
%         end
    
       
        % ���� ������ ������ ���, ���������� ���� �������
%         if channel_flag==0
%              fprintf('\n\nWARNING: satelite <%s> has no <%s> channel',satelite(s).name,signal);
%              continue;
%         end

        % ���� ��� ��� � ��� ���� ��� ���� ������, �� ��������� �� �����
        if strcmp(sat.type,'GEO') && satzone_flag(s)~=0
            continue;
        end
        
        orbit = sat.orbit;
        if (size(orbit,1)>1)    % ���� ������ ������ � ���� ������� ����� �� ������� (�� ���)
            t = time_index(time_,orbit);
            orbit = orbit(t,:);
        end
        
        % ���� �����, ���������� � 
        %[el,~,r,phi] = calc_geometry (lat,long,orbit,channel.angle2north,channel.angle2east,receiver.h);
        [el,~,r,phi] = calc_geometry (lat,long,orbit,sat.angle2north,sat.angle2east,receiver.h);
        
        
        % ������ �������� � ����
        zone_p = zeros(size(lat)) - receiver.Pmin;          % �������!!! ���� ��������� ���� ������, ������������ ��� ������� � �����������
        if orbit_checkWorkzone(sat,orbit)       % ������ ���� �� � ������� ����
            for i=1:size_lat
                for j=1:size_long
                    zone_p(i,j) = calc_power(el(i,j),r(i,j),phi(i,j),channel,receiver);
                end
            end
        end

        % ��������� ��� ������������� � ������ ������� ������� � ������������ ��������� �����
        zone(:,:,s) = zone_p;
        satzone_flag(s)=1;
        
        
        % ���� ����� ������ ������ ��������� �����, ��������� � ���������� ��������
        if satlen>1 && mode==1 
            continue;
        end
        
        % ���� ������� �� ��������� ������� ����, ��������� � ����������
        if ~orbit_checkWorkzone(sat,orbit)
            continue;
        end
        
        worldmap = create_figure(45);
        powers = color_power(zone_p,receiver);      %%% ��� ���������� ����!
        
        % ����� ������ �������� ��������
        contourfm(lat,long,zone_p,powers,'LineStyle','none');
        contourcbar
        contourm(lat,long,zone_p,[receiver.Pmax receiver.Pmax],'LineColor','r','LineWidth',2);
        
        contourm(lat,long,zone_p,[receiver.Plim receiver.Plim],'LineColor','.b','LineWidth',2);
        
        %if strcmp(channel.signal,'L3Sigal')
        %    contourm(lat,long,zone_p,[-155.3 -155.3],'LineColor','.b','LineWidth',2);
        %end

        % ��������������
        min_el = receiver.el;
        contourm(lat,long,el,[min_el min_el],'-b','LineWidth',1);

        % ������ ���������
        plotm_orbit(time_,satelite(s));

        s_title = sprintf('%s %s %02gh (P=%dW)',sat.name,channel.signal,time_,channel.Ptx);
        %title(['Power: ',signal,' time ',time,'h']);
        title(s_title)

        % ���������� ����� � ����
        plot_map(worldmap);
        filename = sprintf('pictures\\power_%s',sat.name);
        if ~strcmp(sat.type,'GEO')
            filename = sprintf('%s_%02g',filename,time_);
        end
        filename = [filename,'.png'];
        print(worldmap,'-dpng',filename);
        fprintf('\ncreate file <%s>',filename);

    end

    
    % ������ ��������� ����� (���� ������ ������ �� � � ��������������� ������)
    if satlen>1 && mode>0
        sum_zone = max(zone(:,:,1),zone(:,:,2));
        for s=3:satlen
            sum_zone = max(sum_zone,zone(:,:,s));
        end
        
        worldmap = create_figure(45);
        %plot_power(lat,long,sum_zone,channel.signal)
        
        % ����� ������ �������� ��������
        powers = color_power(sum_zone,receiver);
        contourfm(lat,long,sum_zone,powers,'LineStyle','none');
        contourcbar
        
        for s=1:satlen
            %el = zone_elevation(lat,long,satelite(s).orbit);
            %contourm(lat,long,el,[5 5],'-b','LineWidth',2);
            plotm_orbit(time_,satelite);
        end        
        s_title = sprintf('%s %02gh',channel.signal,time_);
        title(s_title)
        plot_map(worldmap);
        filename = sprintf('pictures\\powers');
         if ~strcmp(sat.type,'GEO')
            filename = sprintf('%s_%02g',filename,time_);
        end
        filename = [filename,'.png'];
        print(worldmap,'-dpng',filename);
        fprintf('\ncreate file <%s>',filename);
    end
    
end



