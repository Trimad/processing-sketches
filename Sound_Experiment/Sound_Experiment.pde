Zone[] zone = new Zone[9];

void setup()
{

  //fullScreen();
  size(1920, 1080);

  //Top
  zone[0]= new Zone(0, 0, width*0.3333, height*0.3333);
  zone[1]= new Zone(width*0.3333, 0, width*0.3333, height*0.3333);
  zone[2]= new Zone(width*0.6666, 0, width*0.3333, height*0.3333);

  zone[3]= new Zone(0, height*0.3333, width*0.3333, height*0.3333);
  zone[4]= new Zone(width*0.3333, height*0.3333, width*0.3333, height*0.3333);
  zone[5]= new Zone(width*0.6666, height*0.3333, width*0.3333, height*0.3333);

  zone[6]= new Zone(0, height*0.6666, width*0.3333, height*0.3333);
  zone[7]= new Zone(width*0.3333, height*0.6666, width*0.3333, height*0.3333);
  zone[8]= new Zone(width*0.6666, height*0.6666, width*0.3333, height*0.3333);
}

void draw()
{
  for (int i = 0; i < 9; i++) {
    zone[i].update();
    zone[i].display();
  }
}