class SymbolTile {

  float x;
  float y;
  char value;

  SymbolTile(float x, float y) {
    this.x = x;
    this.y = y;
  }

  void update(int n) {
    this.value = (char)n;
  }

  void show (int n) {
    //fill((int)this.value);
    noFill();
    //rect(this.x*scale, this.y*scale, this.x+scale, this.y+scale);
    fill(255);
    text((char)n, this.x*scale+(scale/2), this.y*scale+(scale/2));
  }
}
