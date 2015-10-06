boolean captureFrames = true;
int nFrames = 200;
float phase = 0.0;
float phaseInc = 1 / float(nFrames);
PFont theFont;
PGraphics textLayer;
String filename = "fontTest.csv";
VectorFrame vf;

void layerCopy(PGraphics source, PGraphics destination) {
  destination.copy(source, 0, 0, width, height, 0, 0, width, height);
}

PGraphics createTextLayer() {
  PGraphics pg = createGraphics(width, height);
  pg.beginDraw();
  pg.clear();
  pg.textFont(theFont);
  pg.textAlign(CENTER, CENTER);
  pg.text("V.ST", width / 2.0, height / 2.0);
  pg.endDraw();
  return pg;
}

void setup() {
  size(500, 500);
  frameRate(50);
  vf = new VectorFrame(filename);
  vf.captureMode = captureFrames;
//  theFont = createFont("Futura", 220);
  theFont = createFont("Superclarendon-BoldItalic", 160);
}

void draw() {
  background(0);

  // Create text mask layer
  textLayer = createTextLayer();
  textLayer.beginDraw();
  layerCopy(textLayer, g);

  // Generate animation
  vf.beginFrame();
  stroke(128, 180, 255);
  noFill();
  loadPixels();
  float lineDistance = (int) (phase * 20 + 5);
  lineDistance = map(sin(phase * TAU), -1, 1, 5, 50);
  float start = map(sin(phase * TAU * 4), -1, 1, 0, 1) * lineDistance;

  for (int y = 0; y < height; y += lineDistance) {
    boolean inShape = false;
    boolean findEnd = false;
    PVector p1 = new PVector();
    PVector p2 = new PVector();

    for (int x = 0; x < width; x++) {
      color p = textLayer.pixels[x + y * width];
      inShape = alpha(p) >= 128;

      if (inShape && !findEnd) {
        p1 = new PVector(x, y);
        findEnd = true;
      } else if (!inShape && findEnd) {
        p2 = new PVector(x, y);
        vf.vLine(p1, p2);
        // draw here
        findEnd = false;
      }
    }
  }

  for (int x = 0; x < width; x += lineDistance) {
    boolean inShape = false;
    boolean findEnd = false;
    PVector p1 = new PVector();
    PVector p2 = new PVector();

    for (int y = 0; y < height; y++) {
      color p = textLayer.pixels[x + y * width];
      inShape = alpha(p) >= 128;

      if (inShape && !findEnd) {
        p1 = new PVector(x, y);
        findEnd = true;
      } else if (!inShape && findEnd) {
        p2 = new PVector(x, y);
        vf.vLine(p1, p2);
        // draw here
        findEnd = false;
      }
    }
  }


  textLayer.endDraw();  
  vf.endFrame();
  
  phase += phaseInc;
  phase -= (int) phase;

  if (captureFrames) {
    if (frameCount == nFrames) {
      vf.end();
      exit();
    }
  }
}

