//Lorenz Attractor Constants 
int La = 10;
int Lb = 28;
float Lc = 8/3.0;

float dt = .001; //Time

//My variables
int vScale = 1;
int phases = 3;

class Itinerant {

  float x;
  float y;
  float z;
  float Lx = 0.01;
  float Ly = 0.01;
  float Lz = 0.01;
  float dx;
  float dy;
  float dz;

  int col;
  int bri;
  float angle;

  Itinerant(int [] arr) {
    this.col = arr[0];
    this.bri = arr[1];
    this.x = arr[2];
    this.y = arr[3];
    this.z = arr[4];
    this.angle = map(bri, 0, 255, 0, phases);
  }

  void update() {

    this.angle+=0.01;
    //Constrained
    dx = constrain((La*(Ly-Lx))*dt, -1, 1);
    dy = constrain((Lx*(Lb-Lz)-Ly)*dt, -8, 8);
    dz = constrain((Lx*Ly)-(Lc*Lz)*dt, -1, 1);

    //Unconstrained
    this.dx = (La*(Ly-Lx))*(float)Math.cos(this.angle);
    this.dy = (Lx*(Lb-Lz)-Ly)*(float)Math.sin(this.angle);
    this.dz = (Lx*Ly)-(Lc*Lz)*(float)Math.tan(this.angle);

    this.x += this.dx * Math.cos(this.angle);
    this.y += this.dy * Math.sin(this.angle);
    this.z += this.dz * Math.tan(this.angle);


    if (this.y >= height/2) {
      this.y = height;
    }
    if (this.x >= width/2) {
      this.x = width;
    }
  }

  public float getZ() {
    return this.z;
  }

  void makePoints() {

    rotateY(radians(angle));
    rotateX(radians(angle));
    //rotateZ(radians(angle));

    stroke(this.col);
    strokeWeight(3);
    point(this.x, this.y, this.z);
  }
  /*
  void makeLines() {
   stroke(this.col);
   fill(this.col);
   //setStroke();
   vertex(this.x, this.y, this.z);
   }
   */
}
