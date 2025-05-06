void gameover() {
  background(0);
spaceship.show();
  if (gameOverType == 1) {
    fill(#00FF00);
    textSize(70);
    text("YOU WIN!", width / 2, 200);
  } else if (gameOverType == 2) {
    fill(#7E2F90);
    textSize(70);
    text("GAME OVER", width / 2, 200);
  } else {
    fill(255);
    textSize(70);
    text("GAME OVER", width / 2, 200);
  }

  // Orbiting visual
  pushMatrix();
  translate(width / 6, height/ 6);
  rotate(frameCount * 0.02);
  stroke(255);
  fill(255, 50);
  ellipse(100, 0, 20, 20);
  popMatrix();

  rectButton("RESTART", width / 2, 600, 200, 100);
}


void gameoverClicks() {
  if (mouseX > 300 && mouseX < 500 && mouseY > 550 && mouseY < 650) {
    mode = INTRO;
    resetGame();
  }
}
