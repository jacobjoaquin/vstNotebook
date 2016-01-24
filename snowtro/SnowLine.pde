class SnowLine extends DisplayableBase {
  ArrayList<PVector> positions;
  private float startY = height * 0.875;
  
  SnowLine() {
    super();
    positions = new ArrayList<PVector>(width);
    init();
  }
  
  void init() {
    float n = 0;
    float nInc = 0.01;
    for (int i = 0; i < width; i++) {
      positions.add(new PVector(i, startY - noise(n) * 150));
      n += nInc;
    }
  }
  
  void display() {
    push();
    stroke(127);
    vst.beginShape();
    for (PVector p : positions) {
      vst.vertex(p.x, p.y);
    }
    vst.endShape();
    pop();
  }
}