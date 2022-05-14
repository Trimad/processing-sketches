class Queue {

  Animooted[] animationObj;
  int front, rear, queueSize, numberOfItems = 0;

  Queue(int size) {

    queueSize = size;
    animationObj = new Animooted[size];
  }

  public void add(Animooted input) {

    //Check if there is enough room inside the array
    if (numberOfItems + 1 <= queueSize) {
      //Characters are added to the rear of the queue
      animationObj[rear] = input;
      rear++;
      numberOfItems++;
    }
  }

  public void remove() {

    if (numberOfItems > 0) {
      animationObj[front] = null;
      front++;
      numberOfItems--;
    }
  }

  public Animooted get(int index) {
    
    
    if (queueSize >= 0) {
            return animationObj[front];
        } else {
            return null;

        }
  }
}