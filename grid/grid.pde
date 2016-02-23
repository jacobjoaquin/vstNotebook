int nFrames = 20;
float phase = 0;
float phaseInc = 1.0 / nFrames;
float maxDepth = -4000;
float tileSize = 100;
float sideLength = 4000;

Vst vst;

void settings() {
  size(450, 550, P3D);
  pixelDensity(displayDensity());
}

void setup() {
  frameRate(25);
  vst = new Vst(this, createSerial());
  vst.colorBright = color(220, 220, 255);
  vst.colorNormal = color(vst.colorBright, 128);
  vst.colorTransit = color(255, 0, 0, 64);
  //vst.displayTransit = true;
  blendMode(ADD);
}


void draw() {
  background(0);

  // Tower and Horizon
  stroke(255);
  vst.line(255, -5000, maxDepth, 255, height, maxDepth);
  vst.line(245, -5000, maxDepth, 245, height, maxDepth);
  vst.line(-sideLength, height, maxDepth, sideLength, height, maxDepth);

  // Grid
  stroke(127);
  for (int i = (int) -sideLength; i <= sideLength; i += tileSize) { 
    vst.line(i, height, 0, i, height, maxDepth);
  }
  for (int i = 0; i >= maxDepth; i -= tileSize) {
    float offset = i + phase * tileSize;
    vst.line(-sideLength, height, offset, sideLength, height, offset);
  }

  // Send to Vst
  vst.display();

  // Update phasor
  phase += phaseInc;  
  phase -= (int) phase;
}