//public void MST(ArrayList<Character> list) {

//  ArrayList<PVector> reached = new ArrayList<PVector>();
//  ArrayList<PVector> unreached = new ArrayList<PVector>();

//  for (int i = 0; i < list.size(); i++) {
//    unreached.add(list.get(i).v);
//  }

//  reached.add(unreached.get(0));
//  unreached.remove(0);

//  while (unreached.size() > 0) {
//    float record = 9999; //infinity
//    int rIndex = 0;
//    int uIndex = 0;
//    for (int i = 0; i < reached.size(); i++) {
//      for (int j = 0; j < unreached.size(); j++) {
//        PVector v1 = reached.get(i);
//        PVector v2 = unreached.get(j);
//        float d = dist(v1.x, v1.y, v1.z, v2.x, v2.y, v2.z);
//        if (d < record) {
//          record = d;
//          rIndex = i;
//          uIndex = j;
//        }
//      }
//    }
//    stroke(255);
//    strokeWeight(2);
//    PVector p1 = reached.get(rIndex);
//    PVector p2 = unreached.get(uIndex);
//    line(p1.x*tileSize*2, p1.y, p1.z*tileSize*2, p2.x*tileSize*2, p2.y, p2.z*tileSize*2);
//    reached.add(p2);
//    unreached.remove(uIndex);
//  }
//  noStroke();
//}

//void randomWalk() {
//  if (frameCount%2==0) {
//    int xr = round(random(-1, 1));
//    int zr = round(random(-1, 1));

//    switch(xr) {
//    case -1:
//      if (player.v.x > 2) {
//        player.v.x += xr;
//      }
//      break;
//    case 1:
//      if (player.v.x <gridSize-2) {
//        player.v.x += xr;
//      }
//      break;
//    }

//    switch(zr) {
//    case -1:
//      if (player.v.z > 2) {
//        player.v.z += zr;
//      }
//      break;
//    case 1:
//      if (player.v.z <gridSize-2) {
//        player.v.z += zr;
//      }
//      break;
//    }
//  }
//}
