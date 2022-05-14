final String fileName = "zebra.png"; 

ArrayList<Circle> circles;
PGraphics pg;
PImage img;

LoadingBar progress = new LoadingBar(); //not working
void settings() {
  img = loadImage(fileName);
  //img.filter(INVERT);
  //size(img.width, img.height, P2D);
  //img.resize(img.width*4, img.height*4);
  img.resize(9000, 9000);
  //img.filter(GRAY);
  img.filter(POSTERIZE, 3);
}
void setup() {
  img.loadPixels();
  surface.setResizable(false); 
  circles = new ArrayList<Circle>();
  pg = createGraphics(img.width, img.height);
  pg.rectMode(CENTER);
  pg.ellipseMode(CENTER);
  pg.noStroke();
}

void draw() {
  pg.beginDraw();
  pg.background(0, 0);

  for (int i = 0; i < 10; i++) {
    runAlgorithm(1000);
    float progress = map(i, 0, 9, 0, 100);
    println(progress+"% COMPLETE!");
  } 

  for (Circle c : circles) {
    c.show();
  }

  pg.endDraw();
  pg.save("output/"+fileName+"-circle-packed.png");
  //PImage canvas = this.get();
  //canvas.format = ARGB;
  //canvas.save("test.png");
  exit();
}

void runAlgorithm(int iterations) {

  for (int i = 0; i < iterations; i++) {
    progress.update(i, iterations);
    progress.show();
    //float m = map(i, 0, iterations, 0, 50);
    if (generate()) {
      break;
    }
  }

  for (int i = circles.size()-1; i > 0; i--) {
    if (circles.get(i).smallerThan(3)) {
      circles.remove(circles.get(i));
    }
  }
}

boolean generate() {

  boolean finished = false;
  int total = 75;
  int count = 0;
  int failureAttempts = 0;
  int failureThreshold = 500;

  while (count <  total) {
    Circle newC = newCircle();
    if (newC != null) {
      circles.add(newC);
      count++;
    }

    if (failureAttempts++ > failureThreshold) {
      finished = true;
      println("FAILURE THRESHOLD REACHED!");
      break;
    }
  }


  for (Circle c : circles) {
    if (c.growing) {
      if (c.edges()) {
        c.growing = false;
      } else {
        for (Circle other : circles) {
          if (c != other) {
            float d = dist(c.x, c.y, other.x, other.y);
            if (d - 2 < c.r + other.r) {
              c.growing = false;
              break;
            }
          }
        }
      }
    }
    c.grow();
  }

  return finished;
}

public Circle newCircle() {

  int x = int(random(img.width));
  int y = int(random(img.height));

  boolean valid = true;

  //Check for valid location
  for (Circle c : circles) {
    float d = dist(x, y, c.x, c.y);
    if (d < c.r) {
      valid = false;
      break;
    }
  }

  //Check for valid color
  int index = (x + y * img.width);
  color col = img.pixels[index];
  //Alpha color value
  float a = (img.pixels[index] >> 24)& 0xFF;
  //Red color value
  float r = (img.pixels[index] >> 16)& 0xFF;
  //Green color value
  float g = (img.pixels[index] >> 8)& 0xFF;
  //Blue color value
  float b = (img.pixels[index] >> 0)& 0xFF;
  //Brightness
  float rgb = (r+g+b)/3;

  //If black or transparent
  if (a ==0) {
    valid = false;
  }
  //Place a new circle if valid
  if (valid) {
    return new Circle(x, y, col);
  } else {
    return null;
  }
}

//public void mouseReleased() {
//  for (Circle c : circles) {
//    float d = dist(mouseX, mouseY, c.x, c.y);
//    if (d < c.r) {
//      circles.remove(c);
//      break;
//    }
//  }
//}
