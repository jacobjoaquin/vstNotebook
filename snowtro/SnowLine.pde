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
    //for (PVector p : positions) {
    //vst.vertex(p.x, p.y);
    //}

    for (int i = 1; i < positions.size(); i += 2) {
     PVector p0 = (PVector) positions.get(i - 1);
     PVector p1 = (PVector) positions.get(i);
     vst.vertex(p0.x, (p0.y + p1.y) * 0.5);
    }

    //for (int i = 4; i < positions.size(); i += 4) {
    //  float y = 0;
    //  for (int j = 0; j < 4; j++) {
    //    PVector p = (PVector) positions.get(i);
    //    y += p.y;
    //  }
    //  y *= 0.25;
    //  vst.vertex(i, y);
    //}

    vst.endShape();
    pop();
  }
}