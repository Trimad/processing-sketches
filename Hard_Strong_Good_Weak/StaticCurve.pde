class StaticCurve {

  PVector v;
  float diameter;
  float radius;

  StaticCurve(PVector v, float diameter) {
    this.v = v;
    this.diameter = diameter;
    this.radius = this.diameter/2;
  }

  void layerA() {

    int phaseFix = 0; //FOR MANUALLY TUNING THE PHASE
    translate(-phaseFix, 0);
    beginShape();
    //fill(1,205,254);
    noFill();
    for (int i = 0; i < width+phaseFix; i++) {
      float px = i;
      float py = (height>>1)+(radius * sin(angle+(i*STEP)));
      vertex(px, py);
    }
    endShape();
    translate(phaseFix, 0);
  }

  void layerB() {
    push();
    fill(0);
    circle(v.x, v.y, 12);
    pop();
  }

  void setPosition(PVector other) {
    this.v.y = other.y;
  }

  PVector getPosition() {
    return v;
  }
}
