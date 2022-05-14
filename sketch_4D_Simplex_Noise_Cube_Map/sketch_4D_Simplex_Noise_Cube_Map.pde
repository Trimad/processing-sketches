//ffmpeg -i test.mp4 -i music.mp3 -codec copy -shortest output.mp4
//ffmpeg -r 60 -f image2 -s 3840x2160 -i frame-%04d.tif -c:v libx264 -preset slow -profile:v high -crf 9 -coder 1 -pix_fmt yuv420p -movflags +faststart -g 30 -bf 2 -c:a aac -b:a 384k -profile:a aac_low test4.mp4

OpenSimplexNoise noise;
int w = 128;
float maxD;
int howMany =128;
PImage water;
PImage sand;
PImage grass;
PImage rock;
PImage dirt;
PImage snow;
boolean stopZoom = false;
boolean mapLoaded = false;

ArrayList<Tile> tiles = new ArrayList<Tile>();

void setup() {
  frameRate(60);
  water = loadImage("assets/water.png");
  sand = loadImage("assets/sand.jpg");
  grass = loadImage("assets/grass.jpg");
  rock = loadImage("assets/rock.jpg");
  dirt = loadImage("assets/dirt.jpg");
  snow = loadImage("assets/snow2.jpg");
  noise = new OpenSimplexNoise();
  //fullScreen(P3D);
  size(1080, 1080, P3D);
  saveMap(howMany);
  loadMap(howMany);
}

void draw() {

  textureMode(IMAGE);
  textureWrap(REPEAT); 
  background(51);
  noStroke();
  translate(width/2, height/2, -4096);
  //directionalLight(255, 230, 230, -1, 0, 0);
  directionalLight(200, 255, 230, 0, -1, 0);
  directionalLight(255, 230, 255, 0, 0, -1);
  rotateX(-atan(1 / sqrt(2)));
  rotateY(-QUARTER_PI);

  rotateY(frameCount*0.01);

  //drawMap();
  //saveFrame("frame-####.tif");
  if (frameCount >= 3721) { //1 minute at 60FPS
    exit();
  }

  if (mapLoaded) {
    for (int i = 0; i < tiles.size(); i++) {    
      tiles.get(i).display();
    }
  }
  //drawMap();
}

void saveMap(int size) {
  String[] lines = new String[size*size];
  int z = 0;
  int x = 0;
  for (int l = 0; l < size*size; l++) {
    lines[l] = x + "\t" + 0 + "\t" + z + "\t" + getSimplexNoise(z*w, x*w, 0.0008);
    z++;
    if (z%howMany==0) {
      z=0;
      x++;
    }
  }
  saveStrings("save.txt", lines);
}

void loadMap(int size) {
  String[] save = loadStrings("save.txt");
  for (int i = 0; i < size*size; i++) {
    String[] num = split(save[i], '\t');
    int x= Integer.parseInt(num[0]);
    int y = Integer.parseInt(num[1]);
    int z = Integer.parseInt(num[2]);
    float noise = Float.parseFloat(num[3]);
    tiles.add(new Tile(x, y, z, noise));
  }
  mapLoaded = true;
}

void drawMap() {
  for (int z = 0; z < howMany; z++) {
    for (int x = 0; x < howMany; x++) {

      float m = map(getSimplexNoise(x*w, z*w, 0.0007), -1, 1, -500, 900);
      float mc = constrain(m, 0, 640);

      pushMatrix();
      translate(x*w, 0, z*w);

      if (mc < 1) {      
        TexturedCube(water, mc);
      } else if (mc >= 1 && mc < 128) {
        TexturedCube(sand, mc);
      } else if (mc >= 128 && mc < 384) {
        TexturedCube(grass, mc);
      } else if (mc >= 384 && mc < 512) {
        TexturedCube(dirt, mc);
      } else if (mc >= 512 && mc < 640) {
        TexturedCube(rock, mc*1.2);
      } else if (mc >= 640 ) {
        TexturedCube(snow, mc);
      }
      popMatrix();
    }
  }
}


float getSimplexNoise(int x, int z, float scale) {
  int numFrames = 60;
  float t = (0.222*frameCount/numFrames)%1;
  float ns = (float)noise.eval(scale*x, scale*z, cos(TWO_PI*t), sin(TWO_PI*t));
  return ns;
}