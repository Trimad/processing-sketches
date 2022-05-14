class Tile {

  boolean visited = false;
  int x;
  int y;
  int z;
  float v1;
  float v2;
  float v3;
  float v4;
  float surfaceHeight = 0;
  Tile(int xC, int yC, int zC) {
    this.x = xC;
    this.y = yC;
    this.z = zC;
  }

  Tile(int xC, int zC) {
    this.x = xC;
    this.z = zC;
  }

  void show() {
  }
  
  void getHeightMap(float v1In, float v2In, float v3In, float v4In) {
    this.v1 = v1In;
    this.v2 = v2In;
    this.v3 = v3In;
    this.v4 = v4In;
    this.surfaceHeight = -(tileSize+(v1 + v2 + v3 + v4) / 4);
  }
}