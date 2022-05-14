import processing.sound.*;

public class Animated {

  //Image Stuff
  PImage[] images;
  int imageCount;
  int lifeSpan;
  boolean soundPlayed =false;

  //Sound Stuff
  SoundFile sound;

  Animated() {
  }

  /*
  //Copy Constructor
   Animooted(Animooted a, float xposIn, float yposIn, float imgWidthIn, float imgHeightIn) {
   
   this.images=a.images;
   this.imageCount = a.imageCount;
   this.sound = a.sound;
   this.xpos = xposIn;
   this.ypos = yposIn;
   this.imgWidth = imgWidthIn;
   this.imgHeight = imgHeightIn;
   }
   */

  void loadMedia(String filePrefix, int count, SoundFile soundIn) {

    imageCount = count;
    lifeSpan = count;
    sound = soundIn;

    images = new PImage[imageCount];

    for (int i = 0; i < imageCount; i++) {
      // Use nf() to number format 'i' into four digits
      String filename = filePrefix + nf(i, 4) + ".png";
      images[i] = loadImage(filename);
    }
  } 

  void show(float xpos, float ypos, float imgWidth, float imgHeight) {

    for (int i = 0; i<imageCount; i++) {
      if (frameCount%imageCount==i) {
        image(images[i], xpos, ypos, imgWidth, imgHeight);
      }
    }
    this.lifeSpan-=1;
  }

  void playSound() {

    if (!soundPlayed) {
      float rate = random(0.1, 2);
      float amp = random(0.1, 1);

      this.sound.play(rate, amp);
      soundPlayed=true;
    }
  }

  boolean isDead () {
    if (this.lifeSpan < 0) {
      return true;
    } else {
      return false;
    }
  }
}