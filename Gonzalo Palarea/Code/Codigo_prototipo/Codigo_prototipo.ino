#include <Servo.h>
#include <CircularBuffer.h>
#include <arduino-timer.h>


Servo servo;
auto timer = timer_create_default(); // create a timer with default settings
bool extender = false;
bool extendido = false;
volatile unsigned int contadorinterrupt = 0;
int lecturauno = 0;
CircularBuffer<float,100> valores;
float voltaje = 0; 
float promedio = 0;

bool ESTADO = false;

void setup() {
  // comunicación serial es utilizada únicamente durante el debugging
  Serial.begin(57600);
  servo.attach(6);
  servo.write(90); // en servos continuos 90 indica parado, 180 maxima velocidad en una direccion y 0 maxima velocidad en otra direccion
  

  //implementación del Timer2 para fijar una frecuencia de muestreo
  
 SREG = (SREG & 0b01111111); //Desabilitar interrupciones
 TIMSK2 = TIMSK2|0b00000001; //Habilita la interrupcion por desbordamiento
 TCCR2B = 0b00000011; //Configura preescala para que FT2 sea de 7812.5Hz. T = 0.000128s, 128 microsegundos
 //0b00000001 = 8MHz
 //0b00000010 = 1MHz
 //0b00000011 = 250kHz
 //0b00000100 = 125kHz
 //0b00000101 = 62500Hz
 //0b00000110 = 31250Hz
 //0b00000111 = 7812.5Hz
 SREG = (SREG & 0b01111111) | 0b10000000; //Habilitar interrupciones //Desabilitar interrupciones

 //nota: una lectura analogica toma aproximadamente 0.0001s o 100 microsegundos
// Si usaramos el interrupt con la frecuencia mínima, aún sería muy rápido. Se implementa un contador de 78 veces,
//para aproximar el período de muestreo a 1 kHZ.

// fuente implementación Timer2: Dr. Rubén E-Marmolejo. Profesor Universidad de Guadalajara, México

//inicializar el buffer circular con ceros

using index_t = decltype(valores)::index_t;
    for (index_t i = 0; i < valores.size(); i++) {
      valores.push(0);
    }





}
void loop() {

  //servo.write(180);
  calcularpromedio();
  Serial.println(promedio);
  timer.tick();
  

 
  if (promedio > 2.9){
    extender = true;
  }
  if (promedio<=2){
    extender = false;
  }

  if ((extender == true)&&(extendido == false)){
    servo.write(180);
    timer.in(400,apagarmotor); 
    extendido = true;
  }

  if ((extender == false)&&(extendido ==true)){
    servo.write(0);
    timer.in(400,apagarmotor);
    extendido = false;
  }
  
}

ISR(TIMER2_OVF_vect){
//    contadorinterrupt++;
//    if(contadorinterrupt > 1) {
      lecturauno = analogRead(A0);
      voltaje = lecturauno * (5.0 / 1023.0);
      valores.push(voltaje);
      contadorinterrupt=0;
      //ESTADO = !ESTADO;
//    }
}

void calcularpromedio(void){
  promedio=0;
  using index_t = decltype(valores)::index_t;
    for (index_t i = 0; i < valores.size(); i++) {
      promedio += valores[i] / valores.size();
    }
}

bool apagarmotor(void *) {
  servo.write(90); //apagarmotor
  return true; // repetir
}
