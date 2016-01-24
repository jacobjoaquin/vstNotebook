class Snow extends DisplayableList {
  void init() {
    for (int i = 0; i < height * 8; i++) {
      update();
    }
  }
  
  void update() {
    if (random(1.0) < 0.5) {
      createFlake();
    }
    super.update();
  }
  
  void createFlake() {
    this.add(new Flake());
  }
}

class Flake extends DisplayableBase {
  PVector position;
  PVector lastPosition;
  PVector velocity;
  float flutter = 2;
  float r;
  color c;
  
  Flake() {
    super();
    position = new PVector(random(width), 0);
    velocity = PVector.fromAngle(HALF_PI);
    r = random(0.125, 1);
    velocity.y *= r;
    flutter *= r;
    c = color(r > 0.6 ? 255 : 127);
  }
  
  void update() {
    super.update();
    lastPosition = position.copy();
    position.add(velocity);
    PVector w = wind.velocity.copy();
    //w.y *= r;
    //w.x *= w;
    w.mult(r);
    w.x += random(-flutter, flutter);
    position.add(w);

    if (position.y >= height) {
      complete();
    }
    
    if (position.x < 0) {
      position.x += width;
      lastPosition.x += width;
    }
    if (position.x >= width - 1) {
      position.x -= width;
      lastPosition.x -= width;
    }
  }
  
  void display() {
    push();
    stroke(c);
    vst.line(lastPosition.x, lastPosition.y, position.x, position.y);
    pop();
  }
}