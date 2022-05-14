int maxBarHeight = 512;

class Bar {

  float x;
  float y;
  float z;
  float total;
  float targetHeight;
  float currentHeight = 0;
  String offenseCharged;
  String race;

  Bar(int _x, int _y, int _z, String _offenseCharged, String _race, int _total) {

    this.x = _x;
    this.y = _y;
    this.z = _z;
    this.total = _total;
    this.offenseCharged = _offenseCharged;
    this.race = _race;
  }

  void display() {

    pushMatrix();
    translate(this.x*spacing, 0, -this.z*spacing);

    targetHeight = map(this.y, 0, this.total, 0, maxBarHeight);

    textSize(32);
    textMode(MODEL);
    textAlign(CENTER);
    noStroke();
    fill(255);
    if (this.race.matches("TOTAL")) {
      texturedCube(totalSkin, currentHeight);
      translate(0, 0, spacing*1.5);
      rotateX(PI/2);
      rotateX(-PI/2);
      translate(0, 0, -spacing*1.5);
    } else if (this.race.contains("White")) {
      texturedCube(whiteSkin, currentHeight);
    } else if (this.race.contains("Black")) {
      texturedCube(blackSkin, currentHeight);
    } else if (this.race.contains("American Indian") || this.race.contains("Alaskan Native")|| this.race.contains("Hawaiian")) {
      texturedCube(nativeSkin, currentHeight);
    } else if (this.race.contains("Asian")) {
      texturedCube(asianSkin, currentHeight);
    }

    //Number of offenses charged label
    String numberAboveBar = Float.toString(this.y);
    text(numberAboveBar, 0, -currentHeight-(spacing/16), 0);

    //Race label
    if (this.x == 0) {    
      rotateX(PI/2);
      text(this.race, -spacing/2, 0, -spacing/2, spacing/2);
      rotateX(-PI/2);
    }
    //Offense charged label
    if (this.z == 0) {  
      translate(0, 0, spacing);
      rotateX(PI/2);
      text(this.offenseCharged, -w/2, -w/2, w, w);
      rotateX(-PI/2);
      translate(0, 0, -spacing);
    }
    popMatrix();

    if (currentHeight < targetHeight) {
      currentHeight+=32;
    }
  }

  void texturedCube(PImage _tex, float m) {
    strokeWeight(1);
    stroke(51);
    float size = w/2;
    beginShape(QUADS);
    texture(_tex);
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
}