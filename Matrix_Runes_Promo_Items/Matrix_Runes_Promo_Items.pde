ArrayList<Stream> streams = new ArrayList<Stream>();
float fadeInterval = 1.6;
float symbolSize = 0;
PFont myFont;
int r = 255;
int g = 255;
int b = 255; 
int displayDensity=1; //COMMENT OUT WHEN IN ANDROID MODE
void settings() {
  size(512,512);
  //fullScreen();
}
void setup() {
  frameRate(60);

  symbolSize = floor((width*displayDensity)/(20*displayDensity));
  myFont = createFont("runes.ttf", symbolSize, false);
  textFont(myFont);
  textSize(symbolSize);

  float w = (width/symbolSize);
  for (int x=0, i = 0; i <= w; i++) {
    Stream stream = new Stream();
    stream.generateSymbols(x, random(-height, 0));
    streams.add(stream);
    x += symbolSize;
  }
}

void draw() {

  background(0);

  for (Stream stream : streams) {
    stream.render();
  }
  char[] title={'e', 'o', 'z', 'r', 'i', 'g', ' ', 'r', 'U', 'h', 'e', 's'};
  push();
  stroke(255);
  fill(255);
  textSize(width);
  textAlign(CENTER, CENTER);
  text('z', width>>1, height>>1);
  pop();
  record();
}

void record() {

  saveFrame("frames/frame-#####.png");

  if (frameCount>3600) {
    exit();
  }
}

//void touchStarted() {
//  println("touch moved");
//  //r = 255;
//  g = 0;
//  b = 0;
//}
//void touchEnded() {
//  println("touch moved");
//  //r = 255;
//  g = 255;
//  b = 255;
//}
