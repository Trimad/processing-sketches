import toxi.physics2d.*;
import toxi.geom.mesh2d.Voronoi;
import toxi.geom.Vec2D;
import toxi.processing.ToxiclibsSupport;
import toxi.geom.Polygon2D;
Voronoi voronoi; 
ToxiclibsSupport gfx;
PImage img;
int factor = 3;

public void setup() {
  size(512, 512);
  img = loadImage("kitten.jpg");
  //gfx = new ToxiclibsSupport( this );
  //voronoi = new Voronoi();
  dither(img);
  image(img, 0, 0);
  //makeVoronoi(imgCopy, 20, 63, 50);
  //colorizeVoronoi(imgCopy);
  //saveFrame("saved.png");
  noLoop();
}

public void makeVoronoi(PImage input, int step, int cutoff, int deviation) {
  print("Making voronoi.\n");
  for (int y = 0; y < input.height-1; y+=step) {
    for (int x = 0; x < input.width-1; x+=step) {
      int randX = floor(random(x-deviation, x+deviation));
      int randY = floor(random(y-deviation, y+deviation));
      int pix = input.pixels[index(x, y, input)];
      float brightness = red(pix)+green(pix)+blue(pix)/3;

      if (brightness > cutoff) {
        voronoi.addPoint( new Vec2D( randX, randY ) );
      }
    }
  }
  print("Finished making voronoi.\n");
}

public void colorizeVoronoi(PImage reference) {
  print("Colorizing voronoi.\n");
  for ( Polygon2D polygon : voronoi.getRegions() ) {
    for ( Vec2D v : voronoi.getSites() ) {
      if ( polygon.containsPoint( v ) ) {
        color c = reference.get( int( v.x ), int( v.y ) );
        fill( c );
        gfx.polygon2D( polygon );
      }
    }
  }
  print("Finished colorizing voronoi.\n");
}

public int index(int x, int y, PImage input) {
  return x + y * input.width;
}

public void dither(PImage input) {
  print("Dithering.\n");
  input.loadPixels();
  for (int y = 0; y < input.height-1; y++) {

    for (int x = 1; x < input.width-1; x++) {

      int pix = input.pixels[index(x, y, input)];

      float oldR = red(pix);
      float oldG = green(pix);
      float oldB = blue(pix);

      int newR = round(factor * oldR / 255) * (255/factor);
      int newG = round(factor * oldG / 255) * (255/factor);
      int newB = round(factor * oldB / 255) * (255/factor);
      input.pixels[index(x, y, input)] = color(newR, newG, newB);

      float errR = oldR - newR;
      float errG = oldG - newG;
      float errB = oldB - newB;

      int index = index(x+1, y, input);
      int c = input.pixels[index];
      float r = red(c);
      float g = green(c);
      float b = blue(c);
      r = r + errR * 7/16.0f;
      g = g + errG * 7/16.0f;
      b = b + errB * 7/16.0f;
      input.pixels[index] = color(r, g, b);

      index = index(x-1, y+1, input);
      c = input.pixels[index];
      r = red(c);
      g = green(c);
      b = blue(c);
      r = r + errR * 3/16.0f;
      g = g + errG * 3/16.0f;
      b = b + errB * 3/16.0f;
      input.pixels[index] = color(r, g, b);

      index = index(x, y+1, input);
      c = input.pixels[index];
      r = red(c);
      g = green(c);
      b = blue(c);
      r = r + errR * 5/16.0f;
      g = g + errG * 5/16.0f;
      b = b + errB * 5/16.0f;
      input.pixels[index] = color(r, g, b);

      index = index(x+1, y+1, input);
      c = input.pixels[index];
      r = red(c);
      g = green(c);
      b = blue(c);
      r = r + errR * 1/16.0f;
      g = g + errG * 1/16.0f;
      b = b + errB * 1/16.0f;
      input.pixels[index] = color(r, g, b);
    }
  }
  input.updatePixels();

  print("Done dithering.\n");
}
