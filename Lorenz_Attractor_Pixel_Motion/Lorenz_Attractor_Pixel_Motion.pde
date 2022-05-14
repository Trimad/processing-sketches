//ffmpeg -i test.mp4 -i lol.mp3 -codec copy -shortest output.mp4
//ffmpeg -r 48 -f image2 -s 1920x1080 -i frame-%04d.tif -c:v libx264 -preset slow -profile:v high -crf 18 -coder 1 -pix_fmt yuv420p -movflags +faststart -g 30 -bf 2 -c:a aac -b:a 384k -profile:a aac_low test2.mp4

import peasy.*;
import peasy.org.apache.commons.math.*;
import peasy.org.apache.commons.math.geometry.*;
import ch.bildspur.postfx.builder.*;
import ch.bildspur.postfx.pass.*;
import ch.bildspur.postfx.*;

PostFX fx;
PeasyCam cam;

ArrayList<Itinerant> itinerant = new ArrayList<Itinerant>();
ArrayList<Itinerant> sorted;

PImage img;
PGraphics pg;

int framesToDraw = 6360;
//float cameraZoom = -11680;
float cameraZoom = -5900;

void setup() {
  size(2400, 600, P3D);
  //fullScreen(P3D);
  frameRate(60);
  //size(3840, 2160, P3D);
  //size(1920, 1080, P3D);
  smooth(4);
  //background(0);

  img = loadImage("data/01.jpg");
  //strokeCap(SQUARE);
  fx = new PostFX(this);  
  convertPixelsToObjects();
  sorted = new ArrayList(itinerant);

  //cam = new PeasyCam(this, 256);
  //cam.setMinimumDistance(0);
  //cam.setMaximumDistance(img.width*img.height);
  //cam.lookAt(2560, 1440, 5000);
}

void draw() {

  //saveFrame("frame-####.tif");

  if (frameCount >= framesToDraw+2) {
    //exit();
  }

  /*
  camera(cameraZoom, 0.0, 0.0, // eyeX, eyeY, eyeZ
   0.0, 0.0, 0.0, // centerX, centerY, centerZ
   0.0, 1.0, 0.0); // upX, upY, upZ
   */

  //  background(0);
  background(255);
  for (int i = 0; i < itinerant.size()-1; i++) {
    itinerant.get(i).update();
    itinerant.get(i).makePoints();
  }

  fx.render()
    //.bloom(0.1, 100, 10)
    //.rgbSplit(100)
    //    .sobel()
    //.brightPass(0.1)
    .blur(2, 10)
    //.toon()
    //.denoise(100)
    .compose();

  /*
  bubbleSort();
   
   for (int i = itinerant.size()-1; i >0; i--) {
   //for (int j = itinerant.size()-1; j >0; j--) {
   itinerant.get(i).makePoints();
   
   //if (i < itinerant.size()-1) {
   //      connectTheDots(itinerant.get(i), itinerant.get(j));
   //}
   //}
   }
  /*
   shapeMode(CENTER);
   
   beginShape();
   for (int i = 0; i < itinerant.size()-1; i++) {
   itinerant.get(i).update();
   itinerant.get(i).makeLines();
   }
   endShape();
   */

  if (cameraZoom < -8500) {
    cameraZoom+=5;
  }

  surface.setTitle("RENDERING [FPS: " + String.format("%.2f", frameRate) + ", COUNT: "+frameCount+"]" + "Arbitrary Lorenz Z: " + itinerant.get(5000));
}

public void convertPixelsToObjects() {
  /*
  for (int i = itinerant.size() - 1; i >= 0; i--) {
   itinerant.remove(i);
   }
   */
  img.loadPixels();

  for (int x = 0; x < img.width/vScale; x +=vScale) {

    for (int y = 0; y < img.height/vScale; y +=vScale) {

      int index = (x+y*img.width);
      int xModifier = (width/2-img.width/2);
      int yModifier = (height/2-img.height/2);
      int zModifier = 0;

      int [] info = new int[5]; //Contains all information needed for the object
      if (index < floor(width*height/vScale)) {
        info[0] = img.get(floor(x*vScale), floor(y*vScale)); //color
        //info[1] = round(brightness(info[0]));
        info[2] = xModifier+(x*vScale);//x-position
        info[3] = yModifier+(y*vScale); //y-position
        //info[4] = zModifier;
        itinerant.add(new Itinerant(info));
      }
    }
  }
}

//This is terrible
public void bubbleSort()
{
  int n = itinerant.size();
  for (int i = 0; i < n-1; i++) {
    sorted.set(i, itinerant.get(i));
  }

  for (int i = 0; i < n-1; i++)
    for (int j = 0; j < n-i-1; j++)
      if (sorted.get(j).y > sorted.get(j+1).y)
      {

        Itinerant temp = sorted.get(j);
        sorted.set(j, sorted.get(j+1));
        sorted.set(j+1, temp);
      }
}

public void connectTheDots(Itinerant a, Itinerant b) {
  line(a.x, a.y, a.z, b.x, b.y, b.z);
}
