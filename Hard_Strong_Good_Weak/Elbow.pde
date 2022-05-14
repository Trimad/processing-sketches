//class Elbow {

//  Elbow() {
//  }

//  //Look up the law of sines!
//  void getPositions(PVector a, PVector b) {

//    PVector c = new PVector((a.x+b.x)/2, (height>>1));
//    PVector d = new PVector(c.x, a.y);
//    float angleAC = PVector.angleBetween(a, c);
//    float angleAD = PVector.angleBetween(a, d);

//    fill(127, 127);
//    stroke(255);
//    //circle(c.x, c.y, 16);
//    //circle(d.x, d.y, 16);
//    stroke(255);

//    push();
//    stroke(255, 127, 127);
//    line(a.x, a.y, c.x, c.y);
//    line(a.x, a.y, d.x, d.y);
//    pop();

//    push();
//    stroke(127, 255, 255);
//    line(c.x, c.y, d.x, d.y);
//    pop();

//    push();
//    stroke(255, 127, 255);
//    line(b.x, b.y, c.x, c.y);
//    line(b.x, b.y, d.x, d.y);

//    pop();
//    textSize(42);
//    text("A", a.x, a.y);
//    text("B", b.x, b.y);
//    text("C", c.x, c.y);
//    text("D", d.x, d.y);
//  }
//}
