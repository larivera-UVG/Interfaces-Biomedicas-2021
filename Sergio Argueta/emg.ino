void setup() {
  Serial.begin(2000000);
}

void loop() {
  float RawValue = analogRead(A0);
  float sensorValue = analogRead(A1);
  float millivolt = (sensorValue/1023)*5;


  Serial.print ("Voltage: ");
  
  Serial.print ("Raw Value: ");
  Serial.println (RawValue);
  delay(1);
}
