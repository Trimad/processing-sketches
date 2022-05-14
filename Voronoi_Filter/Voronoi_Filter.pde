import toxi.math.conversion.*;
import toxi.geom.*;
import toxi.math.*;
import toxi.geom.mesh2d.*;
import toxi.util.datatypes.*;
import toxi.util.events.*;
import toxi.geom.mesh.subdiv.*;
import toxi.geom.mesh.*;
import toxi.math.waves.*;
import toxi.util.*;
import toxi.math.noise.*;
import toxi.processing.*;

ToxiclibsSupport gfx;
Voronoi voronoi;
PImage reference;

void setup()
{
  size(1024,1024,P3D);

  gfx = new ToxiclibsSupport( this );
  voronoi = new Voronoi();

  reference = loadImage("images/shell.jpg");

  for ( int i = 0; i < 200; i++ ) {
    voronoi.addPoint( new Vec2D( random(width), random(height) ) );
  }

  noLoop();
}

void draw()
{
  background( 0 );
  fill( 0 );
  smooth();

  color[] colors = new color[voronoi.getSites().size()];

  for ( Polygon2D polygon : voronoi.getRegions() ) {
    for ( Vec2D v : voronoi.getSites() ) {
      if ( polygon.containsPoint( v ) ) {
        color c = reference.get( int( v.x ), int( v.y ) );
        fill( c );
        gfx.polygon2D( polygon );
      }
    }
  }

  saveFrame("images/mona-lisa-voronoi.png");
}
