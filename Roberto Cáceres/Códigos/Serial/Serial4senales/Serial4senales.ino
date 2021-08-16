#include <TimerOne.h>

int analogPin1 = A0;  
int analogPin2 = A1; 
int T=1e-3;
int v=0;
int v2=0;

void setup(void)
{
  pinMode(analogPin1, INPUT);
  pinMode(analogPin2, INPUT);
  Serial.begin(115200);
  Timer1.initialize(800);         // Dispara cada 1 ms  
}

void sendSerial()
{   
   v = analogRead(analogPin1);  
   v2 = analogRead(analogPin2); 

   Serial.println(v);
   Serial.println(v2);
        
}

void loop(void)
{
  if (Serial.available() > 0) {
  int input = Serial.read();
    if(input == 107) { 
      Timer1.attachInterrupt(sendSerial); // Activa la interrupcion
    }
  } 
}
