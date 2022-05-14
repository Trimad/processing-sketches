class Arc {

  float start;
  float end;
  int dir;
  int life = 10;

  Arc(int start, int end, int dir) {

    this.start = start;
    this.end = end;
    this.dir = dir;
  }

  void show() {
    float diameter = Math.abs(this.end - this.start);
    float x = (this.end + this.start)*0.5;
    float a = map(this.dir, 1, 0, 0, 255);
    float b = map(this.dir, 0, 1, 0, 255);


    noFill();
    if (this.dir == 0) {
      
      //Background
      stroke(127, 31);
      strokeWeight(1);
      arc(x, 0, diameter, diameter, -PI, 0);
      
      //Foreground
      stroke(a, b, 255);
      strokeWeight(0.5);
      arc(x, 0, diameter, diameter, -PI/life, 0);
      
    } else {
      
      //Background
      stroke(127, 31);
      strokeWeight(1);
      arc(x, 0, diameter, diameter, 0, PI);
      
      //Foreground
      stroke(a, 255, b);
      strokeWeight(0.5);
      arc(x, 0, diameter, diameter, 0, PI/life);
      
    }

    if (life>1) {
      life--;
    }
  }
}
