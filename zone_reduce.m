function [rzone,rzone1,rzone2,rzone3,rzone4] = zone_reduce (zone,limit,type,zone1,zone2,zone3,zone4)
% �� ��������, ������� ��������������


size_lat = size(zone,1);
size_long = size(zone,2);

k=1;


% for i=1:size_lat
%     for j=1:size_long
%         
%         % ����� 1: ��������� ������ ������������
%         if strcmp(type,'more')
%             if (zone(i,j)>limit)
%                 rzone(k)=zone(i,j);
%                 rzone1(k)=zone1(i,j);
%                 rzone2(k)=zone2(i,j);
%                 rzone3(k)=zone3(i,j);
%                 rzone4(k)=zone4(i,j);
%                 k=k+1;
%             end
%         end
%         
%     end
% end

% ���������� �����������
for i=1:size_lat
    
    k=0;
    
    % ���������� ���������
    for j=1:size_long

            if (zone(i,j)>limit)
                k = k+1;            % ������� ���������� ��������� � ������, �� ��������������� �������
            end
                
    end
    
    % ���� � ��������� ���� ���� �� ���� �������, ��������������� �������, �������� ���������
    if (k>0)
    
                 rzone(i,j)=zone(i,j);
                 rzone1(i,j)=zone1(i,j);
                 rzone2(i,j)=zone2(i,j);
                 rzone3(i,j)=zone3(i,j);
                 rzone4(i,j)=zone4(i,j);
                 
                 size_long = size_long-1;
                 j = j-1;
            end
            
    end
end

