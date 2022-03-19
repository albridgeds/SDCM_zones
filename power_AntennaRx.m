% êîıôôèöèåíò óñèëåíèÿ ïğèåìíîé àíòåííû îò óãëà ìåñòà

function Grec = power_AntennaRx(El)

% óãîë îò îñè àíòåííû (â ãğàäóñàõ)
TetaAntRec = [0,5,10,15];

% êîıôôèöèåíò óñèëåíèÿ ïåğåäàşùåé àíòåííû ïî òî÷êàì
GAntRec = [-7,-5.5,-4,-2.5];

if ((El>=15) && (El<=165)) 
    Grec=-2.5;
else
   Grec = interp1(TetaAntRec,GAntRec,El,'pchip');
end
