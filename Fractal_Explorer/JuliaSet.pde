public class JuliaSet implements Fractal {

  private int ITERATIONS;

  JuliaSet(int iterations) {
    this.ITERATIONS = iterations;
  }

  public void debug() {
    System.out.println(Arrays.deepToString(grid));
  }

  public void show() {
    loadPixels();
    for (int x = width-1; x >= 0; x--) {
      for (int y = height-1; y >= 0; y--) {
        color c = color(grid[x][y][2], grid[x][y][3], grid[x][y][4]);
        pixels[y*width+x] = c;
      }
    }
    updatePixels();
  }

  public void show_reduced() {
    strokeWeight(SCALE);
    for (int x = width-1; x >= 0; x-=SCALE) {
      for (int y = height-1; y >= 0; y-=SCALE) {
        stroke(grid[x][y][2], grid[x][y][3], grid[x][y][4]);
        point(x, y);
      }
    }
  }
  //float angle;
  public void iterate() {
    //angle += 0.01;

    for (int x = width-1; x >= 0; x--) {

      for (int y = height-1; y >= 0; y--) {

        float[] z = {grid[x][y][0], grid[x][y][1]}; 
        float[] c = {-0.4, 0.6 }; //c = {r,i}
        //float[]c = {cos(angle*3.213), sin(angle)};

        for (int n = ITERATIONS-1; n >= 0; n--) {

          if (dist(z[0], z[1], 0, 0) > 2.0) {//if the distance of z from [0,0] is greater than 2.0...
            grid[x][y][2] = ITERATIONS-n;//red
            grid[x][y][3] = ITERATIONS-n;//green
            grid[x][y][4] = ITERATIONS-n;//blue
            //grid[x][y][2]++;//red
            //grid[x][y][3]++;//green
            //grid[x][y][4]++;//blue
            break;
          }

          //f(z+1) = z^2 + c
          float newX =(z[0] * z[0] - z[1] * z[1]) + c[0];
          float newY =(2 * z[0] * z[1]) + c[1];
          z[0] = newX;
          z[1] = newY;
        }
      }
    }
  }

  public void animate() {
  }
}
