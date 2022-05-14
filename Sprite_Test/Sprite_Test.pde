Animooted animoot;
PImage redness;
boolean imgDropped;

void setup() {
  size(225, 300);
  animoot = new Animooted("Test_", 4);
}

void draw() {
  background(0);
  animoot.show(20, 20);
}
