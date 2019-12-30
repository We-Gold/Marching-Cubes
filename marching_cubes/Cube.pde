class Cube {
  public float x,y,z,w;
  public PVector[] points = new PVector[8];
  public PVector[] midpoints = new PVector[12];
  public PVector[] newMidpoints = new PVector[12];
  
  Cube(float _x, float _y, float _z, float _w) {
     // First point is bottom left
     x = _x;
     y = _y;
     z = _z;
     w = _w;
          
     points[0] = new PVector(x,y,z);
     points[1] = new PVector(x+w,y,z);
     points[2] = new PVector(x+w,y,z-w);
     points[3] = new PVector(x,y,z-w);
     points[4] = new PVector(x,y+w,z);
     points[5] = new PVector(x+w,y+w,z);
     points[6] = new PVector(x+w,y+w,z-w);
     points[7] = new PVector(x,y+w,z-w);
     
     midpoints[0] = findMidpoint(points[0],points[1]);
     midpoints[1] = findMidpoint(points[1],points[2]);
     midpoints[2] = findMidpoint(points[2],points[3]);
     midpoints[3] = findMidpoint(points[0],points[3]);
     midpoints[4] = findMidpoint(points[4],points[5]);
     midpoints[5] = findMidpoint(points[5],points[6]);
     midpoints[6] = findMidpoint(points[6],points[7]);
     midpoints[7] = findMidpoint(points[7],points[4]);
     midpoints[8] = findMidpoint(points[0],points[4]);
     midpoints[9] = findMidpoint(points[1],points[5]);
     midpoints[10] = findMidpoint(points[2],points[6]);
     midpoints[11] = findMidpoint(points[3],points[7]);
     
     newMidpoints[0] = interpolateMidpoint(points[0],densityAtPoint(points[0]),points[1],densityAtPoint(points[1]),threshold);
     newMidpoints[1] = interpolateMidpoint(points[1],densityAtPoint(points[1]),points[2],densityAtPoint(points[2]),threshold);
     newMidpoints[2] = interpolateMidpoint(points[2],densityAtPoint(points[2]),points[3],densityAtPoint(points[3]),threshold);
     newMidpoints[3] = interpolateMidpoint(points[0],densityAtPoint(points[0]),points[3],densityAtPoint(points[3]),threshold);
     newMidpoints[4] = interpolateMidpoint(points[4],densityAtPoint(points[4]),points[5],densityAtPoint(points[5]),threshold);
     newMidpoints[5] = interpolateMidpoint(points[5],densityAtPoint(points[5]),points[6],densityAtPoint(points[6]),threshold);
     newMidpoints[6] = interpolateMidpoint(points[6],densityAtPoint(points[6]),points[7],densityAtPoint(points[7]),threshold);
     newMidpoints[7] = interpolateMidpoint(points[7],densityAtPoint(points[7]),points[4],densityAtPoint(points[4]),threshold);
     newMidpoints[8] = interpolateMidpoint(points[0],densityAtPoint(points[0]),points[4],densityAtPoint(points[4]),threshold);
     newMidpoints[9] = interpolateMidpoint(points[1],densityAtPoint(points[1]),points[5],densityAtPoint(points[5]),threshold);
     newMidpoints[10] = interpolateMidpoint(points[2],densityAtPoint(points[2]),points[6],densityAtPoint(points[6]),threshold);
     newMidpoints[11] = interpolateMidpoint(points[3],densityAtPoint(points[3]),points[7],densityAtPoint(points[7]),threshold);
  }
    
  public void show() {
    stroke(255);
    noFill();
    beginShape(QUADS);
    
    for (int i = 0; i < 4; i++) {
      vertex(points[i].x,points[i].y,points[i].z);
      vertex(points[(i+1) % 4].x,points[(i+1) % 4].y,points[(i+1) % 4].z);
      vertex(points[((i+1) % 4)+4].x,points[((i+1) % 4)+4].y,points[((i+1) % 4)+4].z);
      vertex(points[i+4].x,points[i+4].y,points[i+4].z);
    }
    endShape();
  }
  
  public void showTriangulation() {
    int sum = 0;
    
    for(int i = points.length-1; i >= 0 ; i--) {
      if(densityAtPoint(points[i]) >= threshold) {
        sum += Math.pow(2,i);
      }
    }
    if(sum > 0){
      beginShape(TRIANGLES);
      
      int currentVertex = 0;
      while(currentVertex < 16 && triangulation[sum][currentVertex] != -1) {
        PVector v = newMidpoints[triangulation[sum][currentVertex]];
        vertex(v.x,v.y,v.z);
        currentVertex++;
      }
      endShape(); 
    }
    
  }
  
  public PVector interpolateMidpoint(PVector a, float aVal, PVector b, float bVal, float thres){
    float factor = (thres - aVal)/(bVal - aVal);
    return PVector.lerp(a,b,abs(factor));
  }
  
  public PVector findMidpoint(PVector a, PVector b) {
    return new PVector((a.x+b.x)/2,(a.y+b.y)/2,(a.z+b.z)/2);
  }
}
