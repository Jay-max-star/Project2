color Blue = #89CFF0;

void game() {
  background(0);

  int i = 0;
  while (i < objects.size()) {
    GameObject currentObject = objects.get(i);
    currentObject.act();
    currentObject.show();
    if (currentObject.lives == 0)
      objects.remove(i);
    else
      i++;
  }

  // Check for WIN
  boolean asteroidLeft = false;
  for (GameObject obj : objects) {
    if (obj instanceof Asteroid) {
      asteroidLeft = true;
      break;
    }
  }
  if (!asteroidLeft) {
    mode = GAMEOVER;
    gameOverType = 1;
  }

  // Check for LOSE
  if (player1.lives <= 0) {
    mode = GAMEOVER;
    gameOverType = 2;
  }

 
  stroke(0);
  fill(255);
  circle(80, 100, 60);
  line(70, 90, 70, 110);
  line(90, 90, 90, 110);
  

  // UFO Spawning
  if (frameCount % 1000 == 0) {
    objects.add(new UFO());
  }

  // Lives Display
  fill(255);
  textSize(24);
  text("Lives: " + player1.lives, 100, 50);

  // Teleport Cooldown Bar UI
  float barW = 200;
  float barH = 20;
  float filledW = map(player1.teleportCooldown, 0, 300, barW, 0);
  float x = width - 150;
  float y = 50;

  noStroke();
  fill(#81089D);
  rect(x, y, barW, barH);

  fill(player1.teleportReady ? color(#D289E3) : color(#D289E3));
  rect(x, y, barW - filledW, barH);

  fill(255);
  textSize(16);
  text("Teleport", x + barW / 4, y - 20);
}

void gameClicks() {
  if (dist(mouseX, mouseY, 80, 100) < 30) {
    mode = PAUSE;
  }
}
