function time = timeline ()
%TIMELINE Summary of this function goes here
%   Detailed explanation goes here


% лента времени
[time_start,time_step,time_period] = time_init();
time = time_start:time_step:time_period;



end

