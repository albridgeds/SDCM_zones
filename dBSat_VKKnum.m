function num = dBSat_VKKnum (satname,basename)
% ����������� ������ ��� �� ������ 


satlen = length(satname);
baselen = length(basename);


%ind = find(satname,'-')


% ���� ������� �������� ��������, ������� ���, �� ��������� - 1
if (satlen-baselen<2)
    num = 1;

else
    strnum = satname(baselen+2:satlen);
    num = str2double(strnum);
    
    % �������� �� ���������� �������� (�� 1 �� 6)
    %if (num<1 || num>6)
    if (num<1)
        fprintf('\nWARNING: wrong VKK number <%s> -> <%d>, set num=1',strnum,num);
        num = 1;
    end

end