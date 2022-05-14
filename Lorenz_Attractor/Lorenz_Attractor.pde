float x = 0.01;
float y = 0.01;
float z = 0.01;

//THese input constants 
float a = 10;
float b = 28;
float c = 8/3.0;

ArrayList<PVector>points = new ArrayList<PVector>();

void setup () {
  size(1920, 1080, P3D);
}

void draw() {

  background(0);

  float dt = 0.01;
  float dx = (a*(y-x))*dt;
  float dy = (x*(b-z)-y)*dt;
  float dz = ((x*y)-(c*z))*dt;

  x = x+dx;
  y = y+dy;
  z = z+dz;

  points.add(new PVector(x, y, z));

  stroke(255);
  translate(width/2, height/2,1000);

  noFill();
  beginShape();
  strokeWeight(10);
  for (PVector v : points) {
    stroke(0, random(255), random(255));
    vertex(v.x, v.y, v.z);
  }
  endShape();

  if (points.size() > 10) {
    points.remove(0);
  }
}