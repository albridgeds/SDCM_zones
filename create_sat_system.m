function sat_array = create_sat_system(time,satname,satnum)

addpath(genpath('..\SDP\SDP4\'))
addpath(genpath('..\SatMotion Forecast\'))

switch satname
    case {'GLONASS','GLO','�������','���'}              % �� �������
        satname = 'GLO';
        tlepath = 'TLE\GLONASS.txt';
    case {'GPS'}
        satname = 'GPS';
        tlepath = 'TLE\GPS.txt';
    case {'Galileo','GAL'}
        satname = 'GAL';
        tlepath = 'TLE\GALILEO.txt';
    case {'Beidou'}
        satname = 'Beidou';
        tlepath = 'TLE\BEIDOU.txt';
end

satdata = orbit_readtle2(tlepath);      % ��� �� �� �����
%satdatalen = length(satdata);       	% c������ ��������� �������� �� �����
satlen = length(satnum);                % c������ ��������� �����

epoch = zeros(1,satlen);
for i=1:satlen
	gnss{i} = sprintf('%s-%d',satname,i);
	sat_array(i) = dbSat(gnss(i));
    epoch(i) = satdata(satnum(i)).epoch;
    %fprintf('%d  -  epoch = %.8f\n',i,epoch(i));
end



epoch0 = max(epoch);                            % ����� ������������ �����
%fprintf('\nmax epoch = %.8f\n',epoch0);
daynum = fix(epoch0);                           % ���������� ������ ����� ���� �����
%fprintf('\ndaynum = %.8f\n',daynum);


% ����� ��� ������� �������� �������� � ���� ������

% dt = (epoch0 - epoch)*86400;                  % ������� �� ������� ���� � �������
% time_dt = time(2)-time(1);
% time_T = time(end)-time(1);

%t0 = (daynum - satdata.epoch)*86400;           % ��������� �������� �� ����� tle � ��������
%time = t0:600:t0+3600*24-600;                  % ����� � �������� � ����� ������




w_earth  = 7.2921158553e-5;                     % Rotation rate of Earth (rad/s)   
spheroid = referenceEllipsoid('WGS 84');

for i=1:satlen
 
    satepoch = satdata(satnum(i)).epoch;
    t0 = (daynum - satepoch)*86400;             % ��������� �������� �� ����� tle � ��������
    %fprintf('\n%d  %s %.8f   %.8f   %g',i,satdata(satnum(i)).name,satepoch,epoch(i),t0)
    
    sattime = time+t0;
    sattime1 = epoch(i) + sattime/86400;
    %time = dt(i):time_dt:dt(i)+time_T;         % ����� � �������� � ����� ������
    
    ECI = zeros(3,length(time));    
    for t = 1:length(time)
        [pos, vel] = sdp4(sattime(t)/60, satdata(satnum(i)));      % �������� ����� � �������
        ECI(:,t) = pos;
    end
    
    GMSTo = time_TLE2GMST(satepoch);
    GMST = zeroTo360(GMSTo + w_earth*sattime,1);   % GMST �� ������� ������ ������� (����� ��� �����)
    ECEF = eci2ecef(ECI,GMST); 
    [lat,long,h] = ecef2geodetic(spheroid,ECEF(1,:)*1000,ECEF(2,:)*1000,ECEF(3,:)*1000);
    sat_array(i).orbit = [lat;long;h;time]';
    sat_array(i).num = satnum(i);
    
%     fprintf('\n\n%d - %s  %f',i,satdata(satnum(i)).name,GMSTo)   
%     for t = 1:length(time)
%         r = sqrt(ECEF(1,t)*ECEF(1,t) + ECEF(2,t)*ECEF(2,t) + ECEF(3,t)*ECEF(3,t));
%         fprintf('\n%d  %g  %f  %f  %f  %f  %f  %f',t,sattime(t),sattime1(t),GMST(t),ECEF(1,t),ECEF(2,t),ECEF(3,t),r)
%     end
    
    
end






end


