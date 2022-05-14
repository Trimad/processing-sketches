int w = 64;
class Sprite {

  boolean jump;
  int ground;
  int diameter;
  int time;
  int x;
  int y;
  int z;
  
  /* FACING LEGEND *
   * 0 = standing
   * 1 = right
   * 2 = up
   * 3 = down
   * 4 = left
   * * * * * * * * */
  
  char direction;

  Sprite(int _x, int _y, int _z, int _diameter) {
    this.x = _x;
    this.y = _y;
    this.z = _z;
    this.diameter = _diameter;
  }

  public void update() {

    if (this.jump) {
      time--;
      this.y += 0.5f*10*time;
      if (this.y < ground) {
        this.jump = false;
        this.y = ground;
        time = 10;
      }
    }

    //Repeating inputs for smoother control
    if (keyPressed) {  
      if (key == 'w' || key == 'W'|| key == 'a'|| key == 'A'|| key == 's'|| key == 'S'|| key == 'd'|| key == 'D') {
        getPosition(key);
      }
    }
  }
  public void display() {

    switch(this.direction) {
    case 'w':
    
      translate(-this.x, -this.y, -this.z);
      shape(frame[4]);
      translate(this.x, this.y, this.z);
      break;
    case 'd':
      translate(-this.x, -this.y, -this.z);
      shape(frame[3]);
      translate(this.x, this.y, this.z);
      break;
    case 's':
      translate(-this.x, -this.y, -this.z);
      shape(frame[2]);
      translate(this.x, this.y, this.z);
      break;
    case 'a':
      translate(-this.x, -this.y, -this.z);
      shape(frame[1]);
      translate(this.x, this.y, this.z);
      break;
    default:
      translate(-this.x, -this.y, -this.z);
      shape(frame[0]);
      translate(this.x, this.y, this.z);
      break;
    }
  }

  public void getPosition(char input) {

    this.direction = input;

    switch(input) {
    case 'w':
      this.z++;
      break;
    case 'd':
      this.x--;
      break;
    case 's':
      this.z--;
      break;
    case 'a':
      this.x++;
      break;
    case ' ':
      this.jump = true;
      break;
    }
  }
}

PShape [] frame = new PShape[8];  // The PShape object


public void createFrames(PImage _tex) {

  for (int i = 0; i < frame.length; i++) {
    frame[i] = createShape();
    frame[i].beginShape(QUADS);
    frame[i].texture(_tex);
    frame[i].vertex(-w, 0-w, w, spriteWidth*i, 0);
    frame[i].vertex( w, 0-w, w, spriteWidth*(i+1), 0);
    frame[i].vertex( w, 0, w, spriteWidth*(i+1), spriteHeight);
    frame[i].vertex(-w, 0, w, spriteWidth*i, spriteHeight);
    frame[i].endShape();
  }
}