import java.util.Collections;
import java.util.Comparator;

final int N_NODES = 128;
int nodeCount = 0;
ArrayList<Node> nodes = new ArrayList();
ArrayList<Edge> edges = new ArrayList();
ArrayList<Edge> mst = new ArrayList();

void setup() {
  size(1024, 1024);
  background(0);
  for (int i = 0; i < N_NODES; i++) {
    nodes.add(new Node(int(random(16, width-16)), int(random(16, height-16))));
  }

  MSTKruskal(nodes);

  for (Edge e : edges) {
    stroke(255, 10);
    e.draw();
  }

  for (Edge e : mst) {
    stroke(255);
    e.draw();
  }

  for (Node n : nodes) {
    stroke(255);
    strokeWeight(8);
    n.draw();
  }

  noLoop();
   saveFrame("kruskal.png");

}

void MSTKruskal(ArrayList<Node> nodes) {

  for (Node a : nodes) {
    for (Node b : nodes) {
      if (a.id < b.id)
        edges.add(new Edge(a, b));
    }
  }

  DisjointSet grouping = new DisjointSet(edges.size());

  Collections.sort(edges);

  for (Edge e : edges) {
    if (grouping.find(e.a.id) != grouping.find(e.b.id)) {
      mst.add(new Edge(e.a, e.b));
      grouping.union(e.a.id, e.b.id);
    }
  }
  
}
