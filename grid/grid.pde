int nFrames = 10;
float phase = 0;
float phaseInc = 1.0 / nFrames;

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
  blendMode(ADD);
  //vst.displayTransit = true;
  stroke(127);
}

float maxDepth = -4000;
float tileSize = 100;
float sideLength = 4000;

void draw() {
  background(0);

  stroke(255);
  line(260, -5000, maxDepth, 260, height, maxDepth);
  line(240, -5000, maxDepth, 240, height, maxDepth);
  line(-sideLength, height, maxDepth, sideLength, height, maxDepth);

  stroke(127);
  pushMatrix();
  //translate(tileSize / 4.0, 0);
  for (int i = (int) -sideLength; i <= sideLength; i += tileSize) { 
   vst.line(i, height, 0, i, height, maxDepth);
  }

  for (int i = 0; i >= maxDepth; i -= tileSize) {
    float offset = i + phase * 100;
   vst.line(-sideLength, height, offset, sideLength, height, offset);
  }
  popMatrix();

  vst.display();
  phase += phaseInc;  
  phase -= (int) phase;
}