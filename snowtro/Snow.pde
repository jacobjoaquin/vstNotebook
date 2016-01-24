class Snow extends DisplayableList {
  void init() {
    // Populates screen with snow.
    for (int i = 0; i < height * 8; i++) {
      update();
    }
  }

  void update() {
    if (random(1.0) < 0.25) {
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
  float flutter = 1;
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


    // TODO: Clean this mess up!!
    float snowAmt = 1;
    int x1 = round(position.x);
    x1 = x1 < 0 ? 0 : x1;
    x1 = x1 >= width - 1 ? width - 1 : x1;
    if (x1 < snowLine.positions.size() && x1 >= 0) {
      int x0 = x1 - 1;
      x0 = x0 < 0 ? width - 1 : x0;
      int x2 = x1;
      x2 = x2 >= width - 1 ? 0 : x2;
      PVector p0 = snowLine.positions.get(x0);
      PVector p1 = snowLine.positions.get(x1);
      PVector p2 = snowLine.positions.get(x2);
      if (position.y >= p1.y || position.y >= p0.y || position.y >= p2.y) {
        if (p0.y > p1.y || p2.y > p1.y) {
          if (p0.y > p2.y) {
            p0.y -= snowAmt;
          } else {
            p2.y -= snowAmt;
          }
        } else {
          p1.y -= snowAmt;
        }
        complete();
      }
    }
  }

  void display() {
    pushStyle();
    stroke(c);
    vst.line(lastPosition.x, lastPosition.y, position.x, position.y);
    popStyle();
  }
}