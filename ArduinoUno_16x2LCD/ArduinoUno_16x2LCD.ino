#include <Wire.h>
#include <LiquidCrystal_I2C.h>

// Most common I2C address is 0x27, some modules use 0x3F
LiquidCrystal_I2C lcd(0x27, 16, 2);

void setup() {
  lcd.init();
  lcd.backlight();
  lcd.setCursor(0, 0);
  lcd.print("Hii Prince");
}

void loop() {}
