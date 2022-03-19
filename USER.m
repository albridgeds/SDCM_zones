classdef USER
    %DBSAT1 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        name
        lat
        long
        h
        %channel     % принимаемый сигнал (для антенны)
        el          % минимально допустимый угол места
        %antenna
        
        % минимальный и максимальный уровень сигнала
        Pmin
        Pmax
        Plim    % чтобы нарисовать отдельную линию
        dP
        
    end
    
    methods
        
        function obj = USER(name,h,el)
            obj.name = name;
            obj.lat = 0;
            obj.long = 0;
            obj.h = h;
            %obj.channel = channel;
            obj.el = el;
        end
        
    end
    
end

