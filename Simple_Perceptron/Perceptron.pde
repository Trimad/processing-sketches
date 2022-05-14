
//This is the activation function
int sign(float n) {
  if (n>=0) {
    return 1;
  } else {
    return -1;
  }
}


class Perceptron {
  float[] weights = new float[2];
  //learning rate
  float lr = 0.1;

  //Perceptron constructor
  Perceptron() {
    //Initialize the weights randomly
    for (int i = 0; i < weights.length; i++) {

      weights[i] = random(-1, 1);
    }
  }

  int guess(float[] inputs) {
    //The first thing we need to do is compute the weighted sum.
    float sum = 0;
    for (int i = 0; i < weights.length; i++) {
      //The sum of all the inputs multiplied by their corresponding weights
      sum+= inputs[i]*weights[i];
    }
    int output = sign(sum);
    return output;
  }

  void train(float[] inputs, int target) {
    int guess = guess(inputs);
    int error = target-guess;

    //Tune all the weights
    for (int i = 0; i < weights.length; i++) {

      weights[i]+=error*inputs[i]*lr;
    }
  }
}