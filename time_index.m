function index = time_index (time,orbit)
%TIME_INDEX Summary of this function goes here
%   Detailed explanation goes here


sat_time = orbit(:,4);
time_start = sat_time(1)/3600;
time_step = (sat_time(2)-sat_time(1))/3600;
time_period = (sat_time(end)-sat_time(1))/3600;

% лента времени
%[time_start,time_step,time_period] = time_init();
index = round(mod(time-time_start,time_period)/time_step)+1;


end

