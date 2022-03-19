% Orbit groundtrack plot Latitude longitude lat long
% Richard Rieber
% December 18, 2006
% rrieber@gmail.com
%
% Revision 8/21/07: Fixed small typo in help comments
%                   Added H1 line for lookfor functionality
%          9/27/09: Added inputs for:
%                    - plot string, s, to customize plot
%                    - mu, gravitational constant
%                   Also fixed a bug drawing a horizontal line across the
%                   plot when the orbit propogates from east to west
%                   Removed Re, since it is not used.
%
% function Groundtrack(Kepler,GMSTo,Tf,fig,dT,s,mu)
%
% Purpose: This function plots the groundtrack of a given orbit.
% 
% Inputs:  o Kepler - A vector of length 6 containing all of the keplerian
%                    orbital elements [a,ecc,inc,Omega,w,nu] in km and radians
%          o GMSTo  - The Greenwich Mean Siderial Time at the given initial position
%                     in radians.
%          o Tf     - The length of time to plot the groundtrack in seconds
%          o fig    - The figure number on which to plot the groundtrack [OPTIONAL]
%          o dT     - Timesteps for groundtrack, defaults to 60 seconds [OPTIONAL]
%          o s      - String for customizing the plot (example: '--b*').
%                     See, help plot, for more information [OPTIONAL]
%          o mu     - Gravitational constant of Earth. Defaults to
%                     3998600.4415 km^3/s^2 [OPTIONAL]
%
% Outputs: o H      - The figure handle

function orbit = orbit_Kepler(Kepler,GMSTo,time)

%r2d = 180/pi;                   % Radians to degrees conversion
w_earth  = 7.2921158553e-5;     % rad/s  %Rotation rate of Earth
mu  = 398600.4415;              % km^3/s^2  Gravitational constant of Earth

a   = Kepler(1);        % большая полуось
ecc = Kepler(2);        % эксцентриситет
inc = Kepler(3);        % наклонение
O   = Kepler(4);        % долгота восходящего узла
w   = Kepler(5);        % агрумент перигея (широты?)
nuo = Kepler(6);        % средняя аномалия

n = (mu/a^3)^.5;        % Mean motion of satellite


% !!!ВАЖНО!!!
%E  = atan2(sin(nuo)*(1-ecc^2)^.5,ecc+cos(nuo));     %Eccentric anomaly
%MA = E-ecc*sin(E);                                  %Initial Mean anomaly
MA = nuo;

%time = [0:dT:Tf]; %time vector

%bp(1)    = 0;
%bp(2)    = length(time);
%k        = 2;
%Lat_rad  = zeros(1,length(time));
%Long_rad = zeros(1,length(time));
xyz = zeros(3,length(time));

for j = 1:length(time)
    
    GMST = zeroTo360(GMSTo + w_earth*time(j),1);    %GMST in radians
    M = zeroTo360(MA + n*time(j),1);                %Mean anomaly in rad
    nu = nuFromM(M,ecc,10^-12);                     %True anomaly in rad
    
    [ECI,~] = randv(a,ecc,inc,O,w,nu);
    %clear veci
    ECEF = eci2ecef(ECI,GMST);
    
    %[Lat_rad(j),Long_rad(j)] = RVtoLatLong(ECEF);
    xyz(:,j) = ECEF;
    
%     if j > 1 && ((Long_rad(j)-Long_rad(j-1)) < -pi || (Long_rad(j)-Long_rad(j-1)) > pi)
%         bp(k) = j-1;
%         k     = k+1;
%     end
end

%bp(length(bp)+1) = length(time);
% Lat              = Lat_rad.*r2d;
% Long             = Long_rad.*r2d;



spheroid = referenceEllipsoid('WGS 84');
[lat,long,h] = ecef2geodetic(spheroid,xyz(1,:)*1000,xyz(2,:)*1000,xyz(3,:)*1000);

orbit = [lat;long;h;time]';


% % вывод на карту
% figure()
% load mapdata
% hold on
% geoshow(ll_world(:,1),ll_world(:,2),'Color','black')
% % for j = 2:length(bp)
% % 	plot(Long(bp(j-1)+1:bp(j)),Lat(bp(j-1)+1:bp(j)),'b')
% % end
% plot(long,lat,'b')
% axis([-180,180,-90,90])
% xlabel('Longitude (\circ)')
% ylabel('Latitude (\circ)')
% 
% % запись координат в файл
% fid = fopen('orbit_xyz.txt','w');
% for j = 1:length(time)
%     fprintf(fid,'%6d %12.3f %12.3f %12.3f\n',time(j),xyz(1,j),xyz(2,j),xyz(3,j));
% end
% fclose(fid);
% 
% 
% fid = fopen('orbit_lbh.txt','w');
% for j = 1:length(time)
%     fprintf(fid,'%6d %12.3f %12.3f %12.3f\n',time(j),lat(j),long(j),h(j));
% end
% fclose(fid);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function y = zeroTo360(x,unit)

if nargin == 1
    unit = 0;
elseif nargin > 2
    error('Too many inputs')
end

if unit
    deg = 2*pi;
else
    deg = 360;
end

y = zeros(1,length(x));

for j = 1:length(x)
	if (x(j) >= deg)
        x(j) = x(j) - fix(x(j)/deg)*deg;
	elseif (x(j) < 0)
        x(j) = x(j) - (fix(x(j)/deg) - 1)*deg;
	end
	y(j) = x(j);
end

%--------------------------------------------------

function nu = nuFromM(M,ecc,tol)

if nargin < 2 || nargin > 3
    error('Incorrect number of inputs, see help nuFromM.m')
elseif nargin == 2
    tol = 10^-8;
end

E = CalcEA(M,ecc,tol);  %Determining eccentric anomaly from mean anomaly

% Since tan(x) = sin(x)/cos(x), we can use atan2 to ensure that the angle for nu
% is in the correct quadrant since we know both sin(nu) and cos(nu).  [see help atan2]
nu = atan2((sin(E)*(1-ecc^2)^.5),(cos(E)-ecc));

%--------------------------------------------------

function E = CalcEA(M,ecc,tol)

%Checking for user inputed tolerance
if nargin == 2
    %using default value
    tol = 10^-8;
elseif nargin > 3
    error('Too many inputs.  See help CalcEA')
elseif nargin < 2
    error('Too few inputs.  See help CalcEA')
end

if (M > -pi && M < 0) || M > pi
    E = M - ecc;
else
    E = M + ecc;
end

Etemp  = E + (M - E + ecc*sin(E))/(1-ecc*cos(E));
Etemp2 = E;

while abs(Etemp - Etemp2) > tol
    Etemp = Etemp2;
    Etemp2 = Etemp + (M - Etemp + ecc*sin(Etemp))/(1-ecc*cos(Etemp));
end

E = Etemp2;

%--------------------------------------------------

function [R,V] = randv(a,ecc,inc,Omega,w,nu,U)

if nargin < 6 || nargin > 7
    error('Number of inputs incorrect.  See help randv')
elseif nargin == 6
    U = 398600.4415; %Gravitational Constant for Earth (km^3/s^2)
end

if length(a) ~= length(ecc) && length(a) ~= length(inc) && length(a) ~= length(Omega)...
        && length(a) ~= length(w) && length(a) ~= length(nu)
    error('Input vectors are not the same size.  Check inputs')
end

%Pre-allocating memory
R = zeros(3,length(a));
V = zeros(3,length(a));

for j = 1:length(a)
    p = a(j)*(1-ecc(j)^2);
    
    % CREATING THE R VECTOR IN THE pqw COORDINATE FRAME
    R_pqw(1,1) = p*cos(nu(j))/(1 + ecc(j)*cos(nu(j)));
    R_pqw(2,1) = p*sin(nu(j))/(1 + ecc(j)*cos(nu(j)));
    R_pqw(3,1) = 0;
    
    % CREATING THE V VECTOR IN THE pqw COORDINATE FRAME    
    V_pqw(1,1) = -(U/p)^.5*sin(nu(j));
    V_pqw(2,1) =  (U/p)^.5*(ecc(j) + cos(nu(j)));
    V_pqw(3,1) =   0;
    
    % ROTATING THE pqw VECOTRS INTO THE ECI FRAME (ijk)
    R(:,j) = R3(-Omega(j))*R1(-inc(j))*R3(-w(j))*R_pqw;
    V(:,j) = R3(-Omega(j))*R1(-inc(j))*R3(-w(j))*V_pqw;
end

%--------------------------------------------------

function [ECEF,V_ECEF] = eci2ecef(ECI, GST, V_ECI)

%Checking number of inputs for errors
if nargin < 2 || nargin > 3
    error('Incorrect number of inputs.  See help eci2ecef.')
end

[b,n] = size(ECI);
%Checking to see if length of ECI matrix is the same as the length of the GST vector
if n ~= length(GST)
    error('Size of ECI vector not equal to size of GST vector.  Check inputs.')
end

%Checking to see if the ECI vector has 3 elements
if b ~= 3
    error('ECI vector must have 3 elements to the vector (X,Y,Z) coordinates')
end

ECEF = zeros(3,n);

if nargin == 3
    V_ECEF = zeros(3,n);
end

for j = 1:n  %Iterating thru the number of positions provided by user
    % Rotating the ECI vector into the ECEF frame via the GST angle about the Z-axis
    ECEF(:,j) = R3(GST(j))*ECI(:,j);
    if nargin == 3
        V_ECEF(:,j) = R3(GST(j))*V_ECI(:,j);
    end
end

%--------------------------------------------------

function A = R1(x)

if nargin > 1
    error('Too many inputs.  See help file')
end

A = [1      0       0;
     0      cos(x)  sin(x);
     0      -sin(x) cos(x)];

function A = R2(x)

if nargin > 1
    error('Too many inputs.  See help file')
end

A = [cos(x)  0      -sin(x);
     0       1      0;
     sin(x)  0      cos(x)];

function A = R3(x)

if nargin > 1
    error('Too many inputs.  See help file')
end

A = [cos(x)  sin(x)     0;
     -sin(x) cos(x)     0;
     0       0          1];
