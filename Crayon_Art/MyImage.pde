class MyImage {

  PVector originalColors;
  PVector position;
  PVector mappedColors;

  MyImage(PVector originalColors, PVector position) {

    this.originalColors = originalColors;
    this.position = position;
  }

  void showPlot() {
    stroke(originalColors.x, originalColors.y, originalColors.z);
    point(originalColors.x, originalColors.y, originalColors.z);
  }

  void showoriginalColors() {
    stroke(originalColors.x, originalColors.y, originalColors.z);
    translate(-img.width, 0, 0);
    point(position.x*vScale, position.y*vScale, position.z*vScale);
    translate(img.width, 0, 0);
  }

  void showMappedColors() {
    stroke(mappedColors.x, mappedColors.y, mappedColors.z);
    translate(0, -img.height, 0);
    point(position.x*vScale, position.y*vScale, position.z*vScale);
    translate(0, img.height, 0);
  }

  void setMappedColors(PVector mappedColors) {
    this.mappedColors = mappedColors;
  }

  PVector getMappedColors() {
    return this.mappedColors;
  }
}
