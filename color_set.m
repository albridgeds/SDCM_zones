function color = color_set (colorname,i)
%COLOR_SET Summary of this function goes here
%   Detailed explanation goes here



size_color = size(colorname,2);


    if (i>size_color)
        color = dbColor(colorname(size_color)); % если указано недостаточно цветов, используем последний
    else
        color = dbColor(colorname(i));
    end
    if (color==0)
        color = color_lines(i);
    end

