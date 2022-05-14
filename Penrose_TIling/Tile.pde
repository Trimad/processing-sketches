class Tile {

  int colour;
  PVector A, B, C, P, Q, R;
  Tile(color _col, PVector _A, PVector _B, PVector _C ) {
    colour = _col;
    A = _A;
    B = _B;
    C = _C;
  }
  
  Tile() {
  }

  //Robinson triangle decomposition
  void subdivide() {
    if (colour == A_TILE) {
      P = A.copy();
      PVector tempP = B.copy().sub(A).div(GOLDEN_RATIO);
      P.add(tempP);
      subtiles.add(new Tile(A_TILE, C, P, B));
      subtiles.add(new Tile(B_TILE, P, C, A));
    } else if (colour == B_TILE) {
      Q = B.copy();
      PVector tempQ = A.copy().sub(B).div(GOLDEN_RATIO);
      Q.add(tempQ);
      PVector tempR = C.copy().sub(B);
      tempR.div(GOLDEN_RATIO);
      R = B.copy();
      R.add(tempR);
      subtiles.add(new Tile(B_TILE, R, C, A));
      subtiles.add(new Tile(B_TILE, Q, R, B));
      subtiles.add(new Tile(A_TILE, R, Q, A));
    }
  }

  //Darts and kites tiling
  void subdivideP2() {
    if (colour == A_TILE) {

      Q = A.copy();
      PVector tempQ = B.copy().sub(A).div(GOLDEN_RATIO);
      Q.add(tempQ);

      R = B.copy();
      PVector tempR = C.copy().sub(B).div(GOLDEN_RATIO);
      R.add(tempR);

      subtiles.add(new Tile(B_TILE, R, Q, B));
      subtiles.add(new Tile(A_TILE, Q, A, R));
      subtiles.add(new Tile(A_TILE, C, A, R));
      
    } else if (colour == B_TILE) {

      P = C.copy();
      PVector tempP = A.copy().sub(C).div(GOLDEN_RATIO);
      P.add(tempP);

      subtiles.add(new Tile(B_TILE, B, P, A));
      subtiles.add(new Tile(A_TILE, P, C, B));
      
    }
  }

  void drawTile() {
    beginShape();
    //strokeWeight(5);
    //stroke(col);
    fill(colour,20);
    vertex(A.x, A.y);
    vertex(B.x, B.y);
    vertex(C.x, C.y);
    vertex(A.x, A.y);
    endShape();
    //fill(255);
    //text(col+"", (A.x+B.x+C.x)/3, (A.y+B.y+C.y)/3);
  }
}
