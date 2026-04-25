# UltraSonic Radar System (HC-SR04 + SG90 + OLED + Processing)

This project is a radar-based object detection system using Arduino Uno. It uses an ultrasonic sensor (HC-SR04) mounted on an SG90 servo motor to scan the surroundings. The detected distance is displayed on a 0.96 inch OLED screen and also visualized in real-time using Processing IDE.

## Features

- Distance measurement using HC-SR04 ultrasonic sensor  
- Rotational scanning using SG90 servo motor  
- Real-time display on OLED (SSD1306 128x64)  
- Radar visualization using Processing IDE  
- Serial communication between Arduino and Processing  
- Suitable for obstacle detection and radar-based systems  

## Components Required

- Arduino Uno  
- HC-SR04 Ultrasonic Sensor  
- SG90 Servo Motor  
- 0.96" OLED Display (SSD1306, I2C)  
- Breadboard  
- Jumper wires  
- USB cable  

## Circuit Connections

### HC-SR04 Ultrasonic Sensor
- VCC  -> 5V  
- GND  -> GND  
- TRIG -> Digital Pin 10  
- ECHO -> Digital Pin 11  

### SG90 Servo Motor
- Red   -> 5V  
- Brown -> GND  
- Orange -> Digital Pin 9  

### OLED Display (SSD1306 I2C)
- VCC  -> 5V  
- GND  -> GND  
- SDA  -> A4  
- SCL  -> A5  

## Working

- The servo motor rotates from 0 to 180 degrees, scanning the area.  
- At each angle, the HC-SR04 sensor measures the distance to nearby objects.  
- The measured distance is displayed on the OLED screen.  
- Data is sent via serial communication to Processing IDE.  
- Processing creates a radar-style visualization showing object position and distance.  
- This system simulates a real radar used in detection and monitoring systems.  

## Project Images

<table align="center">
  <tr>
    <td align="center">
      <img src="https://github.com/iprince10/Arduino-Uno/raw/main/UltraSonic_Radar_System/UltraSonic_Radar_System_Image1.jpeg" height="250">
    </td>
    <td align="center">
      <img src="https://github.com/iprince10/Arduino-Uno/raw/main/UltraSonic_Radar_System/UltraSonic_Radar_System_Image2.jpeg" height="250">
    </td>
  </tr>
  <tr>
    <td align="center">
      <img src="https://github.com/iprince10/Arduino-Uno/raw/main/UltraSonic_Radar_System/UltraSonic_Radar_System_Image3.jpeg" height="250">
    </td>
    <td align="center">
      <img src="https://github.com/iprince10/Arduino-Uno/raw/main/UltraSonic_Radar_System/UltraSonic_Radar_System_Graph.png" height="250">
    </td>
  </tr>
</table>

## Owner and Licence
Made by **Prince Jha** . This project is free source and open for all :)
