% ����������� �������� �������� ������� �� ���� �����

function Grec = power_AntennaRx(El)

% ���� �� ��� ������� (� ��������)
TetaAntRec = [0,5,10,15];

% ����������� �������� ���������� ������� �� ������
GAntRec = [-7,-5.5,-4,-2.5];

if ((El>=15) && (El<=165)) 
    Grec=-2.5;
else
   Grec = interp1(TetaAntRec,GAntRec,El,'pchip');
end
