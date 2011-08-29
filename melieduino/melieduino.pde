/*
  Melie Duino hello world
 */

void setup() {
  // initialize serial communication:
  Serial.begin(9600); 
  // initialize the LED pins:
  pinMode(13, OUTPUT);
}

void loop() {
  // read the sensor:
  if (Serial.available() > 0) {
    unsigned char inChar = Serial.read();
    
    // debug
    Serial.println(inChar);
    switch (inChar) {
    case 'a':    
      digitalWrite(13, HIGH);
      break;
    case 'b':    
      digitalWrite(13, LOW);
      break;
    }
  }
}

