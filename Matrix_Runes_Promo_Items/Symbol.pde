class Symbol {

  float x;
  float y;
  int speed;
  boolean first;
  int opacity;
  char value;
  float switchInterval;

  Symbol(float x, float y, int speed, boolean first, int opacity) {
    this.x = x;
    this.y = y;
    this.speed = speed;
    this.first = first;
    this.opacity = opacity;
    this.switchInterval = round(random(1 , frameRate));
  }

  void setToRandomSymbol() {

    if (frameCount % this.switchInterval == 0) {
      this.value = (char)round(random(97,122));
    }
  };

  void rain () {

    //if (frameCount%this.speed==0)
      this.y = (this.y >= height) ? 0 : (this.y += this.speed);
  };
}
