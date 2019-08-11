

int minPos = 100;
int maxPos = 300;
int amountPoints = 13;
PVector[] points = new PVector[amountPoints];

void setup(){
  size(400, 400);
  for(int i = 0; i < amountPoints; i++){
    points[i] = new PVector(random(minPos,maxPos),random(minPos,maxPos));
  }
}

void draw(){
  color(50, 50, 50);
  strokeWeight(10);
  for(PVector point : points){
    point(point.x, point.y);
  }
}