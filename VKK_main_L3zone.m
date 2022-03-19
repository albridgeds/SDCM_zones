clc
clear


% сигнал (L1SBAS (Луч-5А,5Б,5В), L1SDCM/L5KFD/L3KFD/L1KFD (новые КА) или L3Sigal (одна квадратура, повышенные требовани к уровню) или L1GLO/L2GLO/L3GLO)
transponder = dbTransponder('L3Sigal');       

% потребитель (SARPs - на выходе антены, определенной в SARPs / Earth - на выходе антенны 0 дБ / КА на определенной высоте)
user = dbUser('Earth', transponder.signal);  


% интересующее время
time = 0;

% спутники
satelite = create_sat_array('5M1','5M2','5M3');     

% цвета
sat_color = create_str_array('blue');
user_color = create_str_array('red');

% расчет энергетики на линии Космос-Земля
plotm_power(time,satelite,transponder,user,1);

% мощность сигнала в зависимости от угла возвышения КА
plot_PowerofEl(time,satelite,transponder,user)