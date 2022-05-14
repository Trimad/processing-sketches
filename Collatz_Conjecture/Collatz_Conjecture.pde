import java.util.*;

int howMany = 361;
int howManyFrames = 9840; //2:44 @ 60FPS
int size=30;

Stack[] stacks = new Stack[howMany];
Turtle[] turtles = new Turtle[howMany];

void setup() {
  size(1080,1080, P3D);
  //fullScreen(P3D);
  background(0);
  textAlign(LEFT, CENTER);
  textSize(size);

  for (int i = 0; i < howMany; i++) {
    stacks[i] = new Stack();
    collatz(i, stacks[i]);
  }

  for (int i = 0; i < howMany; i++) {
    turtles[i] = new Turtle(width/4, height/4, stacks[i]);
  }
}

public void collatz(int n, Stack s) {
  s.add(n);
  if (n == 1 || n==0) return;
  else if (n % 2 == 0) collatz(n / 2, s);
  else collatz(3*n + 1, s);
}

void draw() {
  translate(width/2, height/2, -1750);
  for (int i = 1; i < howMany; i++) {
    float m = map(i, 0, howMany-2, 0, (float)Math.PI*2);
    rotateZ(-m);  
    turtles[i].crawl();
    rotateZ(m);
  }
/*
  if (frameCount<howManyFrames+1) {
    saveFrame("frame-####.png");
  } else {
    exit();
  }
  */
}

void keyTyped() {


  if (int(key) ==32) {
    saveFrame("frame-####.png");
  }
}
