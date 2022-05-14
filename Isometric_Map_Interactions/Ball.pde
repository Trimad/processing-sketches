class Ball {

  boolean jump;
  int ground;
  int diameter;
  int time;
  int x;
  int y;
  int z;

  Ball(int _x, int _y, int _z, int _diameter) {
    this.x = _x;
    this.y = _y;
    this.z = _z;
    this.diameter = _diameter;
  }

  public void update() {

    //Temporary for YouTube video
    if (frameCount >= 60) {
      if (this.x >0) {
        this.x--;
      } else {
        this.x = mapSize-1;
      }
    }

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
  public void display(PImage _tex) {


    int size = w/2;
    translate(-this.x*w, -this.y+w, -this.z*w);
    sphere(this.diameter);
    /*
    beginShape(QUADS);
    texture(_tex);
    vertex(-size, 0-w, size, 0, 0);
    vertex( size, 0-w, size, _tex.width/8, 0);
    vertex( size, 0, size, _tex.width/8, _tex.width/8);
    vertex(-size, 0, size, 0, _tex.width/8);
    endShape();
    */
    translate(this.x*w, this.y-w, this.z*w);
  }

  public void getPosition(char input) {

    switch(input) {
    case 'w':
      if (this.z < mapSize-1) {
        this.z++;
      } else {
        this.z = 0;
      }
      break;
    case 'd':
      if (this.x >0) {
        this.x--;
      } else {
        this.x = mapSize-1;
      }
      break;
    case 's':
      if (this.z >0) {
        this.z--;
      } else {
        this.z = mapSize-1;
      }
      break;

    case 'a':
      if (this.x < mapSize-1) {
        this.x++;
      } else {
        this.x = 0;
      }
      break;
    case ' ':
      this.jump = true;
      break;
    }
    
    /***
    *
    * THIS DETERMINES THE Y-POSITION OF THE SPRITE!!!
    *
    **/
    int a = grid[this.x][this.z].y;
    int b = grid[this.x][this.z].noiseModifier;
    int c = (w) + this.diameter/2;
    ground = a +  b + c;
    this.y = ground;
  }

  public void randomWalk() {

    if (frameCount%1==0) {
      int r = (int)random(5);

      switch(r) {
      case 0:
        getPosition('w');
        break;
      case 1:
        getPosition('a');
        break;
      case 2:
        getPosition('s');
        break;
      case 3:
        getPosition('d');
        break;
      case 4:
        getPosition(' ');
        break;
      }
    }
  }
}