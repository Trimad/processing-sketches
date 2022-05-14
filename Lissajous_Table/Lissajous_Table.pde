import java.util.Arrays;


int cols, rows, w;
float angle = 0;
float DIAMETER, RADIUS;
Curve[][] curves;

void setup() {
  fullScreen(P2D);
  w = width>>4;
  DIAMETER = w-2;
  RADIUS = DIAMETER*0.5;
  frameRate(144);
  noSmooth();
  noFill();
  cols = width/w-1;
  rows = height/w-1;
  curves = new Curve[rows][cols];

  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      curves[j][i] = new Curve();
    }
  }
}

void spin() {
  translate(width/2, 0);
  rotateY(angle);
  translate(-width/2, 0);
}

void draw() {
  //spin();
  background(0);
  stroke(255);

  for (int i = 0; i < cols; i++) {
    float cx = w+(i*w)+(w*0.5);
    float cy = w*0.5;
    float x = RADIUS * cos(angle*(i+1)-(HALF_PI));
    float y = RADIUS * sin(angle*(i+1)-(HALF_PI));
    stroke(255);
    strokeWeight(1);
    ellipse(cx, cy, DIAMETER, DIAMETER);
    stroke(127, 0, 0);
    line(cx+x, 0, cx+x, height);
    stroke(255);
    strokeWeight(10);
    point(cx + x, cy+y);
    for (int j = 0; j < rows; j++) {
      curves[j][i].setCursorX(cx+x);
    }
  }

  for (int j = 0; j < rows; j++) {
    float cx = w*0.5;
    float cy = w+(j*w)+(w*0.5);
    float x = RADIUS * cos(angle*(j+1)-(HALF_PI));
    float y = RADIUS * sin(angle*(j+1)-(HALF_PI));
    stroke(255);
    strokeWeight(1);
    ellipse(cx, cy, DIAMETER, DIAMETER);
    stroke(0, 127, 0);
    line(0, cy+y, width, cy+y);
    stroke(255);
    strokeWeight(10);
    point(cx + x, cy+y);
    for (int i = 0; i < cols; i++) {
      curves[j][i].setCursorY(cy+y);
    }
  }

  for (int j = 0; j < rows; j++) {
    for (int i = 0; i < cols; i++) {
      curves[j][i].addPoint();
      curves[j][i].show();
    }
  }

  angle -= 0.01;
}
