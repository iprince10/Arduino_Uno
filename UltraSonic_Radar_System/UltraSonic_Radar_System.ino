#include <Servo.h>
#include <Wire.h>
#include <Adafruit_GFX.h>
#include <Adafruit_SSD1306.h>

// OLED setup
#define SCREEN_WIDTH 128
#define SCREEN_HEIGHT 64
#define OLED_RESET    -1  // no reset pin
Adafruit_SSD1306 display(SCREEN_WIDTH, SCREEN_HEIGHT, &Wire, OLED_RESET);

Servo radarServo;

const int TRIG_PIN   = 6;
const int ECHO_PIN   = 7;
const int SERVO_PIN  = 9;
const int MAX_RANGE  = 200;
const int SCAN_DELAY = 30;

long getDistance() {
  digitalWrite(TRIG_PIN, LOW);
  delayMicroseconds(2);
  digitalWrite(TRIG_PIN, HIGH);
  delayMicroseconds(10);
  digitalWrite(TRIG_PIN, LOW);

  long duration = pulseIn(ECHO_PIN, HIGH, 30000);
  if (duration == 0) return -1;
  long cm = duration / 58;
  return (cm > MAX_RANGE) ? -1 : cm;
}

void updateOLED(int angle, long distance) {
  display.clearDisplay();

  // Top header bar
  display.fillRect(0, 0, 128, 14, WHITE);
  display.setTextColor(BLACK);
  display.setTextSize(1);
  display.setCursor(28, 3);
  display.print("SONAR RADAR");

  display.setTextColor(WHITE);

  if (distance <= 0) {
    display.setTextSize(1);
    display.setCursor(10, 22);
    display.print("Status: Scanning...");

    display.setCursor(18, 54);
    display.print("No Object Detected");

  } else {
    display.setTextSize(1);
    display.setCursor(10, 20);
    display.print("! OBJECT DETECTED !");

    display.drawLine(0, 30, 128, 30, WHITE);

    display.setCursor(4, 35);
    display.print("Dist  : ");
    display.print(distance);
    display.print(" cm");

    display.setCursor(4, 48);
    display.print("Angle : ");
    display.print(angle);
    display.print(" deg");
  }

  display.display();
}

void scanAndSend(int angle) {
  radarServo.write(angle);
  delay(SCAN_DELAY);

  long dist = getDistance();

  // Send to Processing via Serial
  Serial.print(angle);
  Serial.print(",");
  Serial.println(dist == -1 ? 0 : dist);

  // Update OLED independently
  updateOLED(angle, dist);
}

void setup() {
  pinMode(TRIG_PIN, OUTPUT);
  pinMode(ECHO_PIN, INPUT);
  radarServo.attach(SERVO_PIN);
  Serial.begin(9600);

  // Init OLED
  if (!display.begin(SSD1306_SWITCHCAPVCC, 0x3C)) {
    Serial.println("OLED not found!");
    while (true); // halt if OLED missing
  }

  display.clearDisplay();
  display.setTextColor(WHITE);
  display.setTextSize(1);
  display.setCursor(20, 28);
  display.print("Initializing...");
  display.display();
  delay(1500);

  radarServo.write(0);
  delay(1000);
}

void loop() {
  for (int angle = 0; angle <= 180; angle++) {
    scanAndSend(angle);
  }
  for (int angle = 180; angle >= 0; angle--) {
    scanAndSend(angle);
  }
}