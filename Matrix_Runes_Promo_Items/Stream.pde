class Stream {

  ArrayList<Symbol>symbols=new ArrayList();
  int totalSymbols = round(random(5, height/symbolSize-1));
  float speed = random(5,22);

  Stream() {
  }

  void generateSymbols(int x, float y) {

    int opacity = 255;
    boolean first = round(random(0, 3)) == 1;
    for (int i = 0; i <= this.totalSymbols; i++) {
      Symbol symbol = new Symbol(x, y, (int)this.speed, first, opacity);
      symbol.setToRandomSymbol();
      this.symbols.add(symbol);
      opacity -= (255 / this.totalSymbols / fadeInterval);

      y -= symbolSize;
      first = false;
    }
  }

  void render() {

    for (Symbol symbol : symbols) {

      if (symbol.first) {
        //fill(r, g, b);
        fill(255);
      } else {
        //fill(r, g, b, symbol.opacity/2);
        fill(255, symbol.opacity>>1);
      }

      text(symbol.value, symbol.x, symbol.y);

      symbol.rain();
      symbol.setToRandomSymbol();
    }
  }
}
