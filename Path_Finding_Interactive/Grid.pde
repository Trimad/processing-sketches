import java.util.*;

class Grid {

  Tile [][] tiles;

  Grid() {
    tiles = new Tile[gridSize][gridSize];
  }

  void generateTerrain(float[][] hm) {

    //Firstly, generate a 2D perlin noise map.

    //Secondly, generate a grid of tiles.
    //for (int x = tiles.length-1; x >= 0; x--) {
    //  for (int z = tiles.length-1; z >= 0; z--) {
    for (int x = 0; x < gridSize; x++) {
      for (int z = 0; z < gridSize; z++) {
        int[] position = {x, 0, -z};

        if ((hm[x][z] + hm[x+1][z] + hm[x+1][z+1] + hm[x][z+1])/4 <= 0) {
          tiles[x][z] = new Tile_Water(position);
        } else {
          tiles[x][z] = new Tile_Dirt(position);
          tiles[x][z].setHeightMap(hm[x][z], hm[x+1][z], hm[x+1][z+1], hm[x][z+1]);
        }

        //println("x: "+x, "z: "+z);
      }
    }
  }

  void show() {

    for (int x = tiles.length-1; x >= 0; x--) {
      for (int z = tiles.length-1; z >= 0; z--) {
        translate(-x*(tileSize<<1), 0, -z*(tileSize<<1)-rocket.height);
        tiles[x][z].show();
        translate(x*(tileSize<<1), 0, z*(tileSize<<1)+rocket.height);
      }
    }
  }
}
