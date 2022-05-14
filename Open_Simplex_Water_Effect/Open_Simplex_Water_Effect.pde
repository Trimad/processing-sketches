int cols, rows;
int scl = 5;

float[][] terrain;

//OpenSimplexNoise specific variables
int totalFrames = 600;
float increment = 0.07;

OpenSimplexNoise noise;

void setup() {
  size(1024,1024, P3D);
  cols = width / scl+1;
  rows = height / scl+1;
  terrain = new float[cols][rows];

  noise = new OpenSimplexNoise();
}

float zoff = 0;
void draw() {
  //background(0);
  ortho();
  lights();

  float yoff = 0;
  for (int y = 0; y < rows; y++) {
    float xoff = 0;
    for (int x = 0; x < cols; x++) {
      float n = (float) noise.eval(xoff, yoff, zoff);
      int bright = round(map(n, -1, 1, -1000, 100));
      terrain[x][y] = bright;
      xoff += increment;
    }
    yoff += increment;
  }
  zoff += increment;

  drawTerrain();
}

void drawTerrain() {

  //stroke(0, 137, 0);
  noStroke();

  fill(0, 100, 255);

  //translate(width>>1, height/2);
  //rotateX(PI/4);
  //translate(-width>>1, -height/2);
  for (int y = 0; y < rows-1; y++) {

    beginShape(TRIANGLE_STRIP);
    for (int x = 0; x < cols; x++) {

      vertex(x*scl, y*scl, terrain[x][y]);
      vertex(x*scl, (y+1)*scl, terrain[x][y+1]);
      //rect(x*scl, y*scl, scl, scl);
    }
    endShape();
  }
}
