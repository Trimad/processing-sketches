class Tile {

  int x;
  int y;
  int z;

  float[] heightMap = new float[4];

  Tile(int[] coords) {

    this.x = coords[0];
    this.y = coords[1];
    this.z = coords[2];
  }

  void show() {
  }

  public void setHeightMap(float v1In, float v2In, float v3In, float v4In) {
    heightMap[0] = v1In;
    heightMap[1] = v2In;
    heightMap[2] = v3In;
    heightMap[3] = v4In;
  }

  public float[] getHeightMap() {

    return this.heightMap;
    
  }
}
