PImage dirt;
PImage grass;
PImage lava;
PImage rock;
PImage sand;
PImage snow;
PImage water;

//T H E   G R I D
byte gridSize = 127; //max value is 2^7-1
byte tileSize = 16; //max value is 2^7-1
byte heightModifier = 10;
Grid grid;

ArrayList<Node> nodes = new ArrayList<Node>(); //max value is 2^7-1

void setup() {
  fullScreen(P3D);
  //size(900, 900, P3D);
  textureMode(NORMAL);
  textureWrap(REPEAT);
  dirt =  loadImage("assets/dirt.jpg");
  grass = loadImage("assets/grass.jpg");
  //lava =  loadImage("assets/lava.jpg");
  //rock =  loadImage("assets/rock.jpg");
  sand =  loadImage("assets/sand.jpg");
  //snow =  loadImage("assets/snow.jpg");
  water =  loadImage("assets/water.jpg");

  grid = new Grid();
  grid.generateTerrain();
  spawnRandomNPC(127); //max value is 2^7-1
  
}
/*
void mouseWheel(MouseEvent event) {
  byte i = (byte)event.getCount();
  tileSize+=i*-1;
}
*/
void draw() {

  MST mst = new MST();
  mst.prim(nodes);

  background(51);
  noStroke();

  float horizontal = map(mouseX, 0, width, (tileSize*gridSize)/2, -(tileSize*gridSize)*2);
  float vertical = map(mouseY, 0, height, (tileSize*gridSize), -(tileSize*gridSize)/2);
  translate(horizontal, vertical, -2048);

  makeIsometric();

  ortho();
  ambientLight(222, 222, 222);
  directionalLight(128, 128, 128, 1, 0, 1);
  toggleGuideLines(keyPressed);

  //Show the grid
  grid.show();
  mst.show();

  //Show the NPC's
  if (nodes.size() > 1) {
    for (short i = 0; i < nodes.size(); i++) {
      nodes.get(i).show();
      nodes.get(i).randomWalk();
      nodes.get(i).getElevation(grid.tiles);
    }
  }
  
}

void spawnRandomNPC(int howMany) {

  byte count = 0;

  while (count < howMany) {
    byte randomX = (byte)floor(random(3, gridSize-1));
    byte randomZ = (byte)floor(random(3, gridSize-1));

    if (grid.tiles[randomX][randomZ] instanceof Tile_Dirt) {
      nodes.add(new Node(randomX, randomZ));
      count++;
    }
  }
}

void makeIsometric() {
  rotateX(-atan(1 / sqrt(2)));
  rotateY(QUARTER_PI);
}

void toggleGuideLines(boolean state) {

  if (key == ' ' && state) {
    strokeWeight(3);
    //x-axis, green positive
    stroke(100, 255, 100);
    line(0, 0, 0, 4096, 0, 0);
    //x-axis, green negative
    stroke(0, 100, 0);
    line(0, 0, 0, -4096, 0, 0);
    //z-axis, red positive
    stroke(255, 100, 100);
    line(0, 0, 0, 0, 0, 4096);
    //z-axis, red negative
    stroke(100, 0, 0);
    line(0, 0, 0, 0, 0, -4096);
    //y-axis, blue positive
    stroke(100, 100, 255);
    line(0, 0, 0, 0, 4096, 0);
    //y-axis, blue negative
    stroke(0, 0, 100);
    line(0, 0, 0, 0, -4096, 0);
    strokeWeight(1);
    stroke(0);
  }
}