classdef SATELITE
    %DBSAT1 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        name
        type    % ���, ���, ...
        long    % ������� (��� ���)
        orbit   % ������ (��� ��-���)
        color   % ���� ������ �� �����
        
        num
        
        % ���������� ��
        nles_lat
        nles_long
        nles_minel      % ���������� ���������� ���� ����� ��� �������� ������� �� ��
        
        Lorb;           % !!!�������!!! �������������� ���������, �������� � �������� ����������� ��� ����������� �� ��� � �������
        angle2north
        angle2east
        
        cur_active;     % ��������������� �������� (������� �� ������ �� � ������� ������ �������)
        
        
        % ������������ �������� ������ (��� ��-���)
        a               % Semi-major axis
        ecc             % Eccentricity
        inc             % Inclination
        O               % RA of ascending node
        w               % Arg of perigee
        nuo             % Mean anomaly
        
        period          % ������ ���������
        
    end
    
    methods
        
        function obj = SATELITE(name,type,long,num)
            obj.name = name;
            obj.type = type;
            obj.long = long;
            obj.Lorb=0;         % �� �����, ����� ���. �����, ������� ������� ��������� � �������� ������� �� ��������
            obj.angle2north=0;
            obj.angle2east=0;
        end
        
    end
    
end

