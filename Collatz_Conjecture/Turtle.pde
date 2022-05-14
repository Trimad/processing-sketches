class Turtle {

  PVector v1;
  int counter;
  Stack values;

  Turtle(float _x, float _y, Stack _values) {
    this.v1 = new PVector(_x, _y, 0);
    this.values = _values;
    this.counter = 1;
  }

  void crawl() {

    float rg = map(counter, 0, this.values.size(), 0, 255);
    float b = map(frameCount, 0, howManyFrames, 0, 255);

    if (counter<this.values.size()) {

      int d = (int)this.values.get(this.counter);

      //PVector v2 = PVector.fromAngle(degrees(d));
      PVector v2 = PVector.fromAngle(radians(d));

      this.v1.x += v2.x;
      this.v1.y += v2.y;

      stroke(0, 31);
      fill(255-rg, rg, b);
      ellipse(this.v1.x, this.v1.y, size, size);
    } else {
      //noStroke();
      //fill(53, m, 255-m);
      //ellipse(this.v1.x, this.v1.y, size, size);
      //fill(255);

      //text(this.values.get(0)+"", this.v1.x+size/2, this.v1.y);
    }

    if (frameCount%60==0) {
      counter++;
    }
  }
}
