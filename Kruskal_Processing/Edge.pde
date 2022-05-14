public class Edge implements Comparable<Edge> {

  float distSq;
  Node a, b;

  Edge(Node a, Node b) {
    this.a = a;
    this.b = b;
    float dx = a.x - b.x;
    float dy = a.y - b.y;
    distSq = dx * dx + dy * dy;
  }

  @Override
    public int compareTo(Edge _e) {

    if (this.distSq > _e.distSq) {
      return 1;
    } else if (this.distSq < _e.distSq) {
      return -1;
    } else {
      return 0;
    }
  }

  void draw() {
    line(this.a.x, this.a.y, this.b.x, this.b.y);
  }
}
