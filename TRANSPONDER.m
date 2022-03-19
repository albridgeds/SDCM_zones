classdef TRANSPONDER
    %DBSAT1 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        signal;
        band;
        freq_up;
        freq_down;
        Ptx;
        Gtx;
        Grx;
        Ltx;
        Lafu;
        Lextra;
        Lrx;
        Liq;
        antenna;            % 0 - Луч, -1 - Енисей, остальное - ширина ДН по уровню 0,5
        angle2north;
        angle2east;
        
    end
    
    methods
        
        % по умолючанию делаем канал как на Лучах (кроме поворота антенны на Север
        function obj = TRANSPONDER()
            obj.signal = 'L1SBAS';
            obj.Ptx = 57;
            obj.Ltx = 1.5;
            obj.Lafu = 0;
            obj.Lextra = 0;
            obj.Liq = 0;
            obj.antenna = 0;
            obj.angle2north = 0;
            obj.angle2east = 0;
        end
        
    end
    
end

