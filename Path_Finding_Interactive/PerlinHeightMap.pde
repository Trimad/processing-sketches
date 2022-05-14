class PerlinHeightMap {

  float [][] points;
  float flying = 0;
  int maxHeight;
  float intensity;

  PerlinHeightMap(int maxHeight, float intensity) {
    this. points = new float[gridSize+1][gridSize+1]; // one larger because of +1 in grid
    this.maxHeight = maxHeight;
    this.intensity = intensity;
  }
  
  void generate() {
    
    float zOffset = flying;
    for (int x = 0; x < gridSize; x++) {
      float xOffset = 0;
      for (int z = 0; z < gridSize; z++) {
        
        points[x][z] = map(noise(xOffset, zOffset), 0, 1, -maxHeight, maxHeight);
        xOffset+=intensity;
      }
      zOffset +=intensity;
    }
    
  }

  public float[][] getPoints() {
    return points;
  }
  
}
