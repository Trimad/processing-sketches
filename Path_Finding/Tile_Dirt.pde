public class Tile_Dirt extends Tile {

  Tile_Dirt(int xC, int yC, int zC) {
    super(xC, yC, zC);
  }

  void show() {

    translate(this.x*tileSize*2, -this.y, this.z*tileSize*2);

    beginShape(QUADS);
    texture(grass);
    // -Y "top" face
    vertex(-tileSize, -tileSize-v1, -tileSize, 0, 0);
    vertex( tileSize, -tileSize-v2, -tileSize, 1, 0);
    vertex( tileSize, -tileSize-v3, tileSize, 1, 1);
    vertex(-tileSize, -tileSize-v4, tileSize, 0, 1);
    // +Y "bottom"
    vertex(-tileSize, tileSize, tileSize, 0, 0);
    vertex( tileSize, tileSize, tileSize, 1, 0);
    vertex( tileSize, tileSize, -tileSize, 1, 1);
    vertex(-tileSize, tileSize, -tileSize, 0, 1);
    endShape();

    beginShape(QUADS);
    texture(dirt);
    // +Z "front" face
    vertex(-tileSize, -tileSize-v4, tileSize, 0, 0);
    vertex( tileSize, -tileSize-v3, tileSize, 1, 0);
    vertex( tileSize, tileSize, tileSize, 1, 2);
    vertex(-tileSize, tileSize, tileSize, 0, 2);
    // -Z "back"
    vertex( tileSize, -tileSize-v2, -tileSize, 0, 0);
    vertex(-tileSize, -tileSize-v1, -tileSize, 1, 0);
    vertex(-tileSize, tileSize, -tileSize, 1, 2);
    vertex( tileSize, tileSize, -tileSize, 0, 2);
    // +X "right"
    vertex( tileSize, -tileSize-v3, tileSize, 0, 0);
    vertex( tileSize, -tileSize-v2, -tileSize, 1, 0);
    vertex( tileSize, tileSize, -tileSize, 1, 2);
    vertex( tileSize, tileSize, tileSize, 0, 2);
    // -X "left"
    vertex(-tileSize, -tileSize-v1, -tileSize, 0, 0);
    vertex(-tileSize, -tileSize-v4, tileSize, 1, 0);
    vertex(-tileSize, tileSize, tileSize, 1, 2);
    vertex(-tileSize, tileSize, -tileSize, 0, 2);
    endShape();
    translate(-this.x*tileSize*2, this.y, -this.z*tileSize*2);
  }

  void getHeightMap(float v1In, float v2In, float v3In, float v4In) {
    this.v1 = v1In;
    this.v2 = v2In;
    this.v3 = v3In;
    this.v4 = v4In;
  }

}
