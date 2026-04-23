#include <Servo.h>

#include <Servo.h>

Servo myServo;

void setup() {
  myServo.attach(9);  // Signal wire connected to pin 9
  Serial.begin(9600);
  Serial.println("Servo Test Started");
}

void loop() {
  // Sweep from 0° to 180°
  for (int angle = 0; angle <= 180; angle += 1) {
    myServo.write(angle);
    delay(15);
  }

  Serial.println("Reached 180°");
  delay(500);

  // Sweep back from 180° to 0°
  for (int angle = 180; angle >= 0; angle -= 1) {
    myServo.write(angle);
    delay(15);
  }

  Serial.println("Reached 0°");
  delay(500);
}