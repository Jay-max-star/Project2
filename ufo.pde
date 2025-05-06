class UFO extends GameObject {
  int shootCooldown;

  UFO() {
    super(random(width), random(height), 1, 1);
vel.setMag(random(1, 2));
vel.rotate(random(TWO_PI));
lives = 3;
d = 50;
shootCooldown = 60;
  }

  void show() {
    fill(#474950);
    noStroke();
   triangle(loc.x, loc.y-d/4.5, loc.x-d/1.05,loc.y, loc.x,loc.y+d/4.5);
   triangle(loc.x, loc.y-d/4.5, loc.x+d/1.05,loc.y, loc.x,loc.y+d/4.5);
   ellipse(loc.x, loc.y, d, d / 2);
    fill(255);
    ellipse(loc.x, loc.y - 5, 20, 10);
    
    
  }

  void act() {
    loc.add(vel);
    wrapAround();
    wrapAround();
checkForHit();
shoot();
}
    
void shoot() {
shootCooldown--;
if (shootCooldown <= 0 && player1.lives > 0) {
PVector direction = PVector.sub(player1.loc, this.loc);
direction.setMag(5);
PVector bulletStart = this.loc.copy();
objects.add(new EnemyBullet(bulletStart, direction));
shootCooldown = int(random(60, 120)); // random delay
}
}
  







void checkForHit() {
for (int i = objects.size() - 1; i >= 0; i--) {
GameObject obj = objects.get(i);

if (obj instanceof Bullet) {
if (dist(loc.x, loc.y, obj.loc.x, obj.loc.y) < d / 2 + obj.d / 2) {
this.lives = 0;
obj.lives = 0;
}
}

if (obj instanceof Spaceship) {
if (dist(loc.x, loc.y, obj.loc.x, obj.loc.y) < d / 2 + obj.d / 2) {
this.lives = 0;
obj.lives = 0;
}
}
}
}
}
