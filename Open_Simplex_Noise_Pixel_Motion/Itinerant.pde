int vScale = 3;
int phases = 1;
int displacement = 8;
int numFrames = 60;

class Itinerant {

  int col;
  int bri;

  float x;
  float permaX;
  float nX;

  float y;
  float permaY;
  float nY;

  float angle;
  float ns;

  Itinerant(int [] arr) {

    this.col = arr[0];
    this.bri = arr[1];
    this.x = arr[2];
    this.permaX = arr[2];
    this.y = arr[3];
    this.permaY = arr[3];
    this.angle = map(bri, 0, 255, 0, phases); //Brighter moves more
    //this.angle = map(bri, 255, 0, 0, phases); //Darker moves more
  }

  void update() {

    float t = (0.4*frameCount/numFrames)%1;
    float scale = 0.0005; //noise "zoom"
    float ns = (float)noise.eval(scale*x, scale*y, this.angle*cos(TWO_PI*t), this.angle*sin(TWO_PI*t));
    float nm = map(ns, -1, 1, -displacement, displacement);

    this.x = permaX + displacement*(float)Math.cos(nm);
    this.y = permaY + displacement*(float)Math.sin(nm);
    //this.x = permaX + nX;
    //this.y = permaY + nY;
    stroke(this.col);
    strokeWeight(2);
    //point(this.x, this.y);
    rect(this.x,this.y,8,8);
  }
}