public class Tile_Dirt extends Tile {

  float[] heightMap = new float[4];

  Tile_Dirt(int [] coords) {
    super(coords);
  }

  void show() {

    beginShape(QUADS);
    texture(textures[1]);
    // -Y "top" face
    vertex(-tileSize, -tileSize-heightMap[0], -tileSize, 0, 0);
    vertex( tileSize, -tileSize-heightMap[1], -tileSize, 1, 0);
    vertex( tileSize, -tileSize-heightMap[2], tileSize, 1, 1);
    vertex(-tileSize, -tileSize-heightMap[3], tileSize, 0, 1);
    // +Y "bottom"
    vertex(-tileSize, tileSize, tileSize, 0, 0);
    vertex( tileSize, tileSize, tileSize, 1, 0);
    vertex( tileSize, tileSize, -tileSize, 1, 1);
    vertex(-tileSize, tileSize, -tileSize, 0, 1);
    endShape();

    beginShape(QUADS);
    texture(textures[3]);
    // +Z "front" face
    vertex(-tileSize, -tileSize-heightMap[3], tileSize, 0, 0);
    vertex( tileSize, -tileSize-heightMap[2], tileSize, 1, 0);
    vertex( tileSize, tileSize, tileSize, 1, 2);
    vertex(-tileSize, tileSize, tileSize, 0, 2);
    // -Z "back"
    vertex( tileSize, -tileSize-heightMap[1], -tileSize, 0, 0);
    vertex(-tileSize, -tileSize-heightMap[0], -tileSize, 1, 0);
    vertex(-tileSize, tileSize, -tileSize, 1, 2);
    vertex( tileSize, tileSize, -tileSize, 0, 2);
    // +X "right"
    vertex( tileSize, -tileSize-heightMap[3], tileSize, 0, 0);
    vertex( tileSize, -tileSize-heightMap[2], -tileSize, 1, 0);
    vertex( tileSize, tileSize, -tileSize, 1, 2);
    vertex( tileSize, tileSize, tileSize, 0, 2);
    // -X "left"
    vertex(-tileSize, -tileSize-heightMap[0], -tileSize, 0, 0);
    vertex(-tileSize, -tileSize-heightMap[3], tileSize, 1, 0);
    vertex(-tileSize, tileSize, tileSize, 1, 2);
    vertex(-tileSize, tileSize, -tileSize, 0, 2);
    endShape();
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
