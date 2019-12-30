Cube[][][] cubes;

PVector dims;

PVector sphere;
float radius = 100;

float s = 20;

float threshold = 0;

float xmag, ymag = 0;
float newXmag, newYmag = 0; 

void setup(){
  size(800, 600, P3D);
  background(0);
  lights();
  stroke(0);
  fill(204, 102, 0);
  
  dims = new PVector(width,height,200);
  
  cubes = new Cube[(int)(dims.x/s)][(int)(dims.y/s)][(int)(dims.z/s * 2)];
  
  sphere = new PVector(width/2,height/2,0);
  
  for(int i = 0; i<cubes.length; i++){
    for(int j = 0; j<cubes[i].length; j++){
      for(int k = 0; k<cubes[i][j].length; k++){
         cubes[i][j][k] = new Cube(s*i,dims.y-s*j,dims.z-s*k,s);
      }
    }
  }
}

void draw(){
  background(0);
  
  /*pushMatrix();
  translate(sphere.x, sphere.y, sphere.z);
  noFill();
  stroke(255);
  sphere(radius);
  popMatrix();*/
  
  newXmag = mouseX/float(width) * TWO_PI;
  newYmag = mouseY/float(height) * TWO_PI;
  
  float diff = xmag-newXmag;
  if (abs(diff) >  0.01) { 
    xmag -= diff/4.0; 
  }
  
  diff = ymag-newYmag;
  if (abs(diff) >  0.01) { 
    ymag -= diff/4.0; 
  }
  translate(width/2, height);
  rotateX(-ymag); 
  rotateY(-xmag); 
  
  //rotateZ(0.125*TWO_PI);
  
  for(int i = 0; i<cubes.length; i++){
    for(int j = 0; j<cubes[i].length; j++){
      for(int k = 0; k<cubes[i][j].length; k++){
         //cubes[i][j][k].show();
         cubes[i][j][k].showTriangulation();
      }
    }
  }
  translate(0, 0);
}

float sigmoid(float x) {
    return (float)(1/( 1 + Math.pow(Math.E,(-1*x))));
}

float densityAtPoint(PVector point) {
  float distance = radius - point.dist(sphere);
  float sign = (distance >= 0)?1:-1;
  return sigmoid(Math.abs(distance)) * sign;
}
