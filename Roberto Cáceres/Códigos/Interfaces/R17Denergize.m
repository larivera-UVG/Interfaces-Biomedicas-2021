function R17Denergize(R17Obj)
R17Command(R17Obj, "ROBOFORTH");
R17Command(R17Obj, "START");
%     R17Command(R17Obj, "2000 SPEED");
R17Command(R17Obj, "ENERGIZE");
R17Command(R17Obj, "DE-ENERGIZE");
disp('HOST: R17 de-energized.');
end