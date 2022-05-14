//1,3,6,7,13,20,21,22,23,24,25,43,62,63,42
ArrayList<Arc> arcs = new ArrayList<Arc>();
ArrayList<Boolean> numbers = new ArrayList<Boolean>();
IntList sequence = new IntList();
float scl = 0;
int biggest = 0;
int count = 1;
int index = 0;
void setup() {
  fullScreen();
  //size(3840,2160, P3D);
  background(0);
  strokeCap(SQUARE);
  numbers.add(true);
  sequence.append(index);
}
void step() {
  int next = index - count;
  if (next < 0 || numbers.get(next)) {
    next = index + count;
  }
  if (numbers.size() <= next) {
    for (int i = numbers.size(); i <= next; i++) {
      numbers.add(i, false);
    }
  }
  numbers.set(next, true);
  sequence.append(next);
  Arc a = new Arc(index, next, frameCount % 2);
  arcs.add(a);
  index = next;
  if (index > biggest) {
    biggest = index;
  }
  count++;
}
void draw() {

  step();
  scl = lerp(scl, width / biggest, 0.1);
  translate(0, height *0.5);
  scale(scl);
  background(0);
  for (Arc a : arcs) {
    a.show();
  }
  if (arcs.size() > 1000) {
    arcs.remove(0);
  }
  
     saveFrame("frame-####.png");

}
