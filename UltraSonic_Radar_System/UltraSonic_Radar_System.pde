import processing.serial.*;

Serial port;

float[] distances = new float[181];
int currentAngle = 0;
int maxRange = 200;  // updated to 200cm

void setup() {
  fullScreen();  // fullscreen!
  
  port = new Serial(this, "COM12", 9600);
  port.bufferUntil('\n');
  
  for (int i = 0; i <= 180; i++) {
    distances[i] = 0;
  }
}

void draw() {
  background(0);
  translate(width / 2, height - 60);
  
  drawGrid();
  drawTrail();
  drawSweepLine();
  drawBlips();
  drawLabels();
}

void drawGrid() {
  int[] rings = {50, 100, 150, 200};
  for (int r : rings) {
    float radius = map(r, 0, maxRange, 0, height - 100);
    stroke(0, 80, 0);
    strokeWeight(1);
    noFill();
    arc(0, 0, radius * 2, radius * 2, PI, TWO_PI);
    fill(0, 150, 0);
    noStroke();
    textSize(12);
    text(r + "cm", 5, -radius + 4);
  }

  stroke(0, 60, 0);
  strokeWeight(1);
  for (int a = 0; a <= 180; a += 30) {
    float rad = radians(a);
    float maxR = height - 100;
    float x = maxR * cos(PI - rad);
    float y = -maxR * sin(PI - rad);
    line(0, 0, x, y);
    fill(0, 180, 0);
    noStroke();
    textSize(11);
    text(a + "°", x * 1.05, y * 1.05);
  }
}

void drawTrail() {
  for (int a = 0; a <= 180; a++) {
    float d = distances[a];
    if (d > 0) {
      float radius = map(d, 0, maxRange, 0, height - 100);
      float rad = radians(a);
      float x = radius * cos(PI - rad);
      float y = -radius * sin(PI - rad);

      int ageDiff = abs(a - currentAngle);
      if (ageDiff > 90) ageDiff = 90;
      float alpha = map(ageDiff, 0, 90, 255, 20);

      stroke(0, 255, 70, alpha);
      strokeWeight(3);
      point(x, y);

      if (ageDiff < 10) {
        noFill();
        stroke(0, 255, 70, alpha * 0.4);
        strokeWeight(1);
        ellipse(x, y, 12, 12);
      }
    }
  }
}

void drawSweepLine() {
  float rad = radians(currentAngle);
  float maxR = height - 100;

  for (int i = 0; i < 20; i++) {
    float t = i / 20.0;
    stroke(0, 255, 70, 255 * (1 - t));
    strokeWeight(1.5);
    float x1 = (maxR * t) * cos(PI - rad);
    float y1 = -(maxR * t) * sin(PI - rad);
    float x2 = (maxR * (t + 0.05)) * cos(PI - rad);
    float y2 = -(maxR * (t + 0.05)) * sin(PI - rad);
    line(x1, y1, x2, y2);
  }
}

void drawBlips() {
  float d = distances[currentAngle];
  if (d > 0) {
    float radius = map(d, 0, maxRange, 0, height - 100);
    float rad = radians(currentAngle);
    float x = radius * cos(PI - rad);
    float y = -radius * sin(PI - rad);

    noFill();
    stroke(255, 50, 50, 120);
    strokeWeight(1);
    ellipse(x, y, 22, 22);

    fill(255, 80, 80);
    noStroke();
    ellipse(x, y, 10, 10);
  }
}

void drawLabels() {
  resetMatrix();
  fill(0, 220, 70);
  textSize(16);
  text("SONAR RADAR", 20, 30);
  textSize(13);
  text("Range: 0 - " + maxRange + " cm", 20, 52);
  text("Angle: " + currentAngle + "°", 20, 70);

  float d = distances[currentAngle];
  if (d > 0) {
    fill(255, 80, 80);
    textSize(14);
    text("OBJECT: " + d + " cm  @  " + currentAngle + "°", 20, 90);
  } else {
    fill(0, 150, 50);
    textSize(13);
    text("No object", 20, 90);
  }
}

void serialEvent(Serial p) {
  String line = p.readStringUntil('\n');
  if (line == null) return;
  line = trim(line);

  String[] parts = split(line, ',');
  if (parts.length == 2) {
    try {
      int angle = int(parts[0]);
      float dist = float(parts[1]);
      if (angle >= 0 && angle <= 180) {
        distances[angle] = dist;
        currentAngle = angle;
      }
    } catch (Exception e) {}
  }
}
