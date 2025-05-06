void pause() {
   fill(255);
    textSize(70);
    text("PAUSE",400,400);
     stroke(0);
    stroke(0);
  fill(255);
  circle(80, 100, 60);
  line(70, 80, 100, 100);
  line(70, 120, 100, 100);
   }
 
 
  
 
 void pauseClicks() {
   if (dist(mouseX,mouseY,80,100)<30) {
   mode = GAME;
  }
}
