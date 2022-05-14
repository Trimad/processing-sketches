import java.util.LinkedList; 
import java.util.Queue; 

class Curve {

  Queue<PVector> path; 
  PVector cursor;

  Curve() {
    path = new LinkedList();
    cursor = new PVector();
  }

  void setCursorX(float x) {
    cursor.x = x;
  }
  void setCursorY(float y) {
    cursor.y = y;
  }

  void addPoint() {
    path.add(cursor);
  }

  void reset() {
    path.clear();
  }
  void show() {

    stroke(255);
    strokeWeight(1);

    //Draw the trail
    beginShape();
    for (PVector v : path) {
      vertex(v.x, v.y);
    }
    endShape();
    //Draw the cursor
    //translate(cursor.x, cursor.y);
    //sphere(8);
    //translate(-cursor.x, -cursor.y);
    stroke(255);
    strokeWeight(10);
    point(cursor.x, cursor.y);
    cursor = new PVector();

    //FIFO
    if (path.size() > 500) {
      path.remove();
    }
  }
}
