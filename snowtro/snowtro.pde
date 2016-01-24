Vst vst;
Wind wind;
Snow snow;
SnowLine snowLine;

void settings() {
  size(450, 550, P2D);
  pixelDensity(displayDensity());
}

void setup() {
  //frameRate(25);
  vst = new Vst(this, createSerial());
  vst.colorBright = color(220, 220, 255);
  vst.colorNormal = color(vst.colorBright, 96);
  vst.colorTransit = color(255, 0, 0, 64);
  //vst.displayTransit = true;

  wind = new Wind();
  snow = new Snow();
  snowLine = new SnowLine();
  snow.init();
}

void draw() {
  background(0);
  wind.update();
  snow.update();
  snowLine.update();
  snow.display();
  snowLine.display();
  vst.display();
  //println(snowLine.positions.size());
  println(snow.size() + snowLine.positions.size());
}

void push() {
  pushMatrix();
  pushStyle();
}

void pop() {
  popStyle();
  popMatrix();
}