class Race {

  String name;
  ArrayList <Crime> crime = new ArrayList<Crime>();
  int index;

  Race(String _name, int _index) {
    this.index = _index; 
    this.name = _name;
  }

  void addCrime(String _name, int _num, int _total) {
    crime.add(new Crime(_name, _num, _total));
  }
  
}