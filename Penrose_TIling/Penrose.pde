class Penrose extends Tile {

  ArrayList<Tile> tiles = new ArrayList();
  ArrayList<Tile> subtiles = new ArrayList();

  Penrose() {
  }


  void init() {
    int n = 11;
    int d = height; //diameter
    for (int i = 0; i < n; i++) {

      PVector A = new PVector(width>>1, height>>1);

      double bx = (width>>1) + Math.sin(TWO_PI / n * i) * d / 2;
      double by = (height>>1) - Math.cos(TWO_PI / n * i) * d / 2;
      PVector B = new PVector((float)bx, (float)by);

      double cx = (width>>1) + Math.sin(TWO_PI / n * (i-1)) * d / 2;
      double cy = (height>>1) - Math.cos(TWO_PI / n * (i-1)) * d / 2;
      PVector C = new PVector((float)cx, (float)cy);

      //tiles.add(new Tile(A_TILE, A, B, C));

      if (i%2==0) {
        //tiles.add(new Tile(A_TILE, A, B, C));
        tiles.add(new Tile(A_TILE, B, A, C));//Darts and kites
      } else {
        //tiles.add(new Tile(A_TILE, A, C, B));//swapped C and B to alternate
        tiles.add(new Tile(A_TILE, C, A, B));//Darts and kites
      }
    }
  }
}
