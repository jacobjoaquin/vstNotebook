Vst vst;
Player player;
InputHandler inputHandler;
Level level;

void settings() {
  size(450, 550, P2D);
  pixelDensity(displayDensity());
}

void setup() {
  frameRate(50);
  vst = new Vst(this, createSerial());
  vst.colorStroke = color(220, 220, 255);
  blendMode(ADD);

  player = new Player();
  inputHandler = new InputHandler();
  level = new RandomLevel();
}

void draw() {
  background(0);


  inputHandler.update();

  level.update();
  player.update();


  pushMatrix();
  //translate(width / 2.0, height / 2.0);
  translate(-player.position.x, -player.position.y);  
  level.display();
  popMatrix();
  
  
  player.display();
  vst.display();

  inputHandler.clearReleased();
}

void keyPressed() {
  inputHandler.add(key);
}

void keyReleased() {
  inputHandler.release(key);
}