function num = dBSat_VKKnum (satname,basename)
% определение номера ВКК на орбите 


satlen = length(satname);
baselen = length(basename);


%ind = find(satname,'-')


% если слишком короткое название, индекса нет, по умолчанию - 1
if (satlen-baselen<2)
    num = 1;

else
    strnum = satname(baselen+2:satlen);
    num = str2double(strnum);
    
    % проверка на допустимые значения (от 1 до 6)
    %if (num<1 || num>6)
    if (num<1)
        fprintf('\nWARNING: wrong VKK number <%s> -> <%d>, set num=1',strnum,num);
        num = 1;
    end

end