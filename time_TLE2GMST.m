function GMST = time_TLE2GMST(TLEepoch)
%TLE2GMST Summary of this function goes here
%   Detailed explanation goes here

day = mod(TLEepoch,1000);               % день из TLE
yr = (TLEepoch - day)/1000 + 2000;      % год из TLE

JD0 = JDmy(yr,day);                % юлианская дата эпохи

GMST = JD2GMST(JD0);              	% GMST эпохи в градусах
GMST = GMST/180*pi;                   	% GMST эпохи в радианах

end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function JD = JDmy(year,day)
start_year = 1900;
start_day = 1.5;
JD = 2415021;               % юлианская дата 1 января 1900г в полдень
% учет полных лет
cur_year = start_year;
while cur_year<year
    if mod(cur_year,4)==0
        JD = JD + 366;
    else
        JD = JD + 365;
    end
    cur_year = cur_year+1; 
end
JD = JD + day - start_day - 1;          % единичка - эмпирически
end

%------------------------------------------------------------

function GMST = JD2GMST(JD)
%Find the Julian Date of the previous midnight, JD0
JD0 = NaN(size(JD));
JDmin = floor(JD)-.5;
JDmax = floor(JD)+.5;
JD0(JD > JDmin) = JDmin(JD > JDmin);
JD0(JD > JDmax) = JDmax(JD > JDmax);
H = (JD-JD0).*24;       %Time in hours past previous midnight
D = JD - 2451545.0;     %Compute the number of days since J2000
D0 = JD0 - 2451545.0;   %Compute the number of days since J2000
T = D./36525;           %Compute the number of centuries since J2000
%Calculate GMST in hours (0h to 24h) ... then convert to degrees
GMST = mod(6.697374558 + 0.06570982441908.*D0  + 1.00273790935.*H + ...
    0.000026.*(T.^2),24).*15;
end