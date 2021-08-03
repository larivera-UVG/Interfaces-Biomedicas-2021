function iK = R17iKine(R17Obj, p)
    % To return to cartesian mode
    R17Command(R17Obj, "CARTESIAN");
    
    x = p(1);
    y = p(2);
    z = p(3);
    roll = p(4);
    pitch = p(5);
    yaw = p(6);
    
%     R17Command(R17Obj, "WRIST ROLL " + string(roll));
%     R17Command(R17Obj, "WRIST PITCH " + string(pitch));
%     R17Command(R17Obj, "WRIST YAW " + string(yaw));
    R17Command(R17Obj, string(x) + " " + string(y) + " " + string(z) +...
                                " MOVETO");
    R17Command(R17Obj, "WHERE");
    
    temps = char(R17Obj.UserData.responseHistory(end-2));
    iK = str2num(temps(2:end))';

end