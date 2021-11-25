

#include <SoftwareSerial.h>

SoftwareSerial BTserial(7, 8); // RX | TX
  // CONECTA DESDE EL HC-05 TX AL ARDUINO PIN DIGITAL 7. 
  // CONECTA DESDE EL HC-05 RX AL ARDUINO PIN DIGITAL  8  

 
char c = ' '; 
 
void setup()  
{
    Serial.begin(9600); 
    Serial.println("ARDUINO ESTA LISTO");  // para agregar comados AT
    
    Serial.println("TENER PRESENTE EN EL MONITOR SERIAL NL & CR");
 
    //LA VELOCIDAD DE COMUNICACION DEL  HC-05 POR DEFECTO DEL MODO AT ES 38400 EN ALGUNOS CASOS
    BTserial.begin(38400);  
}
 
void loop()
{
 
    
    if (BTserial.available())
    {  
        c = BTserial.read();
        Serial.write(c);
    }
 
    if (Serial.available())
    {
        c =  Serial.read();
        BTserial.write(c);  
    }
 
}
