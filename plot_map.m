function plot_map (map)
% рисование карты

    % настройка отображения карты
    set(map,'Position',[10,50,1200,800]);
    style = hgexport('factorystyle');
    style.Bounds = 'tight';
    hgexport(gcf,'-clipboard',style,'applystyle', true);
    
    %axesm('MapProjection','mercator','MapLatLimit',[0 90])
    load mapdata
    geoshow(ll_world(:,1),ll_world(:,2),'Color','black')
    russia = load('russia2.dat');
    plotm(russia(:,1),russia(:,2),'-k','LineWidth',2);



end

