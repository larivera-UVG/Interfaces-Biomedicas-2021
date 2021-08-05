function R17Command(R17Obj, command)
    disp('HOST: ' + string(command));
    fprintf(R17Obj, command);
    
    if(strcmp(command, "START"))
        pause(1);
    else
        pause(0.5);
    end
end