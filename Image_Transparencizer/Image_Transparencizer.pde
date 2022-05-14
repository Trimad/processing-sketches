
PImage img = new PImage();

final int THRESHOLD = 210;
final File folder = new File("C:\\Users\\matte\\Desktop\\Image_Transparencizer\\data");
final File outputFolder = new File("C:\\Users\\matte\\Desktop\\Image_Transparencizer"+File.separator+"t-");

void setup() {

  File[] listOfFiles = folder.listFiles();

  for (File file : listOfFiles) {
    if (file.isFile()) {
      println(file);
      img = loadImage(file.getName());
      PImage output = new PImage(img.width, img.height, ARGB);

      for (int x = 0; x < img.width; x++) {
        for (int y = 0; y < img.height; y++) {
          int argb = img.pixels[y*img.width+x];

          //int a = (argb>>24)&0xFF;
          int a = 0;
          int r = (argb>>16)&0xFF;
          int g = (argb>>8)&0xFF;
          int b = (argb>>0)&0xFF;

          if (r >= 255-THRESHOLD && g >= 255-THRESHOLD && b >= 255-THRESHOLD) {
            //Make this pixel transparent  
            output.set(x, y, (a & 0xff) << 16 | (r & 0xff) << 16 | (g & 0xff) << 8 | (b & 0xff));
          } else {
            //Color this pixel in
            output.set(x, y, argb);
          }
        }
      }

      //Lastly, save the output image with transparency added.
      output.save(outputFolder+file.getName());
    }
  }

  exit();
}
