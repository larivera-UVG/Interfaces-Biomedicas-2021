function [totZC, TotMav, vNew] = metricas(v, vMin, despArriba)
%Rodrigo Ralda - 14813
%2020
%Este codigo es una funcion desarrollada para obtener el ZC y MAV de una serie de datos,
%En caso la señal sufriera un corrimiento, este se puede corregir con el tercer parámetro.
signo = 1;
zc=[];
mav=[];
totZC=0;
TotMav=0;
for i = 1:length(v)
    vNew(i)=v(i)-despArriba;
    
    mav(i)=(abs(vNew(i)));
    
    
%     if abs(vNew(i))>vMin;
%         vNew(i)=vNew(i);
%     else
%         vNew(i)=0;
%     end
    if mav(i)>vMin;
         vNew(i)=vNew(i);
    else
         vNew(i)=0;
    end

    signo = sign(vNew(i))+signo;
   
    %Si es positivo
    if signo == 2;
        signo = 1;
        zc(i)=0;
    elseif signo == 0;
        zc(i)=1;
        totZC=totZC+1;


    elseif signo == -2;
        signo = -1;
        zc(i)=0;

    else
        zc(i)=0;
    end 



  
    
    i = i+1;
    
end
TotMav=mean(mav);
end
