public class Tile_Water extends Tile {

  Tile_Water(int xC, int yC, int zC) {
    super(xC, yC, zC);
  }

  Tile_Water(int xC, int zC) {
    super(xC, zC);
  }

  void show() {

    translate(this.x*tileSize*2, -this.y, this.z*tileSize*2);
    beginShape(QUADS);
    texture(water);

    // -Y "top" face
    vertex(-tileSize, -tileSize-v1, -tileSize, 0, 0);
    vertex( tileSize, -tileSize-v2, -tileSize, 1, 0);
    vertex( tileSize, -tileSize-v3, tileSize, 1, 1);
    vertex(-tileSize, -tileSize-v4, tileSize, 0, 1);
    // +Y "bottom" face
    vertex(-tileSize, tileSize, tileSize, 0, 0);
    vertex( tileSize, tileSize, tileSize, 1, 0);
    vertex( tileSize, tileSize, -tileSize, 1, 1);
    vertex(-tileSize, tileSize, -tileSize, 0, 1);
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
}