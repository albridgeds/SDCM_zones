function color = color_lines(step)
%COLOR_LINES Summary of this function goes here
%   Detailed explanation goes here



cmap = colormap;                        % ���������� ������� �������
cmap2 = colormap(lines);                % ��������� �������� � ������ ������������� ������� (�� ���� ����� ������� � ���� ����������� �������)

color = cmap2(step,:);

colormap(cmap);                         % ���������� ����������� �������


end

