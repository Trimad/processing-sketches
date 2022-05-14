public class Tile_Water extends Tile {

  float[] heightMap = new float[4];

  Tile_Water(int[] coords) {
    super(coords);
  }

  void show() {

    beginShape(QUADS);
    texture(textures[6]);

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
}
