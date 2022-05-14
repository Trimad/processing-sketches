public class RandomEffect implements Effect {

    PApplet parent;

    RandomEffect(PApplet p) {
        this.parent = p;
    }

    /*
    "howMuch" in this context refers to how many draw frames must go by before 
    the function is called. howMuch of 60 = 1 second of frame drawing.
     */
    @Override
    public void apply(Tile[][] tiles, float howMuch) {

        //Select a new tile to flip every x seconds
        if (parent.frameCount % (int) howMuch == 0) {
            int rx = (int) Math.floor(parent.random(COLS));
            int ry = (int) Math.floor(parent.random(ROWS));
            tiles[rx][ry].flip();
        }

        parent.background(0,0);

        //Draw and update all the tiles.
        for (int x = COLS - 1; x >= 0; x--) {
            for (int y = ROWS - 1; y >= 0; y--) {
                tiles[x][y].update(60);//60 frames
                tiles[x][y].show();
            }
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
