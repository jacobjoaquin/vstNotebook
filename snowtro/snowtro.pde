Vst vst;
Snow snow;
Wind wind;

void settings() {
  size(450, 550, P2D);
  pixelDensity(displayDensity());
}

void setup() {
  frameRate(50);
  vst = new Vst(this, createSerial());
  vst.colorBright = color(220, 220, 255);
  vst.colorNormal = color(vst.colorBright, 96);
  vst.colorTransit = color(255, 0, 0, 180);
  //vst.displayTransit = true;
  wind = new Wind();
  snow = new Snow();
  snow.init();
}

void draw() {
  background(0);
  wind.update();
  snow.update();
  snow.display();
  vst.display();
  println(snow.size());
}


void push() {
  pushMatrix();
  pushStyle();
}

void pop() {
  popStyle();
  popMatrix();
}