function a = orbit_checkWorkzone(sat,orbit)
% �������� ��� ���, �� ����� �� �� �� ������� ������� ����

    a=1;
    
    % ��� ������ � ������� ����
    if ~strcmp(sat.type,'GEO')
        
        % ������� 1: ���� ����� � �� ������ ���� �� ���� ���������� �����������
        nles_el = calc_elevation (sat.nles_lat,sat.nles_long,orbit,0);
    	if nles_el < sat.nles_minel
         	a=0;
        end
        
	end

end

