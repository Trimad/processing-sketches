public class Tile {

  //PHI
  float PHI = 1.61803398875f;
  float TWO_PHI = 3.2360679775f;
  //PI
  float HALF_PI = 1.57079632679f;
  float PI = 3.14159265359f;
  float TWO_PI = 6.28318530718f;
  //Variables
  boolean flip;
  int x;
  int y;

  float r;//rotation
  int rx;//rate of rotation
  float s;//scale
  float sx;//rate of scale

  PApplet parent;
  PGraphics img;

  Tile(int x, int y, PGraphics img) {
    this.x = x;
    this.y = y;
    this.img = img;
    this.r = 0; //rotation
    this.rx = 0; //rate of rotation
    this.s = 1; //scale
    this.sx = 0; //rate of scale
    this.flip = false;
  }

  void update(int frames) {
    if (flip) {
      rx++;
      sx += (TWO_PHI / frames);
      if (rx % frames == 0) {
        flip = false;
        sx = 0;
      }
      r = map(rx, 0, frames, 0, HALF_PI); //90-degree rotation
      s = map((float) Math.sin(sx), 0, TWO_PHI, 1, 1.5f); //grows 50% larger during rotation
    }
  }

  void show() {
    pushMatrix();
    translate((MY_SCALE >> 1) + x * MY_SCALE, (MY_SCALE >> 1) + y * MY_SCALE);
    rotate(r);
    scale(s);
    for (int x=0; x< img.pixels.length; x++) {
      if (img.pixels[x] == color(0)) {
        img.pixels[x] = color(0, 0, 0, 0);
      }
    }
    image(img, 0, 0);
    popMatrix();
  }

  void flip() {
    flip = true;
  }
}
