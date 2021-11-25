#include <SoftwareSerial.h>
SoftwareSerial mySerial(7, 8);
void setup() {
  mySerial.begin(9600);
  mySerial.println("conexion exitosa");
  Serial.begin(9600);
  Serial.println("conexion exitosa");
}
void loop() {
  // obtener datos del sensor
  uint16_t RawValue = analogRead(A0);
  // imprimir datos
  Serial.println(RawValue);
  mySerial.println(RawValue);
  delay(1);
}
