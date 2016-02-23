class Player extends DisplayableBase {
  float brightness = 128;
  float angle = -HALF_PI;
  PVector acceleration;
  PVector velocity;
  PVector position;
  boolean showFlame = true;
  private float rotateAmount = 0.1;

  Player() {
    super();
    position = new PVector(0, 0);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
  }

  void update() {
    acceleration.set(0, 0);

    if (inputHandler.isPressed(Keys.ROTATE_LEFT)) {
      angle -= rotateAmount;
    }    
    if (inputHandler.isPressed(Keys.ROTATE_RIGHT)) {
      angle += rotateAmount;
    }
    if (inputHandler.isPressed(Keys.FORWARD)) {
      PVector a = PVector.fromAngle(angle);
      acceleration.add(a);
    }
    if (inputHandler.isPressed(Keys.BACKWARD)) {
      PVector a = PVector.fromAngle(-angle);
      acceleration.add(a);
    }
    
    velocity.add(acceleration);
    position.add(velocity);
    velocity.mult(0.95);
  }

  void display() {
    pushMatrix();
    //translate(width / 2.0, height / 2.0);
    pushStyle();
    noFill();
    stroke(brightness);
    float a = angle;
    beginShape();
    PVector v = PVector.fromAngle(a);
    v.mult(20);
    for (int i = 0; i < 3; i++) {
      vertex(v.x, v.y);
      v.rotate(TAU / 3);
    }
    endShape(CLOSE);

    if (showFlame) {
      v.mult(-1);
      ellipse(0, 0, 10, 10);
    }
    popStyle();
    popMatrix();
  }
}