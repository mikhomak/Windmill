

int minPos = 30;
int maxPos;
int amountPoints = 29;
PVector[] points = new PVector[amountPoints];
float speed = 0.05f;
PVector pivot;
PVector line = new PVector();
color blue = color(20,20,180);
void setup(){
  size(800, 800);
  maxPos = width - minPos;
  for(int i = 0; i < amountPoints; i++){
    points[i] = new PVector(random(minPos,maxPos),random(minPos,maxPos));
  }
  checkPoints();
  pivot = points[0];

}

void draw(){
  background(200);
  translate(0,0);
  strokeWeight(10);
  for(PVector point : points){
    point(point.x, point.y);
  }
  drawWindmillLine();

}




void drawWindmillLine(){
  strokeWeight(1);
  
  pushMatrix();
  translate(pivot.x, pivot.y);
  float radius = width;
  line.x = radius;
  line.y = radius;
  line.rotate(frameCount * speed  % 360);
  line(-line.x, -line.y, line.x, line.y);
  
  popMatrix();
  findPivot();
   
}

void findPivot(){
  for(PVector point : points){
    if(checkPointOnTheLine(pivot, new PVector(line.x + pivot.x, line.y + pivot.y), point)){
      pivot = point;
      return;
    }
    if(checkPointOnTheLine(pivot, new PVector(-line.x + pivot.x, -line.y + pivot.y) , point)){
      pivot = point;
    }
  }
}

void drawLines(){
  color(255,0,0);
  strokeWeight(1);
  for(PVector point : points){
    for(PVector secondPoint: points){
      line(point.x, point.y, secondPoint.x, secondPoint.y);
    }
  }
}

void checkPoints(){
  for(PVector point : points){
     for(PVector secondPoint : points){
        if(secondPoint.equals(point)){
           break; 
        }
        for(int i = 0; i < amountPoints; i++){
          if(points[i].equals(point) || points[i].equals(secondPoint)){
           break; 
          }
          while(checkPointOnTheLine(point, secondPoint, points[i])){
            points[i] = new PVector(random(minPos,maxPos),random(minPos,maxPos));
          }
       }
    }
  }
}

boolean checkPointOnTheLine(PVector point1, PVector point2, PVector point3){
  if(point1.equals(point3) || point2.equals(point3)){
    return false;
  }
  float dis1 = dist(point1.x,point1.y,point2.x,point2.y);
  float dis2 = dist(point1.x,point1.y,point3.x,point3.y);
  float dis3 = dist(point2.x,point2.y,point3.x,point3.y);
  float dis = dis1-dis2-dis3;
  println(dis);
  return  dis < 0.5 && dis > -0.5;
  
}