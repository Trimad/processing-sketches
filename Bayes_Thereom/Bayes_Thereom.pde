float librarians = 10;
float farmers = 200;

void setup() {
  println(Posterior());
  noLoop();
}

void draw() {
}

//P(H)
//Probability that the hypothesis holds before considering any new evidence.
float Prior() {
  float x = librarians/(librarians+farmers);
  println("Prior: " + x);
  return x;
}

//P(E|H)
//The probability that we will see the evidence given the hypothesis is true.
float Likelihood(float howMuch) {
  return howMuch;
}

//P(¬H)
//Probability that the hypothesis doesn't hold before considering any new evidence.
float PriorFalse() {
  float x = farmers/(librarians+farmers);
  println("Prior False: " + x);
  return x;
}

//P(E|¬H)
//The probability of seeing the evidence, given that the hypothesis is not true. 
float LikelihoodFalse(float howMuch) {
  return howMuch;
}

//P(H|E)
//Probabbility the hypothesis holds, given the Evidence.
float Posterior() {
  float numerator = Prior()*Likelihood(0.4);
  float denominator = Prior()*Likelihood(0.4)+PriorFalse()*LikelihoodFalse(0.1);
  return numerator/denominator;
}
