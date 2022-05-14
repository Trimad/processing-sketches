/*
y is a function of x and z.
 x and z are integers the represent the position in the grid.
 y is a negative value and absolute position of the Character.
 */

class Human extends Humanoid {

  Human(PVector v, int level) {
    super(v, level);
  }

  void show(int tileSize) {

    float tile = tileSize<<1;

    translate(-v.x*tile, v.y, -v.z*tile);
    shape(rocket);
    //sphere(tileSize);
    translate(v.x*tile, -v.y, v.z*tile);
  }
  public void getElevation(Tile[][] tiles) {
    float[] heightMap = tiles[(int)v.x][(int)v.z].getHeightMap();
    //float averageHeight = (heightMap[0]+heightMap[1]+heightMap[2]+heightMap[3])*0.25;
    this.v.y = -heightMap[0]-tileSize*2;
  }
}
