ArrayList<Firework> fireworks;

PVector gravity = new PVector(0, 0.15);

void setup() {
  fireworks = new ArrayList<Firework>();
  colorMode(HSB);
  background(51);
}

void draw() {
  if (random(1) < 0.08) {
    fireworks.add(new Firework());
  }
  fill(51, 50);
  noStroke();
  rect(0,0,width,height);
  //background(255, 20);

  
  for (int i = fireworks.size()-1; i >= 0; i--) {
    Firework f = fireworks.get(i);
    f.run();
    if (f.done()) {
      fireworks.remove(i);
    }
  }
  
  
  
}

void settings() {  
  size(480, 640, P3D);
}
