import peasy.PeasyCam;

int DIM = 200;
PeasyCam cam;
ArrayList<PVector> mandelbulb = new ArrayList<PVector>();
StringList points = new StringList();

void setup() {
  //size(600, 600, P3D);
  fullScreen(P3D);
  cam = new PeasyCam(this, 400);
  windowMove(800, 700);



  for (int i = 0; i < DIM; i++) {
    for (int j = 0; j < DIM; j++) {
      boolean edge = false;
      for (int k = 0; k < DIM; k++) {

        float x = map(i, 0, DIM, -1, 1);
        float y = map(j, 0, DIM, -1, 1);
        float z = map(k, 0, DIM, -1, 1);

        PVector zeta = new PVector(0, 0, 0);
        int n = 8;
        int maxiterations = 10;
        int iteration = 0;

        while (true) {
          Spherical c = spherical(zeta.x, zeta.y, zeta.z);
          float newx = pow(c.r, n) * sin(c.theta*n) * cos(c.phi*n);
          float newy =  pow(c.r, n) * sin(c.theta*n) * sin(c.phi*n);
          float newz =  pow(c.r, n) * cos(c.theta*n);

          zeta.x = newx+x;
          zeta.y = newy+y;
          zeta.z = newz+z;

          if (c.r > 16) {
            //println(c.r);
            if (edge) {
              edge = false;
            }
            break;
          }

          if (iteration++ > maxiterations) {
            if (!edge) {
              edge = true;
              mandelbulb.add(new PVector(x*100, y*100, z*100));
              points.append(x + " " + y + " " + z);
            }
            break;
          }
        }
      }
    }
  }
  String[] output = points.array();
  saveStrings("mandelbulb.txt", output);
  //exit();
}

void draw() {
  background(0);
  lights();
  stroke(255);
  beginShape(POINTS);
  for (PVector v : mandelbulb) {
    vertex(v.x, v.y, v.z);
  }
  endShape();
}

Spherical spherical(float x, float y, float z) {
  float r = sqrt(x*x + y*y + z*z);
  float theta = atan2(sqrt(x * x+y*y), z);
  float phi = atan2(y, x);
  return new Spherical(r, theta, phi);
}
