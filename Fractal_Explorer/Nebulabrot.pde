class Nebulabrot implements Fractal {

  private int BAILOUT_RED = 50;
  private int BAILOUT_GREEN = 500;
  private int BAILOUT_BLUE = 5000;

  private int ITERATIONS;

  private float MAX_EXPOSURE = 0;

  Nebulabrot(int iterations) {
    this.ITERATIONS = iterations;
  }

  public void debug() {
    System.out.println(Arrays.deepToString(grid));
  }

  public void iterate() {
  }

  public void animate() {
  }

  public void show() {
    loadPixels();
    for (int x = width-1; x >= 0; x--) {
      for (int y = height-1; y >= 0; y--) {

        //float ramp_red = grid[x][y][2] / (MAX_EXPOSURE / 2.5);
        //float ramp_green = grid[x][y][3] / (MAX_EXPOSURE / 2.5);
        //float ramp_blue = grid[x][y][4] / (MAX_EXPOSURE / 2.5);

        //// blow out ultra bright regions
        //if (ramp_red > 1) {
        //  ramp_red = 1;
        //}

        //if (ramp_green > 1) {
        //  ramp_green = 1;
        //}

        //if (ramp_blue > 1) {
        //  ramp_blue = 1;
        //}
        //color c = color(int(ramp_red*255), int(ramp_green*255), int(ramp_blue*255));
        color c = color(grid[x][y][2], grid[x][y][3], grid[x][y][4]);
        //println(grid[x][y][2]);
        pixels[y*width+x] = c;
      }
    }
    updatePixels();
  }

  public void show_reduced() {
    strokeWeight(SCALE);
    for (int x = width-1; x >= 0; x--) {
      for (int y = height-1; y >= 0; y--) {

        float ramp = grid[x][y][2] / (MAX_EXPOSURE/3);
        if (ramp != 0) {
          // blow out ultra bright regions
          if (ramp > 1) {
            ramp = 1;
          }
          color c = color(int(ramp*255), int(ramp*255), int(ramp*255));
          stroke(c);
          point(x*SCALE, y*SCALE);
        }
      }
    }
  }

  void plot() {

    int rx, ry;
    int counter = 0;

    //for (int x = width-1; x >= 0; x--) {
    //  for (int y = height-1; y >= 0; y--) {
    //    if (iterate_red(x, y, false)) {
    //      iterate_red(x, y, true);
    //    }
    //  }
    //}

    //for (int x = width-1; x >= 0; x--) {
    //  for (int y = height-1; y >= 0; y--) {
    //    if (iterate_green(x, y, false)) {
    //      iterate_green(x, y, true);
    //    }
    //  }
    //}

    //for (int x = width-1; x >= 0; x--) {
    //  for (int y = height-1; y >= 0; y--) {
    //    if (iterate_blue(x, y, false)) {
    //      iterate_blue(x, y, true);
    //    }
    //  }
    //}

    while (counter++ < ITERATIONS) {
      rx = int(random(0, width-1));
      ry = int(random(0, height-1));
      if (iterate_red(rx, ry, false)) {
        iterate_red(rx, ry, true);
      }
    }
    counter = 0;
    while (counter++ < ITERATIONS) {
      rx = int(random(0, width-1));
      ry = int(random(0, height-1));
      if (iterate_green(rx, ry, false)) {
        iterate_green(rx, ry, true);
      }
    }
    counter = 0;
    while (counter++ < ITERATIONS) {
      rx = int(random(0, width-1));
      ry = int(random(0, height-1));
      if (iterate_blue(rx, ry, false)) {
        iterate_blue(rx, ry, true);
      }
    }
  }
  /* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
  //Iterate the Mandelbrot and return TRUE if the point exits
  //Also handle the drawing of the exit points
  boolean iterate_red(int rx, int ry, boolean drawIt) {

    float[] z = {0, 0}; 
    float[] c = {grid[rx][ry][0], grid[rx][ry][1]}; //c = {r,i}
    float newX, newY;
    int ix, iy;

    for (int i=0; i< BAILOUT_RED; i++) {

      //f(z+1) = z^2 + c
      newY =(z[0] * z[0] - z[1] * z[1]) + c[0]; //rotated
      newX =(2 * z[0] * z[1]) + c[1]; //rotated
      z[0] = newY; //rotated
      z[1] = newX; //rotated

      if (drawIt && (i > 3)) {
        ix = (int)map(newX, -scaleX, scaleX, 0, width);
        iy = (int)map(newY, -scaleY, scaleY, 0, height);
        if (ix >= 0 && iy >= 0 && ix < width && iy < height) {
          grid[ix][iy][2]++;
        }
      }

      if (dist(z[0], z[1], 0, 0) > 2.0) {
        //escapes
        return true;
      }
    }
    //does not escape
    return false;
  }
  /* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
  boolean iterate_green(int rx, int ry, boolean drawIt) {

    float[] z = {0, 0}; 
    float[] c = {grid[rx][ry][0], grid[rx][ry][1]}; //c = {r,i}
    float newX, newY;
    int ix, iy;

    for (int i=0; i< BAILOUT_GREEN; i++) {

      //f(z+1) = z^2 + c
      newY =(z[0] * z[0] - z[1] * z[1]) + c[0]; //rotated
      newX =(2 * z[0] * z[1]) + c[1]; //rotated
      z[0] = newY; //rotated
      z[1] = newX; //rotated

      if (drawIt && (i > 3)) {
        ix = (int)map(newX, -scaleX, scaleX, 0, width);
        iy = (int)map(newY, -scaleY, scaleY, 0, height);
        if (ix >= 0 && iy >= 0 && ix < width && iy < height) {
          grid[ix][iy][3]++;
        }
      }

      if (dist(z[0], z[1], 0, 0) > 2.0) {
        //escapes
        return true;
      }
    }
    //does not escape
    return false;
  }
  /* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
  boolean iterate_blue(int rx, int ry, boolean drawIt) {

    float[] z = {0, 0}; 
    float[] c = {grid[rx][ry][0], grid[rx][ry][1]}; //c = {r,i}
    float newX, newY;
    int ix, iy;

    for (int i=0; i< BAILOUT_BLUE; i++) {

      //f(z+1) = z^2 + c
      newY =(z[0] * z[0] - z[1] * z[1]) + c[0]; //rotated
      newX =(2 * z[0] * z[1]) + c[1]; //rotated
      z[0] = newY; //rotated
      z[1] = newX; //rotated

      if (drawIt && (i > 3)) {
        ix = (int)map(newX, -scaleX, scaleX, 0, width);
        iy = (int)map(newY, -scaleY, scaleY, 0, height);
        if (ix >= 0 && iy >= 0 && ix < width && iy < height) {
          grid[ix][iy][4]++;
        }
      }

      if (dist(z[0], z[1], 0, 0) > 2.0) {
        //escapes
        return true;
      }
    }
    //does not escape
    return false;
  }
  /* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
  void findMaxExposure() {
    // assume no exposure
    MAX_EXPOSURE = 0;
    // find the largest density value
    for (int x = width-1; x >= 0; x--) {
      for (int y = height-1; y >= 0; y--) {
        MAX_EXPOSURE = max(MAX_EXPOSURE, grid[x][y][2]);
      }
    }
  }
}
