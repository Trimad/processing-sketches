class Animooted {
  PImage[] images;
  int imageCount;
  int frame;

  Animooted(String imagePrefix, int count) {
    imageCount = count;
    images = new PImage[imageCount];

    for (int i = 0; i < imageCount; i++) {
      // Use nf() to number format 'i' into four digits
      String filename = imagePrefix + nf(i, 4) + ".png";
      images[i] = loadImage(filename);
    }
  }

  void show(float xpos, float ypos) {

    for (int i = 0; i<imageCount; i++) {

      frame = (frame+1) % imageCount;
      if (frameCount%imageCount==i) {
        background(0);
        image(images[frame], xpos, ypos);
      }
    }
  }
}