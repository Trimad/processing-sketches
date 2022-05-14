PImage img1;
PImage img2;
PImage imgMask;
int totalFrames = 60;
boolean record = true;
float increment = 0.008;

// Just for non-looping demo
float zoff = 0;

OpenSimplexNoise noise;

void setup() {
  size(1080, 1080);
  img1 = loadImage("textures/texture06.jpg");
  img1.resize(width, height);
  img2 = loadImage("textures/texture03.jpg");
  img2.resize(width, height);
  imgMask = createImage(width, height, ALPHA);

  noise = new OpenSimplexNoise();
}

void draw() {

  float percent = 0;

  if (record) {
    percent = float(frameCount) / totalFrames;
  } else {
    percent = float(frameCount % totalFrames) / totalFrames;
  }
  render(percent);
  image(img2, 0, 0);
  img1.mask(imgMask);
  image(img1, 0, 0);

  if (record) {
    saveFrame("output/gif-"+nf(frameCount, 3)+".png");
    if (frameCount == totalFrames) {
      exit();
    }
  }
}

void render(float percent) {
  float angle = map(percent, 0, 1, 0, TWO_PI);
  float uoff = map(sin(angle), -1, 1, 0, 1);
  float voff = map(cos(angle), -1, 1, 0, 1);
  float xoff = 0;

  imgMask.loadPixels();
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
      float bright = map(n, 0, 1, 0, 255);
      imgMask.pixels[x + y * width] = color(bright);
      yoff += increment;
    }
    xoff += increment;
  }
  imgMask.updatePixels();

  if (!record) {
    zoff += increment;
  }
  
}
