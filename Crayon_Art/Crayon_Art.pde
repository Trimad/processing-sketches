
import peasy.PeasyCam;

int vScale = 1;
PeasyCam cam;

//MyImage as a name doesn't make sense 
ArrayList<MyImage> myImage = new ArrayList<MyImage>();

static PVector[] BOX_8 = {Crayola.RED, Crayola.YELLOW, Crayola.BLUE, Crayola.BROWN, Crayola.ORANGE, Crayola.GREEN, Crayola.VIOLET, Crayola.BLACK};
static PVector[] BOX_16 = {Crayola.RED, Crayola.YELLOW, Crayola.BLUE, Crayola.BROWN, Crayola.ORANGE, Crayola.GREEN, Crayola.VIOLET, Crayola.BLACK, Crayola.RED_VIOLET, Crayola.RED_ORANGE, Crayola.YELLOW_GREEN, Crayola.BLUE_VIOLET, Crayola.CARNATION_PINK, Crayola.YELLOW_ORANGE, Crayola.BLUE_GREEN, Crayola.WHITE };
static PVector[] BOX_24 = {Crayola.RED, Crayola.YELLOW, Crayola.BLUE, Crayola.BROWN, Crayola.ORANGE, Crayola.GREEN, Crayola.VIOLET, Crayola.BLACK, Crayola.RED_VIOLET, Crayola.RED_ORANGE, Crayola.YELLOW_GREEN, Crayola.BLUE_VIOLET, Crayola.CARNATION_PINK, Crayola.YELLOW_ORANGE, Crayola.BLUE_GREEN, Crayola.WHITE, Crayola.VIOLET_RED, Crayola.APRICOT, Crayola.GREEN_YELLOW, Crayola.INDIGO, Crayola.SCARLET, Crayola.DANDELION, Crayola.CERULEAN, Crayola.GRAY };

PVector[] crayonBox = BOX_8;

PImage img;

void setup() {
  fullScreen(P3D);
  //size(1024, 1024, P3D);
  cam = new PeasyCam(this, 400);
  img = loadImage("face2.jpg");
  //img.resize(128, 128);
  //img.filter(GRAY);
  //img.filter(POSTERIZE, 16);
  dither(3);

  img.loadPixels();
  for (int x = 0; x < img.width/vScale; x +=vScale) {
    for (int y = 0; y < img.height/vScale; y +=vScale) {
      color c = img.get(x*vScale, y*vScale);
      float r = red(c);
      float g = green(c);
      float b = blue(c);

      PVector rgb = new PVector(r, g, b);
      PVector position = new PVector(x, y, 0);
      myImage.add(new MyImage(rgb, position));
    }
  }

  //imageMode(CENTER);


  for (int i = myImage.size()-1; i >= 0; i--) {
    float shortestDistance = 9999;
    PVector closestColor;
    for (int j = crayonBox.length-1; j >= 0; j--) {  

      PVector p = myImage.get(i).originalColors;
      PVector c = crayonBox[j];
      float d = p.dist(c);

      if (d < shortestDistance) {
        shortestDistance = d;
        closestColor = c;
        myImage.get(i).setMappedColors(closestColor);
      }
    }
  }
}

void draw() {
  background(0);
  //translate(width>>1, height>>1, img.height*0.5);

  //image(img, width>>1, height>>1);
  image(img, -img.width, -img.height);
  for (int i = myImage.size()-1; i >= 0; i--) {
    strokeWeight(8);
    myImage.get(i).showoriginalColors();
    myImage.get(i).showMappedColors();
    strokeWeight(1);
    myImage.get(i).showPlot();
  }
  strokeWeight(16);
  for (int i = crayonBox.length-1; i >= 0; i--) {
    float x = crayonBox[i].x;
    float y = crayonBox[i].y;
    float z = crayonBox[i].z;
    stroke(x, y, z);
    point(x, y, z);
  }

  toggleGuideLines(keyPressed);
}

void toggleGuideLines(boolean state) {
  float  lineLength = 1024;
  if (key == ' ' && state) {

    strokeWeight(3);

    //x-axis, red positive
    stroke(255, 0, 0);
    line(0, 0, 0, lineLength, 0, 0);
    //x-axis, red negative
    stroke(127, 0, 0);
    line(0, 0, 0, -lineLength, 0, 0);

    //y-axis, green positive
    stroke(0, 255, 0);
    line(0, 0, 0, 0, lineLength, 0);
    //y-axis, green negative
    stroke(0, 127, 0);
    line(0, 0, 0, 0, -lineLength, 0);

    //z-axis, blue positive
    stroke(0, 0, 255);
    line(0, 0, 0, 0, 0, lineLength);
    //z-axis, blue negative 
    stroke(0, 0, 127);
    line(0, 0, 0, 0, 0, -lineLength);
  }
}

int index(int x, int y) {
  return x + y * img.width;
}

void dither(int factor) {
  img.loadPixels();
  for (int y = 0; y < img.height-1; y++) {
    for (int x = 1; x < img.width-1; x++) {
      color pix = img.pixels[index(x, y)];
      float oldR = red(pix);
      float oldG = green(pix);
      float oldB = blue(pix);
      int newR = round(factor * oldR / 255) * (255/factor);
      int newG = round(factor * oldG / 255) * (255/factor);
      int newB = round(factor * oldB / 255) * (255/factor);
      img.pixels[index(x, y)] = color(newR, newG, newB);

      float errR = oldR - newR;
      float errG = oldG - newG;
      float errB = oldB - newB;


      int index = index(x+1, y  );
      color c = img.pixels[index];
      float r = red(c);
      float g = green(c);
      float b = blue(c);
      r = r + errR * 7/16.0;
      g = g + errG * 7/16.0;
      b = b + errB * 7/16.0;
      img.pixels[index] = color(r, g, b);

      index = index(x-1, y+1  );
      c = img.pixels[index];
      r = red(c);
      g = green(c);
      b = blue(c);
      r = r + errR * 3/16.0;
      g = g + errG * 3/16.0;
      b = b + errB * 3/16.0;
      img.pixels[index] = color(r, g, b);

      index = index(x, y+1);
      c = img.pixels[index];
      r = red(c);
      g = green(c);
      b = blue(c);
      r = r + errR * 5/16.0;
      g = g + errG * 5/16.0;
      b = b + errB * 5/16.0;
      img.pixels[index] = color(r, g, b);


      index = index(x+1, y+1);
      c = img.pixels[index];
      r = red(c);
      g = green(c);
      b = blue(c);
      r = r + errR * 1/16.0;
      g = g + errG * 1/16.0;
      b = b + errB * 1/16.0;
      img.pixels[index] = color(r, g, b);
    }
  }
  img.updatePixels();
}
