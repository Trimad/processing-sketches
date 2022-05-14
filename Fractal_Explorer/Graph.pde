class Graph {

  Graph() {
  }

  void show() {

    for (int x = 0; x < width; x+=width>>2) {

      for (int y = 0; y < height; y+=height>>2) {
        stroke(127);
        strokeWeight(1);
        line(x, 0, x, height);
        line(0, y, width, y);

        float real = grid[x][y][0];
        float imag = grid[x][y][1];

        if (real < 0) {
          text(nf(real, 1, 2)+"r", x+5, y+16);
        } else {
          text(nf(real, 2, 2)+"r", x+5, y+16);
        }

        if (imag < 0) {
          text(nf(imag, 1, 2)+"i", x+5, y+32);
        } else {
          text(nf(imag, 2, 2)+"i", x+5, y+32);
        }
      }
    }
  }
}
