function satdata = orbit_readtle2(file, catalog)

% READTLE Read satellite ephemeris data from a NORAD two-line element (TLE) file.
%
% INPUTS:
%   file    - Path to any standard two-line element file.
%   catalog - Optional array of NORAD catalog numbers for the satellites of
%             interest. The default action is to display data from every
%             satellite in the file.
%
% Brett Pantalone
% North Carolina State University
% Department of Electrical and Computer Engineering
% Optical Sensing Laboratory
% mailto:bapantal@ncsu.edu
% http://research.ece.ncsu.edu/osl/



ge = 398600.8; % Earth gravitational constant (WGS72)
TWOPI = 2*pi;
MINUTES_PER_DAY = 1440.;
MINUTES_PER_DAY_SQUARED = (MINUTES_PER_DAY * MINUTES_PER_DAY);
MINUTES_PER_DAY_CUBED = (MINUTES_PER_DAY * MINUTES_PER_DAY_SQUARED);


if nargin < 2
	catalog = [];
end

fd = fopen(file,'r');
if fd < 0, fd = fopen([file '.tle'],'r'); end
assert(fd > 0,['Can''t open file ' file ' for reading.'])

i = 0;
A0 = fgetl(fd);
A1 = fgetl(fd);
A2 = fgetl(fd);

%satdata = zeros(1,8);
 
while ischar(A2)
    i = i + 1;
    satnum = str2num(A1(3:7));
    
    if isempty(catalog) || ismember(satnum, catalog)

        %fprintf('%s\n', repmat('-',1,50));
        %fprintf('Satellite: %s\n', A0)
        assert(chksum(A1), 'Checksum failure on line 1')
        assert(chksum(A2), 'Checksum failure on line 2')

        name = A0;
        
        Cnum = A1(3:7);      			         % Catalog Number (NORAD)
        SC   = A1(8);					         % Security Classification
        ID   = A1(10:17);			             % Identification Number
        epoch = str2num(A1(19:32));              % Epoch
        TD1   = str2num(A1(34:43));              % first time derivative
        TD2   = str2num(A1(45:50));              % 2nd Time Derivative
        ExTD2 = A1(51:52);                       % Exponent of 2nd Time Derivative
        BStar = str2num(A1(54:59));              % Bstar/drag Term
        ExBStar = str2num(A1(60:61));            % Exponent of Bstar/drag Term
        BStar = BStar*1e-5*10^ExBStar;
        Etype = A1(63);                          % Ephemeris Type
        Enum  = str2num(A1(65:end));             % Element Number

        inc = str2num(A2(9:16));                 % Orbit Inclination (degrees)
        raan = str2num(A2(18:25));               % Right Ascension of Ascending Node (degrees)
        e = str2num(strcat('0.',A2(27:33)));     % Eccentricity
        omega = str2num(A2(35:42));              % Argument of Perigee (degrees)
        M = str2num(A2(44:51));                  % Mean Anomaly (degrees)
        no = str2num(A2(53:63));                 % Mean Motion
        a = ( ge/(no*2*pi/86400)^2 )^(1/3);      % semi major axis (m)
        rNo = str2num(A2(64:68));                % Revolution Number at Epoch

        satdata(i).name = name;
        satdata(i).epoch = epoch;
        satdata(i).norad_number = Cnum;
        satdata(i).bulletin_number = ID;
        satdata(i).classification = SC; % almost always 'U'
        satdata(i).revolution_number = rNo;
        satdata(i).ephemeris_type = Etype;
        satdata(i).xmo = M * (pi/180);
        satdata(i).xnodeo = raan * (pi/180);
        satdata(i).omegao = omega * (pi/180);
        satdata(i).xincl = inc * (pi/180);
        satdata(i).eo = e;
        satdata(i).xno = no * TWOPI / MINUTES_PER_DAY;
        satdata(i).xndt2o = TD1 * 1e-8 * TWOPI / MINUTES_PER_DAY_SQUARED;
        satdata(i).xndd6o = TD2 * TWOPI / MINUTES_PER_DAY_CUBED;
        satdata(i).bstar = BStar;
      
    end
    
    A0 = fgetl(fd);
    A1 = fgetl(fd);
    A2 = fgetl(fd);
end
  
fclose(fd);
  
end

%%
% Checksum (Modulo 10)
% Letters, blanks, periods, plus signs = 0; minus signs = 1
function result = chksum(str)
  result = false; c = 0;
  
  for k = 1:68
    if str(k) > '0' && str(k) <= '9'
      c = c + str(k) - 48;
    elseif str(k) == '-'
      c = c + 1;
    end
  end

  if mod(c,10) == str(69) - 48
    result = true;
  end
  
end