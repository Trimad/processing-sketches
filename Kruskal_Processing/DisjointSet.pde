class DisjointSet {
  int parent[];
  DisjointSet(int size) {
    parent = new int[size];
    for (int i = 0; i < size; i++)
      parent[i] = i;
  }
  int find(int x) {
    if (parent[x] != x)
      parent[x] = find(parent[x]);  // path compression
    return parent[x];
  }
  void union(int x, int y) {
    parent[find(x)] = find(y);
  }
}
