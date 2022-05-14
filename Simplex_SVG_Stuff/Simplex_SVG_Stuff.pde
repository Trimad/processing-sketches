int totalFrames = 60;
int counter = 0;
boolean record = true;

float increment = 0.02; //smaller values zoom in, larger 1values zoom out

// Just for non-looping demo
float zoff = 0;

OpenSimplexNoise noise;
void setup() {
  size(400, 600);
  noise = new OpenSimplexNoise();
}

void draw() {
  background(0);
  surface.setTitle ("FPS: " + frameRate);
  float percent = 0;
  if (record) {
    percent = float(counter) / totalFrames;
  } else {
    percent = float(counter % totalFrames) / totalFrames;
  }
  render(percent);
  if (record) {
    saveFrame("frames/"+nf(counter, 4)+".png");
    if (counter == totalFrames-1) {
      exit();
    }
  }
  counter++;
}

void render(float percent) {
  float angle = map(percent, 0, 1, 0, TWO_PI);
  float uoff = map(cos(angle), -1, 1, 0, 2);//mapping to an arbitrary value
  float voff = map(sin(angle), -1, 1, 0, 2);//mapping to an arbitrary value
  //color randomColor = color(random(127, 255), random(127, 255), random(127, 255));
  float xoff = 0;
  loadPixels();
  for (int x = 0; x < width; x++) {
    float yoff = 0;
    for (int y = 0; y < height; y++) {
      float n;
      if (record) {
        // 4D Open Simplex Noise is very slow!
        n = (float) noise.eval(xoff, yoff, uoff, voff);
      } else {
        // If you aren't worried about looping run this instead for speed!
        n = (float) noise.eval(xoff, yoff, zoff);
      }
      float bright = n > 0 ? 255 : 0;
      pixels[x + y * width] =  color(bright);
      yoff += increment;
    }
    xoff += increment;
  }
  updatePixels();

  zoff += increment;
}
