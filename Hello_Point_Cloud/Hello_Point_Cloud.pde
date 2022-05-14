import org.openkinect.processing.*; //<>//
import processing.sound.*;

// Kinect Library object
Kinect2 kinect2;

// Camera Variables
float a = 0;

int xtranslation = 0;
int ytranslation = 420;
int ztranslation = -1500;

//Animated Stuff
Animated animated = new Animated();
String filePrefix = "cool_";
int numFiles = 38;
SoundFile dogBark;
//Misc
PImage bgImg;

void setup() {
  //Canvas Stuff
  //size(1920, 1080, P3D);
  fullScreen(P3D);
  //Kinect Stuff
  kinect2 = new Kinect2(this);
  kinect2.initDepth();
  kinect2.initDevice();

  //Animation Stuff
  animated.loadMedia(filePrefix, numFiles, dogBark);
  dogBark = new SoundFile(this, "barking1.mp3");

  bgImg = loadImage("bg1.jpg");

  imageMode(CENTER);
}

void draw() {

  background(0);

  // Translate and rotate
  pushMatrix();
  //translate(width/2, height/2, -1500);
  translate(xtranslation, ytranslation, ztranslation);
  rotateY(a);

  // We're just going to calculate and draw every 4th pixel
  int skip = 2;

  // Get the raw depth as array of integers
  int[] depth = kinect2.getRawDepth();

  stroke(255);
  strokeWeight(2);
  beginShape(POINTS);
  for (int x = 0; x < kinect2.depthWidth; x+=skip) {
    for (int y = 0; y < kinect2.depthHeight; y+=skip) {
      int offset = x + y * kinect2.depthWidth;
      int d = depth[offset];
      //calculte the x, y, z camera position based on the depth information
      PVector point = depthToPointCloudPos(x, y, d);

      // Draw a point
      
      if (point.z>500 && point.z<1000) {
      stroke(255, random(100), 0);
      }else{
      stroke(255);
      }
      
      vertex(point.x, point.y, point.z);

      //lastPoint=point;
      /*
      if (point.z>500 && point.z<1000) {
       animated.show(point.x, point.y, point.z/30, point.z/30);
       }
       
       */
    }
  }
  endShape();
  popMatrix();

  //FPS Counter
  fill(255);
  text(frameRate, 50, 50);

  //Camera Controls
  if (keyPressed == true) {
    if (key == 'w') {
      ytranslation+=10;
    }  
    if (key == 's') {
      ytranslation-=10;
    } 
    if (key == 'a') {
      xtranslation -=10;
    } 
    if (key == 'd') {
      xtranslation +=10;
    }
    if (key == 'z') {
      ztranslation +=10;
    }
    if (key == 'q') {
      a -= 0.01;
    }
    if (key == 'c') {
      ztranslation -=10;
    }
    if (key == 'e') {
      a += 0.01;
    }
  }
}