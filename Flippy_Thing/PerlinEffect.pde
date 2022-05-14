public class PerlinEffect implements Effect {

    private float flying = 0;
    PApplet parent;

    PerlinEffect(PApplet p) {
        this.parent = p;
    }

    /*
    "howMuch" in this context refers to how how quickly the perlin noise pattern
    flies by.
     */
    @Override
    public void apply(Tile[][] tiles, float howMuch) {

        parent.background(0,0);

        flying += howMuch;
        float yoff = flying;
        for (int x = COLS - 1; x >= 0; x--) {
            float xoff = 0;

            for (int y = ROWS - 1; y >= 0; y--) {
                float m = parent.noise(xoff, yoff);
                if (parent.frameCount % 1 == 0) {
                    if (m >= 0.6) {
                        tiles[x][y].flip();
                    }
                }
                xoff += 0.2;

                tiles[x][y].update(10);
                tiles[x][y].show();

            }
            yoff += 0.2;
        }
        //Draw all the tiles that are currently in a flip state.
        for (int x = COLS - 1; x >= 0; x--) {
            for (int y = ROWS - 1; y >= 0; y--) {
                if (tiles[x][y].flip) {
                    tiles[x][y].show();
                }
            }
        }
    }

}
