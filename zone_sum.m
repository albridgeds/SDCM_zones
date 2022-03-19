function [zone] = zone_sum(zone,zone2,varargin)
% увеличивает zone на единицу, если zone2 удовлетворяет условию 
% (больше,меньше или точно равно пределу)


if nargin>=4 
    
    type = varargin{1};
    limit = varargin{2};
    
    switch type
        case '>'
            zone2 = zone2 > limit;
        case '>='
            zone2 = zone2 >= limit;
        case '<'
            zone2 = zone2 < limit;
        case '<='
            zone2 = zone2 <= limit;
        case '=='
            zone2 = zone2 == limit;
    end
    
end

zone = zone + double(zone2);


end

