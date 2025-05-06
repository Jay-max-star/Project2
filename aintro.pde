void intro() {
  background(#0A0A2A);
 space.show();
  textSize(90);
  fill(#DBD9D9);
   textFont(Wordread);
  text("SPACE GAME", width / 2, 200);

  rectButton("START", width / 2, 600, 200, 100);
}



void introClicks() {
  if (mouseX > 300 && mouseX < 500 && mouseY > 550 && mouseY < 650) {
    mode = GAME;
  }
}
