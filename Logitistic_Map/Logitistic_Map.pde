int[][] histogram;
int highest = 0;
float startX = 0;
float stopX = 4.0;
void setup() {
  size(2560, 1440);
  colorMode(HSB, 400);
  histogram = new int[width][height];
  //fullScreen();
  //debug();
  //exit();
}

void draw() {
  clear();
  background(0);
  startX = log3600(frameCount)*4;
  for (int i = 0; i < 100000; i++) {
    expose();
  }

  loadPixels();
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      int val = histogram[x][y];
      if (val > 0) {
        float m = constrain(logHighest(val), 0, 1);
        //println(m);
        pixels[y*width+x]=color(m*400);
      } else {
        pixels[y*width+x]=0xFF000000;
      }
    }
  }
  updatePixels();
  saveFrame("/frames/####.png");
  if(frameCount>3600){exit();}
}

float logHighest (int x) {
  return (log(x) / log(highest));
}

float log3600 (int x) {
  return (log(x) / log(3600));
}

float nextYearsPopulation(float f, float p) {
  float answer = f*p*(1-p);
  return answer;
}

void expose() {
  float fertility = random(startX, stopX);
  float population = 0.5;
  for (int i = 0; i <= 1024; i++) {
    population = nextYearsPopulation(fertility, population);
    int px = (int)map(fertility, startX, stopX, 0, width-1);
    int py = (int)map(population, 0, 1, height-1, 0);
    if (i >= 512) {
      highest = max(histogram[px][py]++, highest);
    }
  }
}

void clear() {
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      histogram[x][y] = 0;
    }
  }
}
