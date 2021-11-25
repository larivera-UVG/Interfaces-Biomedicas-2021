function fK = R17fKine(R17Obj, q)
    % To return to joint mode
    R17Command(R17Obj, "JOINT");
    
    
    q = [q(2:6); q(1)];
    D = (180/pi) * diag([10000/90, (17800/90), (9000/90), (3000/90), ...
        (3000/90), (10000/0.5)*(pi/180)]); % ¿o 12000/1 en la última?
    q = round(D*q);
    
    % b = [15000; 22000; 15000; 6000; 6000; 12000];
    
    % Joint bounds (degrees in first 5, meters in career):
    % WAIST     --> (-180,180)
    % SHOULDER  --> (-142,142)
    % ELBOW     --> (-163,163)
    % HAND      --> (-180,180)
    % WRIST     --> (-180,180)
    % CAREER    --> (-0.6,0.6)
    b = [20000; 28084; 16300; 6000; 6000; 12000];
    out_of_bounds = sum( (abs(q) - b) > 0 );
    
    if(out_of_bounds > 0)
        disp('HOST: ' + string(out_of_bounds) + ' parameters in the configuration are out of bounds.');
        fK = 0;
        return;
    else
        s = 'CREATE DCFG '; %This is creating a POSITION
        for i = 1:6
            s = s + string(q(i)) + ' , ';
        end
        s = s + ' 0 , 0 ,';
        %s = s + 'MOVETO';
        R17Command(R17Obj, s);
        R17Command(R17Obj, "DCFG GOTO");
        pause(3);
    end
    
    R17Command(R17Obj, "CARTESIAN");%pelle
    R17Command(R17Obj, "WHERE");%pelle
    %R17Command(R17Obj, "COMPUTE CARTWHERE"); % alternative option

    temps = char(R17Obj.UserData.responseHistory(end-2));
    fK = str2num(temps(2:end))';
    fK = diag([1/1000, 1/1000, 1/1000, pi/180, pi/180, 1/1000]) * fK;
end