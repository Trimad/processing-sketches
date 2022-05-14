
class Clock {

  PVector center;
  PVector clockHandPosition;
  float diameter;
  float radius;

  Clock(PVector v, float diameter) {
    this.center = v;
    this.diameter = diameter;
    this.radius = diameter/2;
    this.clockHandPosition = new PVector(0, 0);
  }

  void tick() {
    angle+= STEP;
    clockHandPosition.x = center.x + radius * cos(angle);
    clockHandPosition.y = center.y + radius * sin(angle);
  }

  void layerA() {

    push();
    translate(width/4, -200);
    rotate(PI/4);
    fill(0, 127);
    circle(center.x, center.y, diameter);
    line(center.x-radius, center.y, center.x+radius, center.y);
    line(center.x, center.y-radius, center.x, center.y+radius);
    pop();

    fill(0);
    curvedMessage("STRONG MEN CREATE GOOD TIMES", center, 2.39, radius-30);
    curvedMessage("GOOD TIMES CREATE WEAK MEN", center, 4, radius-30);
    curvedMessage("WEAK MEN CREATE HARD TIMES", center, 5.58, radius-34);
    curvedMessage("HARD TIMES CREATE STRONG MEN", center, 0.80, radius-30);
    fill(255);
    curvedMessage("STRONG MEN CREATE GOOD TIMES", center, 2.39, radius-32);
    curvedMessage("GOOD TIMES CREATE WEAK MEN", center, 4, radius-32);
    curvedMessage("WEAK MEN CREATE HARD TIMES", center, 5.58, radius-32);
    curvedMessage("HARD TIMES CREATE STRONG MEN", center, 0.80, radius-32);
  }

  void layerB() {
    push(); 
    line(center.x, center.y, clockHandPosition.x, clockHandPosition.y);
    fill(0);
    circle(clockHandPosition.x, clockHandPosition.y, 12);
    circle(center.x, center.y-1, 12);
    pop();
  }

  PVector getPosition() {
    return clockHandPosition;
  }
}

void curvedMessage(String message, PVector center, float startingAngle, float radius) {

  textFont(f);

  // We must keep track of our position along the curve
  float arclength = 0;

  // For every box
  for (int i = 0; i < message.length(); i++)
  {
    // Instead of a constant width, we check the width of each character.
    char currentChar = message.charAt(i);
    float w = textWidth(currentChar);

    // Each box is centered so we move half the width
    arclength += w/2;
    // Angle in radians is the arclength divided by the radius
    // Starting on the left side of the circle by adding PI
    float theta = (startingAngle+PI/2) + arclength / radius;    

    pushMatrix();
    // Polar to cartesian coordinate conversion
    translate(center.x+radius*cos(theta), center.y+radius*sin(theta));
    // Rotate the box
    rotate(theta+PI/2); // rotation is offset by 90 degrees
    // Display the character
    text(currentChar, 0, 0);
    popMatrix();
    // Move halfway again
    arclength += w/2;
  }
}
