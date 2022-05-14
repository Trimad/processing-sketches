PImage []utopia;
int utopiaIndex=0;
PImage []dystopia;
int dystopiaIndex=0;

float maxLength = 0;
final float STEP = (TWO_PI/720);
float angle = 0;

int HALF_HEIGHT;

void settings() {
  //size(1024, 512);
  size(1920, 1920>>1);
  //fullScreen();
  HALF_HEIGHT = height>>1;
  smooth(8);
}

Clock clock;
StaticCurve sc;
PFont f;

void setup() {

  f = createFont("carbon.ttf", 32);
  utopia = new PImage[1];
  dystopia = new PImage[1];

  utopia[0] = loadImage("aleppo_good.png");
  utopia[0].resize(width, height);
  dystopia[0] = loadImage("aleppo_bad.png");
  dystopia[0].resize(width, height);

  clock = new Clock(new PVector(width*0.25, height>>1), height);
  sc = new StaticCurve(new PVector(width*0.75, height>>1), height);

}

PImage updatedMask(float howHigh) {

  PImage imgMask;
  imgMask = createImage(width, height, RGB);
  imgMask.loadPixels();

  for (int i = getHeight(howHigh); i < imgMask.pixels.length; i++) {
    imgMask.pixels[i] = 255;
  }
  imgMask.updatePixels();
  return imgMask;
}

void draw() {
  clock.tick();
  stroke(240);
  strokeWeight(2);
  PVector a = clock.getPosition();
  sc.setPosition(a);
  PVector b = sc.getPosition();

  float f = (a.y+b.y)/2;
  utopia[utopiaIndex].mask(updatedMask(f));
  image(dystopia[0], 0, 0);
  image(utopia[0], 0, 0);

  sc.layerA();
  clock.layerA();
  line(a.x, a.y, b.x, b.y);
  sc.layerB();
  clock.layerB();

  saveFrame("frames/line-######.png");

  if (frameCount>720) {
    exit();
  }
}

int getHeight(float yPosition) {
  float m = height/yPosition;
  return floor(width * height/m);
}
