PImage img;
PVector A_VECTOR, B_VECTOR, buffer_vector;
int threshold = 1;
int A, B;
void setup() {
  img = loadImage("combined_tiled.png");
  //img.loadPixels();
  //img.filter(POSTERIZE, 5);
  //img.updatePixels();
  size(2560, 1440);
  snapshot = new int[img.pixels.length];
}

void draw() {
  image(img, 0, 0);

  int a_red = (A >> 16) & 0xFF;
  int a_green = (A >> 8) & 0xFF;
  int a_blue = (A >> 0) & 0xFF;

  int b_red = (B >> 16) & 0xFF;
  int b_green = (B >> 8) & 0xFF;
  int b_blue = (B >> 0) & 0xFF;

  A_VECTOR = new PVector(a_red, a_green, a_blue);
  B_VECTOR = new PVector(b_red, b_green, b_blue);

  noStroke();
  fill(0);
  text("a: "+A, mouseX+20, mouseY);
  text("b: "+B, mouseX+20, mouseY+20);
  text("dist: "+A_VECTOR.dist(B_VECTOR), mouseX+20, mouseY+40);
  text("threshold: "+threshold, mouseX+20, mouseY+60);
}


void mousePressed() {
  if (mouseButton == LEFT) {
    A = get(mouseX, mouseY);
    println("LEFT: "+mouseX+", "+mouseY+", "+A);
  } else if (mouseButton == RIGHT) {
    B = get(mouseX, mouseY);
    println("RIGHT: "+mouseX+", "+mouseY+", "+B);
  } else if (mouseButton == CENTER) {
    println("CENTER: "+A+", "+B);
    swap1D(A, B);
  }
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  threshold-=(int)e*10;
}


int[] snapshot;

void swap1D(int a, int b) {

  img.loadPixels();
  int[] buffer = new int[img.pixels.length];
  for (int i = 0; i < img.pixels.length; i++) {
    snapshot[i] = img.pixels[i];
    buffer[i] = img.pixels[i];
  }

  for (int i = 0; i < img.pixels.length; i++) {

    //if (buffer[i] ==a) {
    //  img.pixels[i] = b;
    //}
    //if (buffer[i] == b) {
    //  img.pixels[i] = a;
    //}

    int buffer_red = (buffer[i] >> 16) & 0xFF;
    int buffer_green = (buffer[i] >> 8) & 0xFF;
    int buffer_blue = (buffer[i] >> 0) & 0xFF;


    buffer_vector = new PVector(buffer_red, buffer_green, buffer_blue);

    if (buffer_vector.dist(A_VECTOR)<threshold) {
      img.pixels[i] = b;
    }
    if (buffer_vector.dist(B_VECTOR)<threshold) {
      img.pixels[i] = a;
    }
    //println(a_vector.dist(b_vector));

    //int[] tupleA = getThresholds(a);
    //if (buffer[i] > tupleA[0] && buffer[i] < tupleA[1]) {
    //  img.pixels[i] = b;
    //}
    //int[] tupleB = getThresholds(b);
    //if (buffer[i] > tupleB[0] && buffer[i] < tupleB[1]) {
    //  img.pixels[i] = a;
    //}
  }
  img.updatePixels();
}

int[] getThresholds(int argb) {
  int a = (argb >> 24) & 0xFF;
  int r = (argb >> 16) & 0xFF;
  int g = (argb >> 8) & 0xFF;
  int b = argb & 0xFF;
  int[] tuple = new int[2];
  tuple[0] = 255 << 24 | (int)constrain(r-threshold, 0, r-threshold) << 16 | (int)constrain(g-threshold, 0, g-threshold) << 8 | (int)constrain(b-threshold, 0, b-threshold) << 0;
  //println(tuple[0]);
  tuple[1] = 255 << 24 | (int)constrain(r+threshold, r+threshold, 255) << 16 | (int)constrain(g+threshold, g+threshold, 255) << 8 | (int)constrain(b+threshold, b+threshold, 255) << 0;
  //println(tuple[1]);
  return tuple;
}

void keyTyped() {

  img.loadPixels();
  for (int i = 0; i < img.pixels.length; i++) {
    img.pixels[i] = snapshot[i];
  }
  img.updatePixels();
}
