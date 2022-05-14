class Circle {
  float x;
  float y;
  float r;
  color c;

  boolean growing = true;

  Circle(float x_, float y_, color c_) {
    x = x_;
    y = y_;
    c = c_;
    r = 1;
  }

  void grow() {
    if (growing) {
      r = r + 1;
    }
  }

  boolean edges() {
    return (x + r > img.width || x -  r < 0 || y + r > img.height || y -r < 0);
  }

  //Everything in this loop must referenceg pg
  void show() {
    pg.noStroke();
    pg.fill(c);
    pg.circle(x, y, r*2);
  }

  boolean smallerThan(int n) {
    return (this.r < n);
  }
}
