class Node {
  float x, y;
  int id;
  
  Node(int x, int y) {
    this.x = x;
    this.y = y;
    this.id = nodeCount++;
  }
  void draw() {
    point(this.x,this.y);
  }
}
