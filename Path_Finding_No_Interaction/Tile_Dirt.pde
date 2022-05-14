public class Tile_Dirt extends Tile {

  Tile_Dirt(int xC, int yC, int zC) {
    super(xC, yC, zC);
  }

  Tile_Dirt(int xC, int zC) {
    super(xC, zC);
  }

  void show() {

    translate(this.x*tileSize*2, 0, this.z*tileSize*2); 

    beginShape(QUADS);
    if (visited) {
      texture(dirt);
    } else {
      texture(grass);
    }

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
    vertex( tileSize, tileSize, tileSize, 1, 3);
    vertex(-tileSize, tileSize, tileSize, 0, 3);
    // -Z "back"
    vertex( tileSize, -tileSize-v2, -tileSize, 0, 0);
    vertex(-tileSize, -tileSize-v1, -tileSize, 1, 0);
    vertex(-tileSize, tileSize, -tileSize, 1, 3);
    vertex( tileSize, tileSize, -tileSize, 0, 3);
    // +X "right"
    vertex( tileSize, -tileSize-v3, tileSize, 0, 0);
    vertex( tileSize, -tileSize-v2, -tileSize, 1, 0);
    vertex( tileSize, tileSize, -tileSize, 1, 3);
    vertex( tileSize, tileSize, tileSize, 0, 3);
    // -X "left"
    vertex(-tileSize, -tileSize-v1, -tileSize, 0, 0);
    vertex(-tileSize, -tileSize-v4, tileSize, 1, 0);
    vertex(-tileSize, tileSize, tileSize, 1, 3);
    vertex(-tileSize, tileSize, -tileSize, 0, 3);
    endShape();
    translate(-this.x*tileSize*2, this.y, -this.z*tileSize*2);
  }


}