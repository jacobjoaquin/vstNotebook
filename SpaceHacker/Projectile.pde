abstract class Projectile extends DisplayableBase {
  PVector position;
  PVector lastPosition;
  float angle;
  PVector velocity;
  float velocityMagnitude = 10;
  float brightness = 255;
  int framesLeft = 100;
  Being owner;
  
  Projectile(Being owner) {
    position = owner.position.copy();
    lastPosition = position.copy();
    angle = owner.angle;
    velocity = PVector.fromAngle(angle);
    velocity.mult(velocityMagnitude);
    velocity.add(owner.velocity);
  }
  
  void update() {
    if (--framesLeft == 0) {
      complete();
    }
    
    lastPosition = position.copy();
    position.add(velocity);
  }
  
  void display() {
    pushStyle();
    stroke(brightness);
    line(lastPosition.x, lastPosition.y, position.x, position.y);
    popStyle();
  }
}

class Projectiles extends DisplayableList<Projectile> {
}

class PlayerLaser extends Projectile {
  PlayerLaser(Being owner) {
   super(owner);
  }
}