import java.util.Arrays;

private PImage img = createImage(2560, 1440, RGB); //2 RESOLUTION
public static float [][][] grid;
public static float mx = 0.0;
public static float my = 0.0;
public static float scaleX = 2;
public static float scaleY = 2;

public static int SCALE = 8;

Graph graph = new Graph();
Buddhabrot bb = new Buddhabrot(5000);
Mandelbrot mb = new Mandelbrot(255);
Nebulabrot nb = new Nebulabrot(Short.MAX_VALUE);
JuliaSet js = new JuliaSet(255);

void set_scene() {

  float aspect = (float)img.width/img.height;
  if (aspect<1) {
    scaleY /=aspect;
  } else {
    scaleX *= aspect;
  }

  grid = new float[img.width][img.height][5];
  full_reset();
}


void setup() {
  key = '2';
  strokeCap(SQUARE);
  textSize(16);

  set_scene();
}

void draw() {
  bb.plot();
  //bb.findMaxExposure();
  bb.show();
  //if (frameRate < 10) {
  //  mb.ITERATIONS=0;
  //}
  //mb.ITERATIONS++;

  //  switch(key) {

  //    //Buddahbrot
  //  case ' ': 
  //    full_reset();
  //    break;
  //  case '1':
  //    if (!drag) {
  //      mb.iterate();
  //      mb.show();
  //    } else {
  //      mb.show_reduced();
  //      graph.show();
  //    }
  //    break;
  //  case '2':
  //    if (!drag) {
  //      bb.plot();
  //      bb.findMaxExposure();
  //      bb.show();
  //    } else {
  //      bb.show_reduced();
  //      graph.show();
  //    }
  //    break;
  //    //Mandelbrot
  //  case '3':
  //    if (!drag) {
  //      nb.plot();
  //      nb.findMaxExposure();
  //      nb.show();
  //    } else {
  //      nb.show_reduced();
  //      graph.show();
  //    }
  //    break;
  //    //Julia Set
  //  case '4':
  //    if (!drag) {
  //      js.iterate();
  //      js.show();
  //    } else {
  //      js.show_reduced();
  //      graph.show();
  //    }
  //    break;
  //  }

  //xOffset+=0.0004;
  xOffset+=0.000341;
  //yOffset+=0.05;
  full_reset();
  System.out.println(xOffset);

  if (frameCount > 17601) {
    exit();
  }
}

boolean drag = false;

void keyReleased() {
  wipe_pixels();
}
void mousePressed() {
  drag = true;
}

void mouseReleased() {
  drag = false;
  center_scene_on_mouse();
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();

  if (e < 0) {
    zoom(0.90);
  } else {
    zoom(1.10);
  }
}

void center_scene_on_mouse() {

  //mx = map(, grid, width, -2, 2);
  mx = grid[width>>1][height>>1][0]-grid[mouseX][mouseY][0];
  my = grid[width>>1][height>>1][1]-grid[mouseX][mouseY][1];
  //my = map(mouseY, 0, height, -2, 2);

  for (int x = width-1; x >= 0; x--) {
    for (int y = height-1; y >= 0; y--) {
      grid[x][y][0]-=mx;
      grid[x][y][1]-=my;
      grid[x][y][2]=0;
      grid[x][y][3]=0;
      grid[x][y][4]=0;
    }
  }
}

void zoom(float howMuch) {

  for (int x = width-1; x >= 0; x--) {
    for (int y = height-1; y >= 0; y--) {
      grid[x][y][0]*=howMuch;
      grid[x][y][1]*=howMuch;
      grid[x][y][2]=0;
      grid[x][y][3]=0;
      grid[x][y][4]=0;
    }
  }
}

void wipe_pixels() {
  for (int x = width-1; x >= 0; x--) {
    for (int y = height-1; y >= 0; y--) {
      grid[x][y][2]=0;
      grid[x][y][3]=0;
      grid[x][y][4]=0;
    }
  }
}

float xOffset = 1.0;
float yOffset = 0.0;

void full_reset() {
  for (int x = 0; x < img.width; x++) {
    float rx = map(x, 0, img.width, -(scaleX-xOffset), (scaleX-xOffset));
    for (int y = 0; y < img.height; y++) {
      float iy = map(y, 0, img.height, -(scaleY-yOffset), (scaleY-yOffset));

      grid[x][y][0] = rx;//real
      grid[x][y][1] = iy;//imaginary
      grid[x][y][2] = 0;//red
      grid[x][y][3] = 0;//green
      grid[x][y][4] = 0;//blue
    }
  }
}
