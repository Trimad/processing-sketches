import processing.javafx.*;

Tile[][] tiles;
public static PGraphics pg;
public static PImage tex;
public static int ROWS = 0;
public static int COLS = 0;
public static int MY_SCALE = 0;
PerlinEffect perlin = new PerlinEffect(this);
RandomEffect random = new RandomEffect(this);

public void settings() {
  size(900,900,FX2D);
  // fullScreen(FX2D);
}

public void setup() {
  imageMode(CENTER);

  MY_SCALE = (width / 5);
  COLS = (int) Math.ceil(width / MY_SCALE);
  ROWS = (int) Math.ceil(height / MY_SCALE) + 1;
  tiles = new Tile[COLS][ROWS];

  tex = loadImage("textures/tex2.jpg");
  tex.resize(MY_SCALE, MY_SCALE);
  pg = createGraphics(MY_SCALE, MY_SCALE);
  pg.beginDraw();
  pg.image(tex, 0, 0);
  pg.strokeWeight(1);
  pg.stroke(127);
  //pg.noStroke();
  pg.fill(0);
  //pg.noFill();
  pg.arc(MY_SCALE, MY_SCALE, MY_SCALE, MY_SCALE, 0, (float) ((TWO_PI + PI) * 0.5));
  pg.arc(0, 0, MY_SCALE, MY_SCALE, 0, HALF_PI);
  pg.endDraw();

  for (int x = COLS - 1; x >= 0; x--) {
    for (int y = ROWS - 1; y >= 0; y--) {
      tiles[x][y] = new Tile(x, y, pg);
    }
  }
}

public void draw() {

  perlin.apply(tiles, 0.5f);
  //random.apply(tiles, 1);

  if (frameCount <= 3600) {
    //Processing is *much* faster at generating .tif files than .png files.
    //saveFrame("upload/frame-####.png");
    surface.setTitle(frameCount + "");
  } else {
    exit();
  }
}
