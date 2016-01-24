int nDots = 1000;
int nFrames = 80;
boolean captureFrames = true;

float phase = 0.0;
float phaseInc = 1 / float(nFrames);
Dots dots;
PVector center;

PrintWriter pw;
String filename = "vectorTest.csv";

class Dots extends ArrayList<Dot> {
}


class Dot extends PVector {
  color c = color(255);
  float phaseOffset = 0.0;
  PVector phasePosition;
  float theDistance;

  Dot(float x, float y) {
    super(x, y);
    phasePosition = new PVector();
  }

  void update() {
    float a = atan2(y - center.y, x - center.x); //<>// //<>// //<>//
    PVector p = PVector.fromAngle(a);
    float d = dist(new PVector(x, y), center);
    float offset = sin((phase + phaseOffset) * TAU) * d / 5.0;
    p.mult(offset);
    p.add(new PVector(x, y));
    theDistance = d;
    phasePosition = p;
  }

  void display() {
    pushStyle();
    noFill();
    fill(c);
    float s = theDistance / 100.0 + 1;
    //ellipse(phasePosition.x, phasePosition.y, s, s);
    popStyle();
  }
}


void setup() {
  size(500, 500, P2D);
  pw = createWriter(filename);
  center = new PVector(width / 2.0, height / 2.0);
  dots = new Dots();

  float v = 1.0;
  for (int i = 0; i < nDots; i++) {
    //Dot dot = new Dot(random(width), random(height));
    PVector p = PVector.fromAngle(i / float(nDots) * TAU * 16);
    //p.mult(random(0.707 * width * 0.5));
    p.mult(v);
    v *= 1.006;
    p.add(center);
    Dot dot = new Dot(p.x, p.y);
    color c = color(255, 80, 180) ;
    if (random(1) < 0.5) {
      c = color(255, 128, 0);
    }
    dot.c = c;
    dot.phaseOffset = random(i / float(nDots)); 
    dots.add(dot);
  }
}

void draw() {
  pw.print(frameCount);
  background(0);

  for (Dot dot : dots) {
    dot.update();
    dot.display();
  }

  int lineCount = 0;
  pushStyle();
  blendMode(ADD);
  for (int i = 0; i < nDots; i++) {
    Dot dot1 = dots.get(i);
    Dot dot2 = new Dot(0, 0);
    float theLength = 100000;
    for (int j = 0; j < nDots; j++) {
      if (i != j) {
        Dot dotTemp = dots.get(j);
        float d1 = dist(dot1.phasePosition.x, dot1.phasePosition.y, dotTemp.phasePosition.x, dotTemp.phasePosition.y);
        if (d1 < theLength) {
          theLength = d1;
          dot2 = dotTemp;
        }
      }
    }
    strokeWeight(1.5);
    //stroke(dot1.c, map(dist(dot1.x, dot1.y, center.x, center.y), 0, width * 0.707, 64, 212));
    //    stroke(color(255), map(dist(dot1.x, dot1.y, center.x, center.y), 0, width * 0.707, 180, 255));
    stroke(255);
    line(dot1.phasePosition.x, dot1.phasePosition.y, dot2.phasePosition.x, dot2.phasePosition.y);
    printPoints(dot1.phasePosition.x, dot1.phasePosition.y, dot2.phasePosition.x, dot2.phasePosition.y);
    lineCount++;
  }
  println(lineCount);
  popStyle();

  pw.println();
  phase += phaseInc;
  phase -= int(phase);

  //if (captureFrames) {
  //  //    saveFrame("./gif/f#####.gif");
  //  if (frameCount == nFrames - 1) {
  //    exit();
  //  }
  //}
}

void printPoints(float x1, float y1, float x2, float y2) {
  pw.print("," + x1);
  pw.print("," + y1);
  pw.print("," + x2);
  pw.print("," + y2);
}