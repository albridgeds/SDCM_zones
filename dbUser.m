function user = dbUser (name,signal)


switch name
 
    case {'SARPs'}
        user = USER('SARPs',0,5);
        %user.antenna = 0;
        
    case {'Earth'}
        user = USER('Earth',0,5);
        %user.antenna = 0;
        
    case {'Resurs','Resurs-PM','Ðåñóðñ','Ðåñóðñ-ÏÌ'}
        user = USER('Resurs',720000,0);
        %user.antenna = 0;
        
    case {'GLONASS','ÃËÎÍÀÑÑ'}
        user = USER('GLONASS',20000000,0);
        %user.antenna = 0;

end




switch signal
    case 'L1SBAS'
        if strcmp(user.name,'SARPs')
         	user.Pmin = -164;
            user.Plim = -164;
            user.Pmax = -155;
            user.dP = 1.0;
        else
            user.Pmin = -161;
            user.Plim = -161;
            user.Pmax = -153;
            user.dP = 1.0;
        end
    case 'L5KFD'
        user.Pmin = -158;
        user.Plim = -158;
        user.Pmax = -153;
        user.dP = 0.5;
    case 'L3KFD'
        user.Pmin = -158.5;
        user.Plim = -158.5;
        user.Pmax = -155.2;
        user.dP = 0.5;
    case 'L1KFD'
        user.Pmin = -158.5;
        user.Plim = -158.5;
        user.Pmax = -155.2;
        user.dP = 0.5;
        
    case 'L3Sigal'
        user.Pmin = -155.3; % -157.0;
        user.Plim = -155.3;
        user.Pmax = -150.0;
        user.dP = 0.5;
end




