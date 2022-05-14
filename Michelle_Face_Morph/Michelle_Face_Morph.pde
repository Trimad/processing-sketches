/*
  public final static String CASCADE_FRONTALFACE = "haarcascade_frontalface_alt.xml";
  public final static String CASCADE_PEDESTRIANS = "hogcascade_pedestrians.xml";
  public final static String CASCADE_EYE = "haarcascade_eye.xml";
  public final static String CASCADE_CLOCK = "haarcascade_clock.xml";
  public final static String CASCADE_NOSE = "haarcascade_mcs_nose.xml";
  public final static String CASCADE_MOUTH = "haarcascade_mcs_mouth.xml";
  public final static String CASCADE_UPPERBODY = "haarcascade_upperbody.xml";
  public final static String CASCADE_LOWERBODY = "haarcascade_lowerbody.xml";
  public final static String CASCADE_FULLBODY = "haarcascade_fullbody.xml";
  public final static String CASCADE_PEDESTRIAN = "hogcascade_pedestrians.xml";
  public final static String CASCADE_RIGHT_EAR = "haarcascade_mcs_rightear.xml";
  public final static String CASCADE_PROFILEFACE = "haarcascade_profileface.xml";
*/

import gab.opencv.*;
import java.awt.Rectangle;

PImage face_a;
OpenCV face_a_OCV;
ArrayList<PVector> face_a_points= new ArrayList<PVector>();

PImage face_b;
OpenCV face_b_OCV;
ArrayList<PVector> face_b_points= new ArrayList<PVector>();

// A Morphing object
Morpher morph;
// How much to morph, 0 is image A, 1 is image B, everything else in between
float amt = 0;
// Morph bar position
float x = 100; 

void setup() {
  size(1024, 1024, P2D);
  /* * * * * * * * * * * * * * * * * * * * * */
  face_a = loadImage("face1.jpg");
  face_a_OCV = new OpenCV(this, face_a);
  getPointsFromFace(face_a_points, face_a);
  /* * * * * * * * * * * * * * * * * * * * * */
  face_b = loadImage("face2.jpg");
  face_b_OCV = new OpenCV(this, face_b);
  getPointsFromFace(face_b_points, face_b);
  /* * * * * * * * * * * * * * * * * * * * * */
  morph = new Morpher(face_a, face_b);

  for (int i = 0; i < face_a_points.size(); i++) {
    morph.addPair(face_a_points.get(i), face_a_points.get(i));
  }
}



void draw() {
  background(0);
  pushMatrix();
  // Show Image A and its triangles
  morph.displayImageA();
  morph.displayTrianglesA();
  // Show Image B and its triangles
  translate(face_a.width, 0);
  morph.displayImageB();
  translate(-face_a.width, face_a.height);
  // Update the amount according to mouse position when pressed
  if (mousePressed && mouseY > face_a.height) {
    x = constrain(mouseX, 100, width-100);
    amt = map(x, 100, width-100, 0, 1);
  }
  // Morph an amount between 0 and 1 (0 being all of A, 1 being all of B)
  morph.drawMorph(amt);
  popMatrix();
  // Have you clicked on the images?
  if (va != null) {
    fill(255, 0, 0);
    ellipse(va.x, va.y, 8, 8);
  }
  if (vb != null) {
    fill(255, 0, 0);
    ellipse(vb.x, vb.y, 8, 8);
  }
  // Draw bar at bottom
  stroke(255);
  line(100, height-50, width-100, height-50);
  stroke(255);
  line(x, height-75, x, height-25);

  noFill();
  stroke(0, 255, 0);
  strokeWeight(3);
}



// Variables to keep track of mouse interaction
int counter = 0;
PVector va;
PVector vb;
void mousePressed() {
  // If we clicked on an image
  if (mouseY < face_a.height) {
    // Point on image A first
    if (counter == 0) {
      va = new PVector(mouseX, mouseY);
    }
    // Corresponding point on image B
    else if (counter == 1) {
      PVector vb = new PVector(mouseX-face_a.width, mouseY);
      morph.addPair(va, vb);
    }
    // Increment click counter
    counter++;
    if (counter == 2) {
      // Start over
      counter = 0;
      va = null;
      vb = null;
    }
  }
}

void getPointsFromFace(ArrayList<PVector> points, PImage img) {
  OpenCV opencv;
  Rectangle[] faces;
  opencv = new OpenCV(this, img);
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);
  faces = opencv.detect();
  Rectangle face = faces[0];

  points.add(new PVector(face.x, face.y));
  points.add(new PVector(face.x+face.width, face.y));
  points.add(new PVector(face.x+face.width, face.y+face.height));
  points.add(new PVector(face.x, face.y+face.height));
}
