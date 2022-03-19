
function Latm = power_AtmLoss(El0)

% угол от оси антенны (в градусах)
TetaAtmLoss = [3,5,10,15,20,25,30];

% коэффициент усиления передающей антенны по точкам
Loss = [0.7,0.6,0.4,0.3,0.22,0.16,0.14];

if (El0>30)
    Latm = 0.14;
elseif (El0<3)
    Latm = 0.7;
else
    Latm = interp1(TetaAtmLoss,Loss,El0,'pchip');
end