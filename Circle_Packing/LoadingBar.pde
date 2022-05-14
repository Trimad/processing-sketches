class LoadingBar {

  float percentComplete=0;

  LoadingBar() {
  }

  void update(int status, int iterations) {
    if(status != 0)
    percentComplete = iterations/status;
  }

  void show() {

    fill(200, 0, 0);

    float m = map(percentComplete, 0, width, 0, 100);
    rect(0, 0, m, height);
  }
}
