//import ddf.minim.*;
//import java.util.ArrayList;

int mode;
final int INTRO = 0;
final int GAME = 1;
final int PAUSE = 2;
final int GAMEOVER = 3;
int gameOverType = 0;

boolean upkey, downkey, leftkey, rightkey, spacekey;

float d;
int score, lives, highscore;
float size;

PFont Wordread;

//Minim minim;
//AudioPlayer theme, coin, bump, gameover;

Spaceship player1;
ArrayList<GameObject> objects;

//gif

Gif space,spaceship;

void setup() {
  size(800, 800);
  textAlign(CENTER, CENTER);
  rectMode(CENTER);
  mode = INTRO;

  Wordread = createFont("Electro Wave Vol.2_Free.ttf", 120);
  textFont(Wordread);

  objects = new ArrayList<GameObject>();
  player1 = new Spaceship();
  objects.add(player1);
  for (int i = 0; i < 5; i++) {
    objects.add(new Asteroid());
  }

  //minim = new Minim(this);
  //theme = minim.loadFile("theme.MP3");
  //coin = minim.loadFile("coin.wav");
  //bump = minim.loadFile("bump.wav");
  //gameover = minim.loadFile("downer_noise.mp3");

//gif
 space = new Gif("space/frame_", "_delay-0.04s.gif",40,5,0,0,width,height);
spaceship = new Gif("spaceship/frame_", "_delay-0.04s.gif",27,5,0,0,width,height);


}

void draw() {
  if (mode == INTRO) {
    intro();
  } else if (mode == GAME) {
    game();
  } else if (mode == PAUSE) {
    pause();
  } else if (mode == GAMEOVER) {
    gameover();
  } else {
    println("Error: Invalid mode: " + mode);
  }
}

void resetGame() {
  objects.clear();
  player1 = new Spaceship();
  objects.add(player1);
  for (int i = 0; i < 5; i++) {
    objects.add(new Asteroid());
  }
  score = 0;
  lives = 3;
  gameOverType = 0;
  frameCount = 0;
}
