function readR17Response(src, evt)
    response = fgetl(src);
    %response = fscanf(src);
    disp('R17: ' + string(response));
    src.UserData.responseHistory = [src.UserData.responseHistory; string(response)];
end
