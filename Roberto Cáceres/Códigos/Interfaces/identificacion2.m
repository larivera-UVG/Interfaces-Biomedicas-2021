%% FUNCIÓN PARA DETERMINAR EL THRESHOLD DE INICIO DE ACTIVIDAD
function th = identificacion2(pserial,t)

    canales = 2;               %no. canales
    data_s = zeros(canales,t); %array para almacenar datos del puerto serial
    cont_s = 1;                %contador no. muestras sin mov.
    
    promp = 'Presiona 0 + enter para inciar';
    x = input(promp);                          %Recibir dato del usuario para inciar
    fwrite(pserial,107,'uint8');               %Iniciar el envío de datos desde arduino
    
    while cont_s < (t + 1)
        for n = 1:canales
            v = fscanf(pserial,'%d')*5/1024;              %leer datos puerto serial
            if(isempty(v) == 1)
                v = fscanf(pserial,'%d')*5/1024;
            end
            data_s(n,cont_s) = v(1);                      %almacenar datos         
        end
        cont_s = cont_s + 1;   
    end
    
    v1 = max(abs(data_s(1,:)));      %Determinar el threshold
    v2 = max(abs(data_s(2,:)));
    
    th = max([v1,v2]);
    
    end