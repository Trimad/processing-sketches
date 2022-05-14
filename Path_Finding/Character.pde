/*
y is a function of x and z.
 x and z are integers the represent the position in the grid.
 y is a negative value and absolute position of the Character.
 */


class Character {

  PVector v;
  float yModifier;

  Character(int xC, float yC, int zC) {
    this.v = new PVector(xC, yC, zC);
  }

  void show(int tileSize) {
    translate(v.x*tileSize*2, v.y, v.z*tileSize*2);
    sphereDetail(16);
    sphere(tileSize);
    translate(-v.x*tileSize*2, -v.y, -v.z*tileSize*2);
  }

  public void getElevation(Tile[][] tiles) {
    this.v.y = -(gridSize*2+((tiles[(int)v.x][(int)v.z].v1 + 
      tiles[(int)v.x][(int)v.z].v2 + 
      tiles[(int)v.x][(int)v.z].v3 + 
      tiles[(int)v.x][(int)v.z].v4)/4));
  }
}
