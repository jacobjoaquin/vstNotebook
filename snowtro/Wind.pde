class Wind extends DisplayableBase {
  PVector velocity;
  private float n;
  private float nInc;
  private float amt = 5;
  
  Wind() {
    super();
    n = 0;
    nInc = 0.005;
    velocity = new PVector(noise(n), 0);
  }
  
  void update() {
    super.update();
    n += nInc;
    velocity.x = map(noise(n), 0, 1, -amt, amt);
  }
}