/*
y is a function of x and z.
 x and z are integers the represent the position in the grid.
 y is a negative value and absolute position of the Character.
 */

class Node {

  PVector v;
  float yModifier;
  float xoff = 0;
  float yoff = 0;
  int size = tileSize/2;
  
  Node(int xC, int yC, int zC) {
    this.v = new PVector(xC, yC, zC);
  }

  Node(int xC, int zC) {
    this.v = new PVector(xC, 0, zC);
  }

  void show() {

    translate(v.x*tileSize*2, v.y, v.z*tileSize*2);
    sphereDetail(16);
    sphere(this.size);
    translate(-v.x*tileSize*2, -v.y, -v.z*tileSize*2);
    
  }

  void getElevation(Tile[][] tiles) {
    this.v.y = -this.size*2+tiles[(int)v.x][(int)v.z].surfaceHeight;
  }

  void randomWalk() {

    float xr = random(-1, 1);
    float zr = random(-1, 1);
    if (this.v.x+xr < gridSize-1 && this.v.z + zr < gridSize-1) {
      if (this.v.x+xr > 1 && this.v.z + zr > 1) {
        if (grid.tiles[floor(this.v.x+xr)][floor(this.v.z+zr)] != null && grid.tiles[floor(this.v.x+xr)][floor(this.v.z+zr)] instanceof Tile_Dirt) {
          v.x += xr;
          v.z += zr;
        }
      }
    }
  }
}