

int minPos = 30;
int maxPos = 370;
int amountPoints = 13;
PVector[] points = new PVector[amountPoints];
float angle;
float jitter=0.1;

void setup(){
  size(400, 400);
  for(int i = 0; i < amountPoints; i++){
    points[i] = new PVector(random(minPos,maxPos),random(minPos,maxPos));
  }
  checkPoints();
}

void draw(){
  background(51);
  color(50, 50, 50);
  strokeWeight(10);
  for(PVector point : points){
    point(point.x, point.y);
  }
  drawWindmillLine();
}




void drawWindmillLine(){
  strokeWeight(1);
 
  /*angle = angle + jitter;
  float c = cos(angle);
  rotate(c);*/
  pushMatrix();
  translate(width/2, height/2);
  float radius = width/2;
  float x = radius*cos(radians(30));
  float y = radius*sin(radians(30));


  line(0,0,400,400);
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
  float dxc = point1.x - point2.x;
  float dyc = point1.y - point2.y;
  
  float dx1 = point2.x - point3.x;
  float dy1 = point2.y - point3.y;
  
  float cross = dxc * dy1 - dyc * dx1;
  return cross == 0;
}