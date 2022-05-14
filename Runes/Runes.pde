PFont myFont;
int totalFrames = 600;
int counter = 0;
boolean record = true;
float increment = 0.04;

// Just for non-looping demo
float zoff = 0;
int scale = 30;
int SCALED_WIDTH;
int SCALED_HEIGHT;
SymbolTile[][] tiles;
OpenSimplexNoise noise;

void setup() {

  //size(1920, 1080);
  size(3840, 2160);
  //textMode(MODEL);

  SCALED_WIDTH = width/scale;
  SCALED_HEIGHT = height/scale;
  tiles = new SymbolTile[SCALED_WIDTH][SCALED_HEIGHT];
  noise = new OpenSimplexNoise();

  for (int x = 0; x < SCALED_WIDTH; x++) {
    for (int y = 0; y < SCALED_HEIGHT; y++) {
      tiles[x][y] = new SymbolTile(x, y);
    }
  }


  textAlign(CENTER, CENTER);
  myFont = createFont("RUNE.TTF", scale);
  textFont(myFont);

  //textSize(scale);
}

void draw() {
  background(0);
  float percent = 0;
  if (record) {
    percent = float(counter) / totalFrames;
  } else {
    percent = float(counter % totalFrames) / totalFrames;
  }
  render(percent);
  if (record) {
    saveFrame("output/gif-"+nf(counter, 3)+".png");
    if (counter == totalFrames-1) {
      exit();
    }
  }
  counter++;
}

void render(float percent) {

  float angle = map(percent, 0, 1, 0, TWO_PI);
  float uoff = map(sin(angle), -1, 1, 0, 2);
  float voff = map(sin(angle), -1, 1, 0, 2);
  float xoff = 0;

  for (int x = 0; x < SCALED_WIDTH; x++) {
    float yoff = 0;
    for (int y = 0; y < SCALED_HEIGHT; y++) {
      float n;
      if (record) {
        // 4D Open Simplex Noise is very slow!
        n = (float) noise.eval(xoff, yoff, uoff, voff);
      } else {
        // If you aren't worried about looping run this instead for speed!
        n = (float) noise.eval(xoff, yoff, zoff);
      }
      //float bright = n > 0 ? 255 : 0;

      int bright = round(map(n, -1, 1, 97, 122));

      //pixels[x + y * width] = color(bright);
      tiles[x][y].update(bright);
      tiles[x][y].show(bright);
      //pixels[x + y * SCALED_WIDTH] = color(bright);
      yoff += increment;
    }
    xoff += increment;
  }

  zoff += increment;
}
