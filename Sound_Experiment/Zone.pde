

class Zone {

  final float x1;
  final float x2;
  final float y1;
  final float y2;

  boolean hovered;

  Zone(float x1temp, float y1temp, float x2temp, float y2temp) {

    this.x1 = x1temp;
    this.x2 = x2temp;
    this.y1 = y1temp;
    this.y2 = y2temp;
  }

  void display() {

    if (this.hovered) {
      fill(0, 255, 0);
    } else {
      fill(255, 0, 0);
    }  
    rect(this.x1, this.y1, this.x2, this.y2);
  }

  void update() {

    if (mouseX>this.x1 && mouseY >= this.y1
      &&mouseX<this.x1+(width*0.3333)&&mouseY<this.y1+(height*0.3333)) {
      this.hovered=true;
    } else {
      this.hovered=false;
    }
    
  }
  
}