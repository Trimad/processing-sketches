import processing.sound.*; //<>//

import org.openkinect.processing.*;
import processing.sound.*;

//Image Stuff
String filePrefix = "Weed_";
int numImages = 65;
PImage bg;

// Depth threshold
int threshold = 745;

//Queue Stuff
Queue queue;

//Kinect Stuff
Kinect2 kinect2;
PImage kinectImg;

float minThresh = 480;
float maxThresh = 830;

//Sound Stuff
SoundFile file;

Animooted animoot = new Animooted(mouseX, mouseY, 128, 128);

void setup() {

  size(1024, 848, P3D);
  //fullScreen(P3D);
  bg = loadImage("bg1.jpg");

  //Kinect Stuff
  kinect2 = new Kinect2(this);
  kinect2.initDepth();
  kinect2.initDevice();

  //Queue Stuff
  queue = new Queue(51200);

  //Sound Stuff
  file = new SoundFile(this, "barking1.mp3");
  
  animoot.loadMedia(filePrefix,numImages,file);
}

void draw() {

  // Being overly cautious here
  //if (depth == null || img == null) return;

  if (frameCount%30==0) {
    file.loop(random(0.1, 2));
  }
  kinectImg = kinect2.getDepthImage();
  image(bg, 0, 0);

  float sumX = 0;
  float sumY = 0;
  float totalPixels = 0;
  int skip =4;

  for (int x = 0; x < kinectImg.width; x+=skip) {
    for (int y = 0; y < kinectImg.height; y+=skip) {

      int index = x + y * kinectImg.width;

      float b = brightness(kinectImg.pixels[index]);
      float z = map(b, 0, 255, 250, -250);


      if (b>128) {

        queue.add(new Animooted(animoot));
        
      }
      /*
      pushMatrix();
       translate(x*(width/512), y*(height/424), z);
       for (int in = 0; in < queue.queueSize-1; in++) {
       queue.get(in).show();
       }
       
       //animoot.show(0, 0, b*2, b*2);
       popMatrix();
       
       */
    }
  }
  
  for(int i = 0; i < queue.numberOfItems; i++){
  
    queue.get(i).show();
  
  
  }
}