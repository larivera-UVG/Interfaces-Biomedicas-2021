function R17CreateRoute(R17Obj, RouteMatrix)

% Set the R17 in Cartesian mode
R17Command(R17Obj, "CARTESIAN");
% Create de route called R1
R17Command(R17Obj, "ROUTE R1");

% Reserve lines for the route
lines = size(RouteMatrix,1);
R17Command(R17, string(lines) + " RESERVE");

% Extract the coordinates of each position, move the R17, learn the  
% position and append it to the routine R1.
for i = 1:lines
    x = 10*RouteMatrix(i,1);
    y = 10*RouteMatrix(i,2);
    z = 10*RouteMatrix(i,3);
    R17Command(R17, string(x) + " " + string(y) + " " + string(z) +...
        " MOVETO");
    pause(5);
    R17Command(R17, "LEARN");
end

% Return to the HOME position
pause(5);
R17Command(R17, "HOME");

end