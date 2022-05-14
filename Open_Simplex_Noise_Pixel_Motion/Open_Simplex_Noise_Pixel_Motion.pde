//ffmpeg -i test2.mp4 -i erased.mp3 -codec copy -shortest output.mp4
//ffmpeg -r 60 -f image2 -s 3840x2160 -i frame-%04d.tif -c:v libx264 -preset slow -profile:v high -crf 9 -coder 1 -pix_fmt yuv420p -movflags +faststart -g 30 -bf 2 -c:a aac -b:a 384k -profile:a aac_low test4.mp4

import ch.bildspur.postfx.builder.*;
import ch.bildspur.postfx.pass.*;
import ch.bildspur.postfx.*;

OpenSimplexNoise noise;
PostFX fx;

ArrayList<Itinerant> itinerant = new ArrayList<Itinerant>();
PImage img;

void settings(){
  //fullScreen(P3D);
  size(2400, 600, P3D);
}
void setup() {


  fx = new PostFX(this);  
  //strokeCap(SQUARE);
  noise = new OpenSimplexNoise();
  img = loadImage("01.jpg");
  convertPixelsToObjects();
  background(0);
  translate(0, 0, 320);
  //image(img, width/2-img.width/2, height/2-img.height/2);
}

void draw() {
  translate(0, 0, 320);
  background(0);
  //background(0);
  //image(img, width/2-img.width/2, height/2-img.height/2);

  for (int i = 0; i < itinerant.size(); i++) {
    itinerant.get(i).update();
  }
  /*
  fx.render()
   .bloom(0.2, 16, 32)
   //.rgbSplit(50)
   //.sobel()
   //.brightPass(0.2)
   .blur(3, 6)
   .compose();
   */
  // draw fps
  //surface.setTitle("RENDERING [FPS: " + String.format("%.2f", frameRate) + ", COUNT: "+frameCount+"]");

  //saveFrame("frame-####.tif");

  if (frameCount >= 1800) { //1 minute at 60FPS
    exit();
  }
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

      int xModifier = (width/2-img.width/2);
      int yModifier = (height/2-img.height/2);
      int [] info = new int[4]; //Contains all information needed for the object

      info[0] = img.get(x*vScale, y*vScale); //color
      info[1] = round(brightness(info[0]));
      info[2] = xModifier+(x*vScale);//x-position
      info[3] = yModifier+(y*vScale); //y-position
      //itinerant.add(new Itinerant(info));

      if (brightness(info[0])>5) {
        itinerant.add(new Itinerant(info));
      }
    }
  }
}
