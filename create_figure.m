function map = create_figure (number)
%CREATE_FIGURE Summary of this function goes here
%   Detailed explanation goes here

    map = figure(number);
    clf
    axesm('MapProjection','eqdcylin','Frame','on','Grid','on','MeridianLabel','on','ParallelLabel','on');



end

