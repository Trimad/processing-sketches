import peasy.PeasyCam;
PeasyCam cam;

ArrayList<Datum>  points = new ArrayList<Datum>();
ArrayList<Datum> centroids = new ArrayList<Datum>();
ArrayList<Datum> centroid_targets = new ArrayList<Datum>();

int k=16;

void setup() {
  size(900, 900, P3D);
  //fullScreen(P3D);
  colorMode(HSB, 360, 100, 100);

  //http://mrfeinberg.com/peasycam/reference/index.html
  cam = new PeasyCam(this, 450, 450, 450, 1600);

  //Initialize a bunch of rando points
  for (int i = 0; i < 2000; i++) {
    color c = color(360, 0, 100);
    float[] data = {random(0, 1), random(0, 1), random(0, 1)};
    points.add(new Datum(c, data));
  }
  //Initialize the centroids
  for (int i = 0; i < k; i++) {

    color c1 = color((100 + i * 360) / k, 60, 50);
    float[] data1 = {0, 0, 0};
    centroids.add(new Datum(c1, data1));

    color c2 = color((100 + i * 360) / k, 60, 50);
    float[] data2 = {random(0, 1), random(0, 1), random(0, 1)};
    centroid_targets.add(new Datum(c2, data2));
  }

  noSmooth();
}

void draw() {
  //translate(width/2, height/2, 450);
  //rotateX(frameCount*0.003);
  //rotateY(frameCount*0.004);
  //translate(-width/2, -height/2, -450);
  background(0);
  strokeWeight(3);
  strokeCap(ROUND);
  //Draw the points
  for (Datum d : points) {
    //color c = color((100 + d.c * 360) / k, 100, 100);
    stroke(d.c);
    float x = map(d.data[0], 0, 1, 0, 900);
    float y = map(d.data[1], 0, 1, 0, 900);
    float z = map(d.data[2], 0, 1, 0, 900);
    point(x, y, z);
  }
  strokeWeight(10);
  strokeCap(SQUARE);
  //Draw the centroids
  //for (Datum d : centroids) {
  //  stroke(d.c);
  //  float x = map(d.data[0], 0, 1, 0, 900);
  //  float y = map(d.data[1], 0, 1, 0, 900);
  //  float z = map(d.data[2], 0, 1, 0, 900);
  //  point(x, y, z);
  //}
  //Draw the centroid targets
  for (Datum d : centroid_targets) {
    stroke(d.c);
    float x = map(d.data[0], 0, 1, 0, 900);
    float y = map(d.data[1], 0, 1, 0, 900);
    float z = map(d.data[2], 0, 1, 0, 900);
    point(x, y, z);
  }

  kmeans();
  randomWalk();
}


void randomWalk() {
  for (Datum d : points) {
    d.wiggle();
  }
}


void kmeans () {

  /* Associate each point with its closest centroid */
  points.forEach(p -> {
    double min_d = Double.MAX_VALUE;
    int min_i = 0;
    for (int i = 0; i < centroid_targets.size(); i++) {
      Datum ct = centroid_targets.get(i);
      double d = p.dist(ct);

      if (d < min_d) {
        min_d = d;
        min_i = i;
      }
    }
    p.c = centroid_targets.get(min_i).c;
  }
  );

  /* Update the centroids' positions */
  //for (int c_index = 0; c_index < centroid_targets.size(); c_index++) {
  //  Datum new_coords = new Datum(color(360, 0, 100), new float[]{0, 0, 0});
  //  int n = 0;

  //  ArrayList<Datum> points_cloned = new ArrayList<Datum>();

  //  for (int i = 0; i < points_cloned.size(); i++) {
  //    if (points.get(i).c == centroid_targets.get(c_index).c)
  //    {
  //      points_cloned.add(points.get(i));
  //    }


  //    println(points_cloned.size());
  //    for (int j = 0; j < points_cloned.size(); j++) {
  //      Datum p = points_cloned.get(c_index);
  //      new_coords.add(p);
  //      ++n;
  //    }
  //    if (n==0)return;
  //    new_coords.div(n);
  //    centroid_targets.set(c_index, new_coords);
    //}
//  }
}
