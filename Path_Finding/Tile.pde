class Tile {

  int x;
  int y;
  int z;
  float v1;
  float v2;
  float v3;
  float v4;

  Tile(int xC, int yC, int zC) {

    this.x = xC;
    this.y = yC;
    this.z = zC;
  }

  void show(){}


  public void getHeightMap(float v1In, float v2In, float v3In, float v4In) {
    this.v1 = v1In;
    this.v2 = v2In;
    this.v3 = v3In;
    this.v4 = v4In;
  }
}
