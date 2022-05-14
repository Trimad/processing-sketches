//https://preshing.com/20110831/penrose-tiling-explained/
//public static int A_TILE = 0<<24|0<<16|0<< 8|0; //BLACK
public static int A_TILE = 255<<24|255<<16|0<< 8|0; //RED
//public static int A_TILE = 255<<24|78<<16|154<< 8|6; //Green

//public static int B_TILE = 255<<24|255<<16|255<< 8|0; //YELLOW
//public static int B_TILE = 255<<24|255<<16|255<< 8|255; //WHITE
public static int B_TILE = 255<<24|114<<16|159<< 8|207; //Blue

public static float GOLDEN_RATIO = 1.618033989;
ArrayList<Tile> tiles = new ArrayList();
ArrayList<Tile> subtiles = new ArrayList();

void init() {
  int n = 20;
  int d = height; //diameter
  for (int i = 0; i < n; i++) {

    PVector A = new PVector(width>>1, height>>1);

    double bx = (width>>1) + Math.sin(TWO_PI / n * i) * d / 2;
    double by = (height>>1) - Math.cos(TWO_PI / n * i) * d / 2;
    PVector B = new PVector((float)bx, (float)by);

    double cx = (width>>1) + Math.sin(TWO_PI / n * (i-1)) * d / 2;
    double cy = (height>>1) - Math.cos(TWO_PI / n * (i-1)) * d / 2;
    PVector C = new PVector((float)cx, (float)cy);

    //tiles.add(new Tile(A_TILE, A, B, C));

    if (i%2==0) {
      tiles.add(new Tile(A_TILE, A, B, C));
      //tiles.add(new Tile(A_TILE, B, A, C));//Darts and kites
    } else {
      tiles.add(new Tile(A_TILE, A, C, B));//swapped C and B to alternate
      //tiles.add(new Tile(A_TILE, C, A, B));//Darts and kites
    }
  }
}

void setup() {
  init();
  background(0);
  size(900, 900);
  noStroke();
}

void draw() {

  tiles.forEach(s -> {
    s.drawTile();
  }
  );

  tiles.forEach(t -> {
    //t.subdivideP2();
    t.subdivide();
  }
  );

  subtiles.forEach(s -> {
    s.drawTile();
  }
  );

  tiles = (ArrayList)subtiles.clone();
  subtiles.clear();

  if (frameCount%6==0) {
    noLoop();
  }
  surface.setTitle(frameRate+"");
}
