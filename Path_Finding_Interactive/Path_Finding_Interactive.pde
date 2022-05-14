import peasy.PeasyCam;

PShape rocket;
PeasyCam cam;

PImage[] textures = new PImage[7];

//Keyboard controls
boolean [] keys;
KeyboardController keyboard; 

//Custom camera controls
int upDown;
int leftRight;

//T H E G R I D
int gridSize = 32;
int tileSize = 64;

Grid grid;

ArrayList<Character> NPC = new ArrayList<Character>();
Human player = new Human(new PVector(0, 0, 0), 1);

public void setup() {
  rocket = loadShape("assets/rocket.obj");
  textures[0] =  loadImage("assets/dirt.jpg");
  textures[1] = loadImage("assets/grass.jpg");
  textures[2] =  loadImage("assets/lava.jpg");
  textures[3] =  loadImage("assets/rock.jpg");
  textures[4] =  loadImage("assets/sand.jpg");
  textures[5] =  loadImage("assets/snow.jpg");
  textures[6] =  loadImage("assets/water.jpg");
  size(1000, 1000, P3D);

  textureMode(NORMAL);
  textureWrap(REPEAT);
  PerlinHeightMap phm  = new PerlinHeightMap(tileSize*4, 0.2); //PerlinMap(height,intensity);
  phm.generate();
  grid = new Grid();
  grid.generateTerrain(phm.getPoints());

  keyboard = new KeyboardController();
  keys = new boolean[4];
  cam = new PeasyCam(this, 400);
}
int i;
public void draw() {
  background(0);
  noStroke();
  lights();
  //makeIsometric();
  //translate(width>>1, height>>1, 0);
  //translate(-(tileSize*2*player.v.x), 0, (player.v.y*2));
  //float mx = map(mouseX, 0, width, 4096, -4096);
  //float mz = map(mouseY, 0, height, 4096, -4096);

  //translate(mx, 0, mz);

  //translate(0,100,0);
  //makeIsometric();
  //translate(0, 0, -2048);
  //rotateX(radians(90));
  //rotateZ(radians(180));
  //rotateY(radians(-180));

  //println(player.v.x+", "+player.v.y+", "+player.v.z);
  //ortho();

  toggleGuideLines(keyPressed);
  grid.show();
  player.getElevation(grid.tiles);
  player.show(tileSize);
  String txt_fps = String.format(getClass().getSimpleName()+ "   [size %d/%d]   [frame %d]   [fps %6.2f]", width, height, frameCount, frameRate);
  surface.setTitle(txt_fps);
  keyboard.listen();
}



//void spawnRandomNPC(int oneIn) {

//  for (int x = 0; x < gridSize; x++) {
//    for (int z = 0; z < gridSize; z++) {
//      int chance = floor(random(1, oneIn));
//      if (chance == 1) {

//        if (grid.tiles[x][z] instanceof Tile_Dirt) {
//          NPC.add(new Character(new PVector(x, 0, z)));
//        }
//      }
//    }
//  }
//}

void makeIsometric() {
  rotateX(-atan(1 / sqrt(2)));
  rotateY(QUARTER_PI);
}

void toggleGuideLines(boolean state) {
  float  a = gridSize*tileSize*2;
  if (key == ' ' && state) {
    strokeWeight(3);
    box(tileSize*2);
    //x-axis, green positive
    stroke(100, 255, 100);
    line(0, 0, 0, a, 0, 0);
    //x-axis, green negative
    stroke(0, 100, 0);
    line(0, 0, 0, -a, 0, 0);
    //z-axis, red positive
    stroke(255, 100, 100);
    line(0, 0, 0, 0, 0, a);
    //z-axis, red negative
    stroke(100, 0, 0);
    line(0, 0, 0, 0, 0, -a);
    //y-axis, blue positive
    stroke(100, 100, 255);
    line(0, 0, 0, 0, a, 0);
    //y-axis, blue negative
    stroke(0, 0, 100);
    line(0, 0, 0, 0, -a, 0);
    strokeWeight(1);
    stroke(0);
  }
}
