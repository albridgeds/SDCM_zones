function TLE = orbit_readtle(file, catalog)

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

  TLE = zeros(1,8);
  
  while ischar(A2)
    i = i + 1;
    satnum = str2num(A1(3:7));
    if isempty(catalog) || ismember(satnum, catalog)

      %fprintf('%s\n', repmat('-',1,50));
      %fprintf('Satellite: %s\n', A0)
      assert(chksum(A1), 'Checksum failure on line 1')
      assert(chksum(A2), 'Checksum failure on line 2')
      
      T0 = str2num(A1(19:32));       % YYDDD.DDDDDDDD
      Incl = str2num(A2(9:16));
      Omega = str2num(A2(18:25));
      ecc = str2num(['.' A2(27:33)]);
      w = str2num(A2(35:42));
      M = str2num(A2(44:51));
      n = str2num(A2(53:63));
      T = 86400/n;
      a = ((T/(2*pi))^2*398.6e12)^(1/3);
      b = a*sqrt(1-ecc^2);
      
%       fprintf('Catalog Number: %d\n', satnum)
%       fprintf('Epoch time: %f\n',T0)
%       fprintf('Inclination: %f deg\n', Incl)
%       fprintf('RA of ascending node: %f deg\n', Omega)
%       fprintf('Eccentricity: %f\n', ecc)
%       fprintf('Arg of perigee: %f deg\n', w)
%       fprintf('Mean anomaly: %f deg\n', M)
%       fprintf('Mean motion: %f rev/day\n', n)
%       fprintf('Period of rev: %.0f s/rev\n', T)
%       fprintf('Semi-major axis: %.0f meters\n', a)
%       fprintf('Semi-minor axis: %.0f meters\n', b)
      
      TLE(i,1) = satnum;            % номер КА по каталогу NORAD
      TLE(i,2) = T0;                % опорное время эпохи
      TLE(i,3) = a/1000;            % большая полуось (км)
      TLE(i,4) = ecc;               % эксцентриситет
      TLE(i,5) = Incl*pi/180;       % наклонение (рад)
      TLE(i,6) = Omega*pi/180;      % долгота восходящего узла (рад)
      TLE(i,7) = w*pi/180;          % агрумент перигея (широты?) (рад)
      TLE(i,8) = M*pi/180;          % средняя аномалия (рад)
      TLE = [TLE;zeros(1,8)];
      
    end
    
    A0 = fgetl(fd);
    A1 = fgetl(fd);
    A2 = fgetl(fd);
  end
  
  fclose(fd);
  TLE = TLE(1:i,:);
  
%   TLE(:,1)
%   TLE(:,2)
%   TLE(:,3)
%   TLE(:,4)
%   TLE(:,5)
%   TLE(:,6)
%   TLE(:,7)
%   TLE(:,8)
  
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