class Buddhabrot implements Fractal {

  private int MIN_BAILOUT = 10;
  private int BAILOUT;
  private float MAX_EXPOSURE=255;

  Buddhabrot(int bailout) {
    this.BAILOUT = bailout;
  }

  public void debug() {
    System.out.println(Arrays.deepToString(grid));
  }

  public void show() {

    img.loadPixels();
    for (int x = img.width-1; x >= 0; x--) {
      for (int y = img.height-1; y >= 0; y--) {

        float bright = ramp(grid[x][y][2], 15);

        img.pixels[y*img.width+x] = color(bright);
      }
    }
    img.updatePixels();
    img.save("frames/"+nf(frameCount, 5)+".png");
  }

  public void show_reduced() {
    strokeWeight(SCALE);
    for (int x =img.width-1; x >= 0; x-=SCALE) {
      for (int y =img.height-1; y >= 0; y-=SCALE) {

        //color c = color(ramp(grid[x][y][2], 4), (int)ramp(grid[x][y][3], 4), (int)ramp(grid[x][y][4], 4));

        stroke(grid[x][y][2]);
        point(x, y);
      }
    }
  }

  //NON-IMPLEMENTATION FUNCTIONS * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
  public void plot() {

    for (int x =img.width-1; x >= 0; x--) {
      for (int y =img.height-1; y >= 0; y--) {
        if (iterate(x, y, false)) {
          iterate(x, y, true);
        }
      }
    }
  }

  //Iterate the Mandelbrot and return TRUE if the point escapes
  //Also handle the drawing of the exit points
  public boolean iterate(int rx, int ry, boolean drawIt) {

    float[] z = {0, 0}; 
    float[] c = {grid[rx][ry][0], grid[rx][ry][1]}; //c = {r,i}
    float newX, newY;
    int ix, iy;

    for (int i=0; i< BAILOUT; i++) {

      //f(z+1) = z^2 + c
      newY =(z[0] * z[0] - z[1] * z[1]) + c[0]; //rotated
      newX =(2 * z[0] * z[1]) + c[1]; //rotated
      z[0] = newY; //rotated
      z[1] = newX; //rotated

      if (drawIt && (i > MIN_BAILOUT)) {
        ix = (int)map(newX, -scaleX, scaleX, 0, img.width);
        iy = (int)map(newY, -scaleY, scaleY, 0, img.height);
        if (ix >= 0 && iy >= 0 && ix <img.width && iy <img.height) {
          grid[ix][iy][2]++;
          //grid[ix][iy][3]++;
          //grid[ix][iy][4]++;
        }
      }

      if (Math.sqrt(Math.pow(z[0], 2) + Math.pow(z[1], 2)) > 2.0) {//if the distance of z from [0,0] is greater than 2.0...
        //escapes
        return true;
      }
    }
    //does not escape
    return false;
  }

  public void findMaxExposure() {
    // assume no exposure
    MAX_EXPOSURE = 0;
    // find the largest density value
    for (int x =img.width-1; x >= 0; x--) {
      for (int y =img.height-1; y >= 0; y--) {
        MAX_EXPOSURE = Math.max(MAX_EXPOSURE, grid[x][y][2]);
      }
    }
  }

  public float ramp(float c, float howMuch) {

    float ramp = c / (MAX_EXPOSURE/howMuch);

    if (ramp > 1) {
      ramp = 1;
    }

    return ramp*255;
  }
}
