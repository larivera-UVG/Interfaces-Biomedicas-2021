function R17Obj = R17Init(COMPort, initSpeed)

    %seriallist % comando para ver puertos seriales disponibles
    R17Obj = serial(COMPort, 'BaudRate', 19200, 'Terminator', 'CR');
    fopen(R17Obj);
    flushinput(R17Obj);
    flushoutput(R17Obj);
    R17Obj.UserData = struct('responseHistory', []);
    R17Obj.BytesAvailableFcnMode = 'terminator';
    R17Obj.BytesAvailableFcn = @readR17Response;
    
    % Restores the pointer to the start of the user memory
    R17Command(R17Obj, "ROBOFORTH"); 
    % Initializes all the drives, starting values for variables such
    % as SPEED and so on
    R17Command(R17Obj, "START");
    R17Command(R17Obj, string(initSpeed) + " SPEED !");
%     R17Command(R17Obj, "CREATE ZERO 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ,");
%     R17Command(R17Obj, "CREATE HOME 0 , 0 , 0 , 0 , 0 , 12000 , 0 , 0 ,");
    R17Command(R17Obj, "ENERGIZE");
    R17Command(R17Obj, 'HOME');
    disp('HOST: R17 initialized.');
end