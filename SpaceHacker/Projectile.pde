abstract class Projectile extends DisplayableBase {
  PVector position;
  float angle;
  PVector velocity;  
  float brightness = 255;
  int framesLeft = 100;
  Being owner;
  
  Projectile(Being owner) {
    position = owner.position.copy();
    angle = owner.angle;
    velocity = owner.velocity.copy();
  }
  
  void update() {
    if (--framesLeft == 0) {
      complete();
    }
    
    position.add(velocity);
  }
  
  void display() {
    pushStyle();
    stroke(brightness);
    ellipse(position.x, position.y, 3, 3);
    popStyle();
  }
}

class Projectiles extends DisplayableList<Projectile> {
}

class PlayerLaser extends Projectile {
  //PlayerLaser(Being owner) {
  //  super(owner);
  //}
}