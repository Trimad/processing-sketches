int[][] histogram;
int highest = 0;
float startX = 0;
float stopX = 4.0;
void setup() {
  size(2160, 2160);
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
        int m = floor(logHighest(val)*256);
        pixels[y*width+x]=color(m, m, 255);
      } else {
        pixels[y*width+x]=color(0);
      }
    }
  }
  updatePixels();
  saveFrame("/frames/####.png");
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
  for (int i = 0; i <= 512; i++) {
    population = nextYearsPopulation(fertility, population);
    int px = (int)map(fertility, startX, stopX, 0, width-1);
    int py = (int)map(population, 0, 1, height-1, 0);
    if (i >= 256) {
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
