import processing.sound.*;

public class Animooted {

  //Image Stuff
  PImage[] images;
  int imageCount;
  int lifeSpan;
  float xpos;
  float ypos;
  float imgWidth;
  float imgHeight;
  boolean soundPlayed;

  //Sound Stuff
  SoundFile sound;

  Animooted(float xposIn, float yposIn, float imgWidthIn, float imgHeightIn) {

    images = new PImage[imageCount];

    this.soundPlayed=false;
    this.xpos = xposIn;
    this.ypos = yposIn;
    this.imgWidth = imgWidthIn;
    this.imgHeight = imgHeightIn;
  }

  //Copy Constructor
  Animooted(Animooted a) {

    this.xpos = a.xpos;
    this.ypos = a.ypos;
    this.imgWidth = a.imgWidth;
    this.imgHeight = a.imgHeight;
    
  }

  void loadMedia(String imagePrefix, int count, SoundFile soundIn) {
    this.imageCount = count;
    this.lifeSpan = count;
    this.sound = soundIn;

    for (int i = 0; i < imageCount; i++) {
      // Use nf() to number format 'i' into four digits
      String filename = imagePrefix + nf(i, 4) + ".png";
      print(i);
      images[i] = loadImage(filename);
    }
  }




  void show() {

    for (int i = 0; i<imageCount; i++) {
      if (frameCount%imageCount==i) {
        image(images[i], this.xpos, this.ypos, this.imgWidth, this.imgHeight);
      }
    }

    if (!soundPlayed) {
      float rate = random(0.1, 2);
      float amp = random(0.1, 1);

      this.sound.play(rate, amp);
      soundPlayed=true;
    }
    this.lifeSpan-=1;
  }

  boolean isDead () {
    if (this.lifeSpan < 0) {
      return true;
    } else {
      return false;
    }
  }
}