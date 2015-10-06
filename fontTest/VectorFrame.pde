class VectorFrame {
  boolean captureMode = true;
  private PrintWriter pw;
  private ArrayList<PVector> pvectors = new ArrayList<PVector>();
  private int linesInFrame = 0;
  private int maxLinesPerFrame = 0;

  VectorFrame(String filename) {
    pw = createWriter(filename);
  }

  void beginFrame() {
    println("beginFrame()");
    pvectors.clear();
    linesInFrame = 0;
  }

  void endFrame() {
    if (captureMode) {
      pw.print(frameCount);
      for (PVector p : pvectors) {
        pw.print("," + p.x);
        pw.print("," + p.y);
      }
      pw.println();
      println("frame:  " + frameCount);
      maxLinesPerFrame = max(maxLinesPerFrame, linesInFrame);
    }
  }

  void end() {
    captureMode = false;
    pw.flush();
    pw.close();
    println("maxLinesPerFrame: " + maxLinesPerFrame);
  }

  void vLine(PVector p1, PVector p2) {
    line(p1.x, p1.y, p2.x, p2.y);
    pvectors.add(p1);
    pvectors.add(p2);
    linesInFrame++;
  }
}

