import peasy.*;

Year [] year = new Year[6];

boolean mapLoaded = false;
PeasyCam cam;
PImage whiteSkin;
PImage blackSkin;
PImage asianSkin;
PImage nativeSkin;
PImage totalSkin;
Table table;
int step = 0;
int spacing = 256+128;
int w = 256;

int yearCycle = 0;

public void setup() {

  year[0] = new Year(2010);
  year[0].loadCSV("2010.csv");

  year[1] = new Year(2011);
  year[1].loadCSV("2011.csv");

  year[2] = new Year(2012);
  year[2].loadCSV("2012.csv");

  year[3] = new Year(2013);
  year[3].loadCSV("2013.csv");

  year[4] = new Year(2014);
  year[4].loadCSV("2014_Percent.csv");

  year[5] = new Year(2015);
  year[5].loadCSV("2015_Percent.csv");

  cam = new PeasyCam(this, 1024);

  fullScreen(P3D);
  //size(1400, 1400, P3D);
  //frameRate(30);
  whiteSkin = loadImage("assets/white.jpg");
  blackSkin = loadImage("assets/black.jpg");
  nativeSkin = loadImage("assets/native.jpg");
  asianSkin = loadImage("assets/asian.jpg"); 
  totalSkin = loadImage("assets/total.png");
}

public void draw() {
  background(0);
  ambientLight(255, 255, 255);
  textureMode(IMAGE);
  textureWrap(REPEAT); 

  translate(width/2-(step*spacing), height*0.75, -1024);
  makeIsometric();
  
  //rotateY(frameCount*0.001);
  //rotateX(-atan(1 / sqrt(2)));
  if (frameCount%60==0) {
    //step+=1;
  }

  makeLines();
  if (mapLoaded) {
    switch(yearCycle) {
    case 0:
      year[0].showGraph();
      break;
    case 1:
      year[1].showGraph();
      break;
    case 2:
      year[2].showGraph();
      break;
    case 3:
      year[3].showGraph();
      break;
    case 4:
      year[4].showGraph();
      break;
    case 5:
      year[5].showGraph();
      break;
    }
  }
}

void makeIsometric() {
  rotateX(-atan(1 / sqrt(2)));
  rotateY(QUARTER_PI);
}

void keyReleased() {
  switch(key) {
  case 'w':
    //for every year
    for (int i = 0; i < year.length; i++) {
      //for every race category in that year
      for (int z = 0; z < year[i].race.size(); z++) {
        //for every crime committed by that race
        for (int y = 0; y < year[i].race.get(0).crime.size(); y++) {
          year[i].graph[z][y].z++;
          if (year[i].graph[z][y].z >= year[i].race.size()) {
            year[i].graph[z][y].z = 0;
          }
        }
      }
    }
    break;
  case 'd': 
    step++;
    break;
  case 's':
    //for every year
    for (int i = 0; i < year.length; i++) {
      //for every race category in that year
      for (int z = 0; z < year[i].race.size(); z++) {
        //for every crime committed by that race
        for (int y = 0; y < year[i].race.get(0).crime.size(); y++) {
          year[i].graph[z][y].z--;
          if (year[i].graph[z][y].z < 0) {
            year[i].graph[z][y].z = year[i].race.size()-1;
          }
        }
      }
    }
    break;
  case 'a': 
    step--;
    break;
  case 'q':
    if (yearCycle > 0) {
      yearCycle--;
    }

    break;
  case 'e':

    if (yearCycle < year.length-1) {
      yearCycle++;
    }

    break;
  }
}

public void makeLines() {

  strokeWeight(1);

  int xTemp = year[yearCycle].race.get(0).crime.size();
  int zTemp = year[yearCycle].race.size();
  int xWidth = xTemp*spacing;
  int zDeepness = zTemp*spacing;

  //z-axis, red
  stroke(255, 100, 100);
  line(-w/2, 0, 0, -w/2, 0, -4096*2);

  //y-axis, blue
  stroke(100, 255, 100);
  line(-w/2, 0, w/2, -w/2, -4096, w/2);

  //x-axis, green
  stroke(200, 200, 255);
  fill(51);

  translate(xWidth/2-w/2, 1, -zDeepness/2+w/2);
  box(xWidth, 0, zDeepness);
  translate(-xWidth/2+w/2, -1, zDeepness/2-w/2);

  //Show the CURRENT YEAR
  textSize(512);
  noStroke();
  fill(255);
  rotateX(PI/2);
  text("FBI Table 43A: "+year[yearCycle].num, 2000 + spacing, -zTemp*spacing, 1);
  rotateX(-PI/2);
  //Line properties for the bars
  noStroke();
  noFill();
}