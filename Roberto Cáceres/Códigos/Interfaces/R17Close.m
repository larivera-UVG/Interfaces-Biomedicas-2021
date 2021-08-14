function R17Close(R17Obj)
R17Command(R17Obj, 'HOME');
R17Denergize(R17Obj);
fclose(R17Obj);
delete(R17Obj);
clear R17Obj;
disp('HOST: R17 closed.');
end