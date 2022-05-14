ArrayList<Stream> streams = new ArrayList<Stream>();
float fadeInterval = 1.6;
float symbolSize = 0;
PFont myFont;
int r = 255;
int g = 255;
int b = 255; 
//int displayDensity=1; //COMMENT OUT WHEN IN ANDROID MODE
void settings() {
  fullScreen(P2D);
}
void setup() {
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

}
