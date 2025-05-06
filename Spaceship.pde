class Spaceship extends GameObject {
  PVector dir;
  int cooldown;
  int invincibleTimer;
  int teleportCooldown;
  boolean teleportReady = true;

  Spaceship() {
    super(width / 2, height / 2, 0, 0);
    dir = new PVector(0.1, 0);
    cooldown = 0;
    invincibleTimer = 0;
    lives = 3;
  }

  void show() {
    if (invincibleTimer > 0 && frameCount % 10 < 5) return; // Blink
    pushMatrix();
    translate(loc.x, loc.y);
    rotate(dir.heading());
    drawShip();
    popMatrix();
  }

  void drawShip() {
    stroke(255);
    strokeWeight(3);
    line(-5, -10, 30, -8);
    line(-5, 10, 30, 8);
    fill(0);
    stroke(255);
    strokeWeight(2);
    triangle(-5,-10,-15,-20,-10,-10);
    triangle(-5,10,-15,20,-10,10);
    triangle(-10, -15, -10, 15, 32, 0);
    circle(15, 0, 6);
    line(9,0,21,0);
    line(15,6,15,-6);
    circle(2,0,15);
    triangle(-8, 0, -15, 10, -15, -10);
    
}

  void act() {
    if (invincibleTimer > 0) invincibleTimer--;
    if (teleportCooldown > 0) {
      teleportCooldown--;
      if (teleportCooldown == 0) teleportReady = true;
    }
    move();
    shoot();
    checkForCollisions();
    wrapAround();
  }

  void move() {
    loc.add(vel);
    vel.setMag(min(vel.mag(), 10));

    if (upkey) {
      vel.add(dir);
      for (int i = 0; i < 2; i++) {
        PVector offset = PVector.fromAngle(dir.heading() + PI).mult(15);
        PVector particlePos = PVector.add(loc, offset);
        PVector particleVel = PVector.fromAngle(dir.heading() + PI).mult(random(0.5, 1.5));
        objects.add(new Particle(particlePos, particleVel, color(#ABDAFC)));
      }
    }

    if (leftkey) dir.rotate(-radians(3));
    if (rightkey) dir.rotate(radians(3));
    vel.limit(10);
  }

  void shoot() {
    cooldown--;
    if (spacekey && cooldown <= 0) {
      objects.add(new Bullet());
      cooldown = 30;
    }
  }

  void teleport() {
    if (!teleportReady) return;

    int attempts = 0;
    while (attempts < 100) {
      float newX = random(width);
      float newY = random(height);
      boolean safe = true;

      for (GameObject obj : objects) {
        if (obj instanceof Asteroid) {
          if (dist(newX, newY, obj.loc.x, obj.loc.y) < 200) {
            safe = false;
            break;
          }
        }
      }

      if (safe) {
        loc.set(newX, newY);
        teleportReady = false;
        teleportCooldown = 300; // 5 sec cooldown
        return;
      }
      attempts++;
    }
  }

  void checkForCollisions() {
    if (invincibleTimer > 0) return;

    for (GameObject obj : objects) {
      if (obj instanceof Asteroid || (obj instanceof Bullet && ((Bullet)obj).fromUFO)) {
        float combinedDist = d / 2 + obj.d / 2;
        if (dist(loc.x, loc.y, obj.loc.x, obj.loc.y) < combinedDist) {
          lives--;
          invincibleTimer = 120;
          println("Ship hit! Lives left: " + lives);
        }
      }
    }
  }
}
