function JD = time_JDmy(year,day)
%JD1 Summary of this function goes here
%   Detailed explanation goes here

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

