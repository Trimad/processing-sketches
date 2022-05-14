class Datum {
  color c;
  float[] data;

  Datum(color c, float[] data) {

    this.c = c;
    this.data = data;
  }

  public double dist(Datum other) {
    float xDist = (this.data[0] - other.data[0])* (this.data[0] - other.data[0]);
    float yDist = (this.data[1] - other.data[1]) * (this.data[1] - other.data[1]);
    float zDist = (this.data[2] - other.data[2]) * (this.data[2] - other.data[2]);
    return Math.sqrt(xDist+yDist+zDist);
  }

  public void div(int n) {
    for (float d : this.data) {
      d/=n;
    }
  }

  public void add(int n) {
    for (float d : this.data) {
      d+=n;
    }
  }

  public void add(Datum other) {
    for (int i = 0; i < this.data.length; i++) {
      this.data[i] += other.data[i];
    }
  }

  public void wiggle() {
    for (int i = 0; i < this.data.length; i++) {
      this.data[i] += random(-0.002, 0.002);
    }
  }
}
