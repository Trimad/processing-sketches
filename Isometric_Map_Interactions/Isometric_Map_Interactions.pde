import ch.bildspur.postfx.builder.*;
import ch.bildspur.postfx.pass.*;
import ch.bildspur.postfx.*;
import peasy.*;
OpenSimplexNoise noise;
Tile[][] grid;
Ball[] balls;
PostFX fx;
PeasyCam cam;
int w = 64;
int mapSize = 128;
int numBalls = 16;
int zoom = 5000;

PImage water;
PImage sand;
PImage grass;
PImage rock;
PImage dirt;
PImage snow;
boolean mapLoaded = false;
PImage spritesheet;//22x51
Sprite sprite;
public void setup() {
  fullScreen(P3D);
  frameRate(60);
  noStroke();
  background(0);
  //fx = new PostFX(this);  
  cam = new PeasyCam(this, 100);
  noise = new OpenSimplexNoise();
  water = loadImage("assets/water.png");
  sand = loadImage("assets/sand.jpg");
  grass = loadImage("assets/grass.jpg");
  rock = loadImage("assets/rock.jpg");
  dirt = loadImage("assets/dirt.jpg");
  snow = loadImage("assets/rock2.jpg");
  spritesheet = loadImage("assets/sprite.png");
  createFrames(spritesheet);
  sprite = new Sprite(0, 0, 0, 128); //22x51
  grid = new Tile[mapSize][mapSize];
  balls = new Ball[numBalls];
  loadMap(mapSize);

  for (int i = 0; i < balls.length; i++) {
    balls[i] = new Ball(mapSize/2-1, 0, mapSize/2-1, 64);
  }
}

public void draw() {
  background(0);
  ambientLight(33, 22, 22);
  //spotLight(128, 128, 128, 0, 0, 0, 0, 0, -1, PI, 1);
  //spotLight(128, 128, 128, 0, 0, 0, 0, -1, 0, PI, 1);
  //spotLight(128, 128, 128, 0, 0, 0, -1, 0, 0, PI, 1);
  directionalLight(200, 255, 230, 0, -1, 0);
  directionalLight(255, 230, 255, 0, 0, -1);
  textureMode(IMAGE);
  textureWrap(REPEAT); 

  //translate(w*mapSize/2, w*mapSize/3, -zoom);

  rotateX(-atan(1 / sqrt(2)));
  rotateY(-QUARTER_PI);

  //float m1 = map(mouseY, height, 0, -PI/2, -PI/5);
  //rotateX(m1);

  if (mapLoaded) {
    for (int i = 0; i < grid.length; i++) {
      for (int j = 0; j < grid.length; j++) {
        grid[i][j].display();
      }
    }
  }
  /*
  for (int i = 0; i < balls.length; i++) {
    balls[i].update();
    balls[i].display(sprite);
    balls[i].randomWalk();
  }*/
  
  sprite.display();
  sprite.getPosition(key);
  
  /*
  fx.render()
   .bloom(0.8, 20, 40)
   
   //.rgbSplit(100)
   //.sobel()
   //.brightPass(0.5)
   .blur(1, 20)
   //.toon()
   //.denoise(100)
   .compose();
   
   saveFrame("frame-####.tif");
   */
}

public void loadMap(int size) {

  String[] save = loadStrings("save.txt");
  int x = 0;
  int z = 0;
  for (int l = 0; l < size*size; l++) {
    String[] num = split(save[l], '\t');
    grid[x][z] = new Tile(Integer.parseInt(num[0]), Integer.parseInt(num[1]), Integer.parseInt(num[2]), Float.parseFloat(num[3]));
    z++;
    if (z%size==0) {
      z=0;
      x++;
    }
  }
  mapLoaded = true;
}

public float getSimplexNoise(int x, int z, float scale) {
  int numFrames = 60;
  float t = (0.111f*frameCount/numFrames)%1;
  float ns = (float)noise.eval(scale*x, scale*z, cos(TWO_PI*t), sin(TWO_PI*t));
  return ns;
}

/*
void keyPressed() { 
 if (key == ' ') {
 yes.getPosition(key);
 }
 }
 */