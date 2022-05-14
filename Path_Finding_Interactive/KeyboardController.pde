class KeyboardController {

  KeyboardController() {
  }

  void listen() {
    //Custom camera controls
    if (keys[0]) {//w
      if (player.v.z > 0) {
        //if (grid.tiles[(int)player.v.x][(int)player.v.x+1] instanceof Tile_Dirt)
        player.v.z--;
      }
    }
    if (keys[1]) { //d
      if (player.v.x < gridSize-1) {
        //if (grid.tiles[(int)player.v.z][(int)player.v.z] instanceof Tile_Dirt)
        player.v.x++;
      }
    }
    if (keys[2]) { //s
      if (player.v.z < gridSize-1) {
        //if(grid.tiles[(int)player.v.x][(int)player.v.x-1] instanceof Tile_Dirt)
        player.v.z++;
      }
    }
    if (keys[3]) { //a
      if (player.v.x > 0) {
        //if(grid.tiles[(int)player.v.z+1][(int)player.v.z] instanceof Tile_Dirt)
        player.v.x--;
      }
    }
  }
}

void keyPressed()
{
  if (key=='w' || keyCode == UP)
    keys[0]=true;
  if (key=='d' || keyCode == RIGHT)
    keys[1]=true;
  if (key=='s' || keyCode == DOWN)
    keys[2]=true;
  if (key=='a' || keyCode == LEFT)
    keys[3]=true;
}

void keyReleased()
{
  if (key=='w' || keyCode == UP)
    keys[0]=false;
  if (key=='d' || keyCode == RIGHT)
    keys[1]=false;
  if (key=='s' || keyCode == DOWN)
    keys[2]=false;
  if (key=='a' || keyCode == LEFT)
    keys[3]=false;
}
