%% Prueba serial
COMPort = 'COM4';

servo = serial(COMPort, 'BaudRate', 9600, 'Terminator', 'CR');
fopen(servo);
flushinput(servo);
flushoutput(servo);

%%
fclose(servo);
delete(servo);
clear servo;