# UltraSonic Radar System

A radar-based object detection system built on Arduino Uno. An HC-SR04 ultrasonic sensor mounted on an SG90 servo motor continuously scans the surroundings, reporting distance measurements to a 0.96" OLED display and streaming data over serial to a Processing IDE sketch that renders a live radar visualization.

---

## Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Components Required](#components-required)
- [Circuit Connections](#circuit-connections)
- [Working Principle](#working-principle)
- [Software Setup](#software-setup)
- [Project Images](#project-images)
- [Applications](#applications)
- [License](#license)

---

## Overview

This project simulates the behaviour of a real-world radar system. The servo sweeps the ultrasonic sensor across a 180-degree arc. At every degree of rotation the sensor fires a pulse, measures the round-trip echo time, and converts it to a distance in centimetres. That distance is shown locally on the OLED and simultaneously transmitted over UART to a PC running a Processing sketch, which draws the classic green-on-black sweeping radar display in real time.

---

## Features

- 180-degree rotational scanning via SG90 servo motor
- Distance measurement up to approximately 200 cm using HC-SR04
- Real-time distance readout on SSD1306 OLED (128 x 64, I2C)
- Live radar-style visualization in Processing IDE
- Serial communication between Arduino and host PC
- Compact, breadboard-friendly circuit
- Clean serial data format for easy extension or logging

---

## Components Required

| Component | Quantity |
|---|---|
| Arduino Uno | 1 |
| HC-SR04 Ultrasonic Sensor | 1 |
| SG90 Servo Motor | 1 |
| 0.96" OLED Display (SSD1306, I2C) | 1 |
| Breadboard | 2 |
| Jumper Wires | As required |
| USB Cable (Type-A to Type-B) | 1 |

---

## Circuit Connections

### HC-SR04 Ultrasonic Sensor

| HC-SR04 Pin | Arduino Pin |
|---|---|
| VCC | 5V |
| GND | GND |
| TRIG | Digital Pin 10 |
| ECHO | Digital Pin 11 |

### SG90 Servo Motor

| Servo Wire | Arduino Pin |
|---|---|
| Red (Power) | 5V |
| Brown (Ground) | GND |
| Orange (Signal) | Digital Pin 9 |

### OLED Display (SSD1306, I2C)

| OLED Pin | Arduino Pin |
|---|---|
| VCC | 5V |
| GND | GND |
| SDA | A4 |
| SCL | A5 |

---

## Working Principle

1. **Scanning** — The SG90 servo sweeps from 0 to 180 degrees and back in a continuous loop. At each degree position the Arduino pauses briefly to allow the sensor to stabilize.

2. **Distance Measurement** — The HC-SR04 is triggered by a 10-microsecond HIGH pulse on the TRIG pin. The sensor emits eight 40 kHz ultrasonic pulses and pulls the ECHO pin HIGH for a duration proportional to the round-trip travel time. The Arduino measures this pulse width using `pulseIn()` and converts it to distance using the formula:

   ```
   Distance (cm) = Echo pulse width (us) / 58
   ```

3. **OLED Display** — The current angle and measured distance are formatted and written to the SSD1306 over I2C using the Adafruit SSD1306 and GFX libraries. The display refreshes with every new measurement.

4. **Serial Transmission** — Each reading is sent to the PC as a comma-separated string in the format `angle,distance` terminated by a newline. The baud rate is 9600 bps.

5. **Processing Visualization** — The Processing sketch reads the serial stream, parses angle and distance values, and renders a radar display: concentric range rings, a rotating sweep line, and blips at detected object positions. Older blips fade over time to produce the characteristic radar persistence effect.

---

## Software Setup

### Arduino Side

1. Install the following libraries via the Arduino Library Manager:
   - `Adafruit SSD1306`
   - `Adafruit GFX Library`
   - `Servo` (bundled with the Arduino IDE)
2. Open the Arduino sketch from this folder, select **Board: Arduino Uno** and the correct COM port, and upload.

### Processing Side

1. Download and install [Processing IDE](https://processing.org/download).
2. Install the `Serial` library from **Sketch > Import Library > Add Library**.
3. Open the Processing sketch from this folder.
4. Update the serial port string in the sketch to match the port your Arduino is connected to (e.g., `"COM12"` on Windows).
5. Run the sketch. The radar window will open and begin updating as soon as the Arduino starts streaming data.

> Note: Close the Arduino IDE Serial Monitor before running the Processing sketch, as both cannot use the same serial port simultaneously.

---

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

---

## License

Made by **Prince Jha**. This project is open source and free for all :)
