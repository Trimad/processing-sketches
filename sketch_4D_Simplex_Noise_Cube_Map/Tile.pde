Tile [][] grid;

class Tile {

  int x;
  int y;
  int z;
  float noise;

  Tile(int _x, int _y, int _z, float _noise) {

    this.x = _x;
    this.y = _y;
    this.z = _z;
    this.noise = _noise;
  }

  void display() {
    float m = map(this.noise, -1, 1, -500, 900);
    float mc = constrain(m, 0, 640);

    pushMatrix();
    translate(this.x*w, 0, this.z*w);
    
    if (mc < 1) {      
      TexturedCube(water, mc);
    } else if (mc >= 1 && mc < 128) {
      TexturedCube(sand, mc);
    } else if (mc >= 128 && mc < 384) {
      TexturedCube(grass, mc);
    } else if (mc >= 384 && mc < 512) {
      TexturedCube(dirt, mc);
    } else if (mc >= 512 && mc < 640) {
      TexturedCube(rock, mc*1.2);
    } else if (mc >= 640 ) {
      TexturedCube(snow, mc);
    }
    popMatrix();
  }
}

void TexturedCube(PImage _tex, float m) {
  beginShape(QUADS);

  texture(_tex);
  float size = w/2;

  // -X "left" face
  vertex(-size, -size-m, -size, 0, 0);
  vertex(-size, -size-m, size, _tex.width, 0);
  vertex(-size, size, size, _tex.width, _tex.width+m);
  vertex(-size, size, -size, 0, _tex.width+m);
  // +X "right" face
  vertex( size, -size-m, size, 0, 0);
  vertex( size, -size-m, -size, _tex.width, 0);
  vertex( size, size, -size, _tex.width, _tex.width);
  vertex( size, size, size, 0, _tex.width);
  // -Y "top" face
  vertex(-size, -size-m, -size, 0, 0);
  vertex( size, -size-m, -size, _tex.width, 0);
  vertex( size, -size-m, size, _tex.width, _tex.width);
  vertex(-size, -size-m, size, 0, _tex.width);
  // +Y "bottom" face
  vertex(-size, size-m, size, 0, 0);
  vertex( size, size-m, size, _tex.width, 0);
  vertex( size, size-m, -size, _tex.width, _tex.width);
  vertex(-size, size-m, -size, 0, _tex.width);
  // -Z "back" face
  vertex( size, -size-m, -size, 0, 0);
  vertex(-size, -size-m, -size, _tex.width, 0);
  vertex(-size, size, -size, _tex.width, _tex.width+m);
  vertex( size, size, -size, 0, _tex.width+m);
  // +Z "front" face
  vertex(-size, -size-m, size, 0, 0);
  vertex( size, -size-m, size, _tex.width, 0);
  vertex( size, size, size, _tex.width, _tex.width);
  vertex(-size, size, size, 0, _tex.width);
  endShape();

  endShape();
}