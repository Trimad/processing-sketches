class Year {

  int num;
  ArrayList<Race> race = new ArrayList<Race>();
  Bar[][] graph;

  Year(int _num) {
    this.num = _num;
  }

  void loadCSV(String name) {
    println("loadCSV()");
    table = loadTable(name, "header");
    int cols = table.getColumnCount();
    for (int i = 1; i < cols; i++) {
      String whatRace = table.getColumnTitle(i);
      race.add(new Race(whatRace, i-1));
      for (TableRow row : table.rows()) {
        String whatCrime = row.getString("Offenses Charged");
        int committed = row.getInt(whatRace);
        race.get(race.size()-1).addCrime(whatCrime, committed, row.getInt("TOTAL"));
      }
    }
    graph = new Bar[race.size()][race.get(0).crime.size()];
    for (int i = 0; i <= race.size()-1; i++) {
      this.makeGraph(race.get(i));
    }
  }

  void makeGraph(Race input) {
    println("makeGraph()");

    int wide = input.crime.size();

    for (int i = 0; i < wide; i++) {

      String a = input.name;
      String b = input.crime.get(i).name;
      int c = input.crime.get(i).committed;
      int d = input.index;
      int f = input.crime.get(i).total;
      //                Bar(int _x, int _y, int _z, String _label, String _type, int _total) {
      graph[d][i] = new Bar(i, c, d, b, a, f);
    }
    mapLoaded = true;
  }

  void showGraph() {
    for (int deep = 0; deep < race.size(); deep++) {
      for (int wide = 0; wide < race.get(0).crime.size(); wide++) {
        graph[deep][wide].display();
      }
    }
  }
}