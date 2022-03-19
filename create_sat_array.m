function sat_array = create_sat_array(varargin)
%CREATE_STR_ARRAY Summary of this function goes here
%   Detailed explanation goes here


% ����������� ��������� ��� �������� ������ ���������
satname = 'none';
satlen = nargin;



switch varargin{1}
    
    % �� �������
    case {'GLONASS','GLO','�������','���'}
        satlen = 24;
        satname = 'GLO';
    case {'GLONASS-K','GLO-K','�������-�','���-�'}
        satlen = 30;
        satname = 'GLOk';
    case {'GPS'}
        satlen = 30;
        satname = 'GPS';
    case {'Galileo','GAL'}
        satlen = 30;
        satname = 'GAL';
    case {'Beidou'}
        satlen = 27;
        satname = 'Beidou';
end
    


satnum = 1:satlen;          % ��� �����������


% ���� ��� ����� ������� ����� ���������
if strcmp(satname,'none')
    for i=1:satlen
        sat_array(i) = dbSat(varargin(i));
    end
    
% ���� ���� ������ �� ����    
else
    % ���� ��� ��������� ���������� �������� ��� � ��
    if nargin>=2
        satnum = varargin{2};       % �������� ���
    end
    
    for i=satnum
        gnss{i} = sprintf('%s-%d',satname,i);
        sat_array(i) = dbSat(gnss(i));
    end     
    
end




% �������� ������ ��� ������� ��    
for i=satnum
    
    % ���� ���� ����� ��
    if ~strcmp(sat_array(i).name,'none')
        
        % ���� �� ���
        if strcmp(sat_array(i).type,'GEO')
            sat_array(i).orbit = orbit_GEO(sat_array(i).long);
            
        % ���� �� ��� (��������� �����)
        elseif strcmp(sat_array(i).type,'VKK')
            num = dBSat_VKKnum(varargin{i},sat_array(i).name);
            sat_array(i).orbit = orbit_VKK1(sat_array(i).name,num);
            if num<3
                sat_array(i).nles_long = 60;
            else
                sat_array(i).nles_long = 120;
            end
            sat_array(i).nles_lat = 40;
            sat_array(i).nles_minel = 20;
            
        % ���� �� � �������
        else
            sat = sat_array(i);
            Kepler = [sat.a,sat.ecc,sat.inc,sat.O,sat.w,sat.nuo];
            dT = 60;                                        % ���� ������ �� ���� �� ������, ��� 1 ������
            if sat.period<3600
                dT = 1;                                     % ���� ������ ������ ����, ��� 1 �
            elseif sat.period>3600*24*7
                dT = 3600;                                  % ���� ������ ������ ������, ��� 1 ���
            end

            time = 0:dT:sat.period;                       %time vector
            GMSTo = 0;
            sat_array(i).orbit = orbit_Kepler(Kepler,GMSTo,time);
        end
            
    end
   
end



