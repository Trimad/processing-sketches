class PerlinMap {

  float [][] points;
  float flying = 0;
  float intensity;

  PerlinMap(float intensityC) {
    this.points = new float[gridSize*4][gridSize*4];
    this.intensity = intensityC;
  }
  void generate() {
    float yOffset = flying;
    for (int y = 0; y < gridSize*4; y++) {
      float xOffset = 0;
      for (int x = 0; x < gridSize*4; x++) {
        points[x][y] = map(noise(xOffset, yOffset), 0, 1, -heightModifier, heightModifier);
        xOffset+=intensity;
      }
      yOffset +=intensity;
    }
  }
}