PImage spritesheet;//22x51
Sprite sprite;

int spriteWidth = 22;
int spriteHeight =  51;
public void setup() {

  //fullScreen(P3D);
  size(900, 900, P3D);
  frameRate(60);
  spritesheet = loadImage("assets/sprite.png");
  createFrames(spritesheet);
  sprite = new Sprite(0, 0, 0, 128); //22x51
}

public void draw() {
  translate(width/2, height/2, 0);
  rotateX(-atan(1 / sqrt(2)));
  rotateY(-QUARTER_PI);
  background(0);

  //sprite.randomWalk();
  sprite.display();
  sprite.getPosition(key);
}