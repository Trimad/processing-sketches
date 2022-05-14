class Symbol {

  float x;
  float y;
  int speed;
  boolean first;
  int opacity;
  char value;
  float switchInterval;
  byte counter = 0;
  
  Symbol(float x, float y, int speed, boolean first, int opacity) {
    this.x = x;
    this.y = y;
    this.speed = speed;
    this.first = first;
    this.opacity = opacity;
    this.switchInterval = round(random(1, 60));
  }

  void setToRandomSymbol() {
    if (this.counter == this.switchInterval) {
      this.value = (char)round(random(97, 122));
      this.counter=0;
    }
  }; 

  void rain () {
    this.counter++;
    this.y = (this.y >= height) ? 0 : (this.y += this.speed);
  };
}
