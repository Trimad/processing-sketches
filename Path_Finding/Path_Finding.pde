PImage dirt;
PImage grass;
PImage lava;
PImage rock;
PImage sand;
PImage snow;
PImage water;

//Custom camera controls
int upDown;
int leftRight;
boolean [] keys;

//T H E G R I D
int gridSize = 32;
int tileSize = 32;
Grid grid;

ArrayList<Character> NPC = new ArrayList<Character>();
Character player = new Character(floor(gridSize/2), 0, floor(gridSize/2));
void setup() {
  //fullScreen(P3D);
  size(900, 900, P3D);
  frameRate(10);
  textureMode(NORMAL);
  textureWrap(REPEAT);
  keys = new boolean[4];
  dirt =  loadImage("assets/dirt.jpg");
  grass = loadImage("assets/grass.jpg");
  lava =  loadImage("assets/lava.jpg");
  rock =  loadImage("assets/rock.jpg");
  sand =  loadImage("assets/sand.jpg");
  snow =  loadImage("assets/snow.jpg");
  water =  loadImage("assets/water.jpg");

  grid = new Grid();
  grid.generateTerrain();
  spawnRandomNPC(30);
}


void draw() {
  background(51);
  noStroke();
  translate(width/2-(tileSize*2*player.v.x), height/2-(tileSize*2*player.v.z), -512-(player.v.y*2));
  rotateX(radians(90));
  rotateZ(radians(180));
  rotateY(radians(-180));
  //println(player.v.x+", "+player.v.y+", "+player.v.z);
  //ortho();

  //makeIsometric();

  //rotateX(-atan(1 / sqrt(2)));
  //rotateY(QUARTER_PI);



  lights();

  toggleGuideLines(keyPressed);

  //Show the grid
  grid.show();

  //Show the player
  player.show(tileSize);
  player.getElevation(grid.tiles);

  //Shwo the NPC's
  if (NPC.size() > 1) {
    for (int i = 0; i < NPC.size(); i++) {
      NPC.get(i).show(tileSize);
      NPC.get(i).getElevation(grid.tiles);
    }
    MST(NPC);
  }


  //Custom camera controls
  if (keys[0]) {//w
    if (player.v.z > 0){
      //if (grid.tiles[(int)player.v.x][(int)player.v.x+1] instanceof Tile_Dirt)
      player.v.z--;
    }
  }
  if (keys[1]) { //d
    if (player.v.x < gridSize-1){
      //if (grid.tiles[(int)player.v.z][(int)player.v.z] instanceof Tile_Dirt)
      player.v.x++;
    }
  }
  if (keys[2]) { //s
    if (player.v.z < gridSize-1) {
      //if(grid.tiles[(int)player.v.x][(int)player.v.x-1] instanceof Tile_Dirt)
      player.v.z++;
    }
  }
  if (keys[3]) { //a
    if (player.v.x > 0) {
      //if(grid.tiles[(int)player.v.z+1][(int)player.v.z] instanceof Tile_Dirt)
      player.v.x--;
    }
  }
}

void keyPressed()
{
  if (key=='w' || keyCode == UP)
  keys[0]=true;
  if (key=='d' || keyCode == RIGHT)
  keys[1]=true;
  if (key=='s' || keyCode == DOWN)
  keys[2]=true;
  if (key=='a' || keyCode == LEFT)
  keys[3]=true;
}

void keyReleased()
{
  if (key=='w' || keyCode == UP)
  keys[0]=false;
  if (key=='d' || keyCode == RIGHT)
  keys[1]=false;
  if (key=='s' || keyCode == DOWN)
  keys[2]=false;
  if (key=='a' || keyCode == LEFT)
  keys[3]=false;
}

void spawnRandomNPC(int oneIn) {

  for (int x = 0; x < gridSize; x++) {
    for (int z = 0; z < gridSize; z++) {
      int chance = floor(random(1, oneIn));
      if (chance == 1) {

        if (grid.tiles[x][z] instanceof Tile_Dirt) {
          NPC.add(new Character(x, 0, z));
        }
      }
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


public void MST(ArrayList<Character> list) {

  ArrayList<PVector> reached = new ArrayList<PVector>();
  ArrayList<PVector> unreached = new ArrayList<PVector>();

  for (int i = 0; i < list.size(); i++) {
    unreached.add(list.get(i).v);
  }

  reached.add(unreached.get(0));
  unreached.remove(0);

  while (unreached.size() > 0) {
    float record = 9999; //infinity
    int rIndex = 0;
    int uIndex = 0;
    for (int i = 0; i < reached.size(); i++) {
      for (int j = 0; j < unreached.size(); j++) {
        PVector v1 = reached.get(i);
        PVector v2 = unreached.get(j);
        float d = dist(v1.x, v1.y, v1.z, v2.x, v2.y, v2.z);
        if (d < record) {
          record = d;
          rIndex = i;
          uIndex = j;
        }
      }
    }
    stroke(255);
    strokeWeight(2);
    PVector p1 = reached.get(rIndex);
    PVector p2 = unreached.get(uIndex);
    line(p1.x*tileSize*2, p1.y, p1.z*tileSize*2, p2.x*tileSize*2, p2.y, p2.z*tileSize*2);
    reached.add(p2);
    unreached.remove(uIndex);
  }
  noStroke();
}

void randomWalk(){
  if(frameCount%2==0){
    int xr = round(random(-1,1));
    int zr = round(random(-1,1));

    switch(xr){
      case -1:
      if(player.v.x > 2){
        player.v.x += xr;
      }
      break;
      case 1:
      if(player.v.x <gridSize-2){
        player.v.x += xr;
      }
      break;
    }

    switch(zr){
      case -1:
      if(player.v.z > 2){
        player.v.z += zr;
      }
      break;
      case 1:
      if(player.v.z <gridSize-2){
        player.v.z += zr;
      }
      break;
    }

  }
}
