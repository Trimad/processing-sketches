float x = 0;
float y = 0;

float[][] magicX = {  
  {0.00, 0.00},
  {0.85, 0.04},
  {0.20, -0.26}, 
  {-0.15, 0.28}
};

float[][] magicY = {  
  {0.16, 0.00, 0.00}, 
  {-0.04, 0.85, 1.6}, 
  {0.23, 0.22, 1.6}, 
  {0.26, 0.24, 0.44}
};

int iterations = Integer.MAX_VALUE>>6;

void setup() {
  size(9001, 9001);
  background(0);
  histogram = new int[width][height];
}

void draw() {
loadPixels();

//This first pass draws the Barnsley Fern like normal.
  for (int i = 0; i < iterations; i++) {
    getBackgroundPoint();
    drawPoint();
  }
//Clear the histogram for the second pass.
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      histogram[x][y]=0;
    }
  }
  highest = 0;
// The second pass draws only the "leaves" of the Barnsley Fern.
// I did this so that the "stem" is in the background while the "leaves"
// are in the foreground. It looks more plant-like this way.
  for (int i = 0; i < iterations; i++) {
    getForegroundPoint();
    drawPoint();
  }
  
updatePixels();

  saveFrame("frame-####.jpg");
  exit();
}

void getForegroundPoint() {

  float dx = 0;
  float dy = 0;

  float r1 = 0.01+random(1);
  if (r1 < 0.01) {
    //1
    dx =  magicX[0][0];
    dy = magicY[0][0] * y;
  } else if (r1 < 0.86 ) {
    //2
    dx = magicX[1][0] * x + magicX[1][1] * y;
    dy = magicY[1][0] * x + magicY[1][1] * y + magicY[1][2];
  } else if (r1 < 0.93) {
    //3
    dx = magicX[2][0] * x + magicX[2][1] * y;
    dy = magicY[2][0] * x + magicY[2][1] * y + magicY[2][2];
  } else {
    //4
    dx = magicX[3][0] * x + magicX[3][1] * y;
    dy = magicY[3][0] * x + magicY[3][1] * y + magicY[3][2];
  }

  x = dx;
  y = dy;
}

void getBackgroundPoint() {

  float dx = 0;
  float dy = 0;

  float r1 = random(1);
  if (r1 < 0.01) {
    //1
    dx =  magicX[0][0];
    dy = magicY[0][0] * y;
  } else if (r1 < 0.86 ) {
    //2
    dx = magicX[1][0] * x + magicX[1][1] * y;
    dy = magicY[1][0] * x + magicY[1][1] * y + magicY[1][2];
  } else if (r1 < 0.93) {
    //3
    dx = magicX[2][0] * x + magicX[2][1] * y;
    dy = magicY[2][0] * x + magicY[2][1] * y + magicY[2][2];
  } else {
    //4
    dx = magicX[3][0] * x + magicX[3][1] * y;
    dy = magicY[3][0] * x + magicY[3][1] * y + magicY[3][2];
  }

  x = dx;
  y = dy;
}

int[][] histogram;
int highest = 0;

void drawPoint() {
  // This bound adjusts the draw space so that it is a perfect square in the middle of 
  // a 16:9 aspect ratio canvas.
  int bound = (width-height)/2;
  int px = (int)map(x, -2.1820, 2.6558, bound, width-bound);
  int py = (int)map(y, 0, 9.9983, height, 0);

  histogram[px][py]++;

  if (histogram[px][py] > highest) {
    highest = histogram[px][py];
  }

  if (highest > 1) {
    float m = map(histogram[px][py], 0, customLog(highest), 0, 1);
    color from = color(#123556);
    color to = color(255);
    color l = lerpColor(from, to, m);
    pixels[py*width+px] = l;
  }
}

public static int customLog(int x) {
  return (int) (Math.log(x)/Math.log(1.1));
}
