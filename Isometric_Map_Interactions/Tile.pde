class Tile {

  int x;
  int y;
  int z;
  float noise;
  int noiseModifier;

  Tile(int _x, int _y, int _z, float _noise) {

    this.x = _x;
    this.y = _y;
    this.z = _z;
    this.noise = _noise;
    this.noiseModifier = constrain((int)map(this.noise, -1, 1, -500, 900), 0, 640);
  }

  void display() {
    this.noise = map(getSimplexNoise(x*w, z*w, 0.0009), -1, 1, -1000, 2000);
    this.noiseModifier = constrain((int)this.noise, 0, 2048);
    pushMatrix();
    translate(-this.x*w, 0, -this.z*w);
    if (this.noiseModifier < 1) {      
      TexturedCube(water, this.noiseModifier);
    } else if (this.noiseModifier >= 1 && this.noiseModifier < 128) {
      TexturedCube(sand, this.noiseModifier);
    } else if (this.noiseModifier >= 128 && this.noiseModifier < 384) {
      TexturedCube(grass, this.noiseModifier);
    } else if (this.noiseModifier >= 384 && this.noiseModifier < 512) {
      TexturedCube(dirt, this.noiseModifier);
    } else if (this.noiseModifier >= 512 && this.noiseModifier < 640) {
      TexturedCube(rock, this.noiseModifier*1);
    } else if (this.noiseModifier >= 640 ) {
      TexturedCube(snow, this.noiseModifier);
    }
    popMatrix();
  }
}

void TexturedCube(PImage _tex, float m) {
  beginShape(QUADS);
  texture(_tex);
  float size = w/2;
    // -X "left" face
    vertex(-size, 0-m, -size, 0, 0);
    vertex(-size, 0-m, size, _tex.width, 0);
    vertex(-size, 0, size, _tex.width, _tex.width+m);
    vertex(-size, 0, -size, 0, _tex.width+m);
    // +X "right" face
    vertex( size, 0-m, size, 0, 0);
    vertex( size, 0-m, -size, _tex.width, 0);
    vertex( size, 0, -size, _tex.width, _tex.width+m);
    vertex( size, 0, size, 0, _tex.width+m);
    // -Y "top" face
    vertex(-size, 0-m, -size, 0, 0);
    vertex( size, 0-m, -size, _tex.width, 0);
    vertex( size, 0-m, size, _tex.width, _tex.width);
    vertex(-size, 0-m, size, 0, _tex.width);
    // +Y "bottom" face
    vertex(-size, 0, size, 0, 0);
    vertex( size, 0, size, _tex.width, 0);
    vertex( size, 0, -size, _tex.width, _tex.width);
    vertex(-size, 0, -size, 0, _tex.width);
    // -Z "back" face
    vertex( size, 0-m, -size, 0, 0);
    vertex(-size, 0-m, -size, _tex.width, 0);
    vertex(-size, 0, -size, _tex.width, _tex.width+m);
    vertex( size, 0, -size, 0, _tex.width+m);
    // +Z "front" face
    vertex(-size, 0-m, size, 0, 0);
    vertex( size, 0-m, size, _tex.width, 0);
    vertex( size, 0, size, _tex.width, _tex.width+m);
    vertex(-size, 0, size, 0, _tex.width+m);
  endShape();
}