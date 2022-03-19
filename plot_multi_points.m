function plot_multi_points(lat,long,zone_work)
% ����� ��������� ������������ ��� ������������� ����� ��
% min_el - ���� �����, ���� �������� ��������� 




% ���������
%figure(1)

% ������������ ���������, ����� ��� ����������� ����������� ������
k = max(zone_work(:));

% ����� ��� ����������� ��������� ���
cmap_r =  	[1.0, 0.8, 0.8];
cmap_rg =   [1.0, 1.0, 0.8];
cmap_g =    [0.8, 1.0, 0.8];
cmap_gb = 	[0.8, 1.0, 1.0];
%cmap_b = 	[0.8, 0.8, 1.0];   

% ��� �������� - �������, � ����������� ��������� - ������
cmap = [cmap_r;cmap_rg];

% ���������� �������� - ������� ����
if (k>1)
    cmap = [cmap;cmap_g];
end

% ����������� � ����� - ������� ����
for i=2:k-1
    cmap = [cmap;cmap_gb];
end


colormap(cmap)


contourfm(lat,long,zone_work,k+1,'LineStyle','none');
%contourcbar


end

