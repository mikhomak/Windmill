

final int minPos = 200;
int maxPos;
final int amountPoints = 13;
final wmPoint[] points = new wmPoint[amountPoints];
final float speed = 0.08f;
wmPoint pivot;
PVector line = new PVector();
final color rectColour = color(79,200,229, 125);
final color lineColour = color(229, 137, 217, 125);
final color bcakgroundColour = color(250, 237, 248);
final color pivotColour = color(245, 164, 32);

void setup(){
  size(800, 800);
  maxPos = width - minPos;
  for(int i = 0; i < amountPoints; i++){
    points[i] = new wmPoint(random(minPos,maxPos),random(minPos,maxPos));
  }
  createPoints();
  pivot = points[0];

}

void draw(){
  background(bcakgroundColour);
  translate(0,0);
  strokeWeight(10);
  for(wmPoint point : points){
    point(point.x, point.y);
  }
  drawWindmillLine();
  drawPivotNumbers();
}




void drawWindmillLine(){
  strokeWeight(2);
  pushMatrix();
  translate(pivot.x, pivot.y);
  line.x = width;
  line.y = width;
  line.rotate(frameCount * speed  % 360);
  fill(lineColour);
  line(-line.x, -line.y, line.x, line.y);
  strokeWeight(120);
  fill(pivotColour);
  point(0,0);
  fill(rectColour);
  noStroke();
  final PVector topPoint = findTopPointForTriangle(line, new PVector(-line.x, -line.y));
  quad(0, 0, line.x, line.y, line.x, line.y* 200, topPoint.x, topPoint.y);
  quad(0, 0, -line.x, -line.y, -line.x, -line.y* 200, topPoint.x, topPoint.y);
  stroke(1);
  popMatrix();
  findPivot();
  
}

void findPivot(){
  final FloatList distances = new FloatList();
  final HashMap<String, wmPoint> distMap = new HashMap<String, wmPoint>();
  for(wmPoint point : points){
    final float disFront = findDistance(pivot, new wmPoint(line.x + pivot.x, line.y + pivot.y), point);
    final float disEnd = findDistance(pivot, new wmPoint(-line.x + pivot.x, -line.y + pivot.y) , point);
    final float minDis = min(disFront, disEnd);
    distances.append(minDis);
    distMap.put(str(minDis), point);
  }
  if(checkPointOnTheLine(pivot, new wmPoint(line.x + pivot.x, line.y + pivot.y), distMap.get(str(distances.min())))){
    pivot = distMap.get(str(distances.min()));
    distMap.get(str(distances.min())).addToPivotNumber();
  }
}

void drawPivotNumbers(){
  for(wmPoint point : points){
     pushMatrix();
     fill(0);
     translate(point.x, point.y);
     text(int(point.getPivotNumber()), 15, -15);
     popMatrix();
  }
}

PVector findTopPointForTriangle(final PVector point1, final PVector point2){
  if(point1.y > point2.y){
    if(point1.x < point2.x){
      return new PVector(point2.x, point1.y);
    }
    return new PVector(point1.x, point2.y); 
  }else if(point2.y > point1.y){
    if(point1.x < point2.x){
      return new PVector(point1.x, point2.y);
    }
    return new PVector(point2.x, point1.y);
  }
  return new PVector(0,0);
}

void createPoints(){
  for(wmPoint point : points){
     for(wmPoint secondPoint : points){
        if(secondPoint.equals(point)){
           break; 
        }
        for(int i = 0; i < amountPoints; i++){
          if(points[i].equals(point) || points[i].equals(secondPoint)){
           break; 
          }
          while(checkPointOnTheLine(point, secondPoint, points[i])){
            points[i] = new wmPoint(random(minPos,maxPos),random(minPos,maxPos));
          }
       }
    }
  }
}



boolean checkPointOnTheLine(final wmPoint point1,final wmPoint point2,final wmPoint point3){
  if(point1.equals(point3) || point2.equals(point3)){
    return false;
  }
  float dis = findDistance(point1, point2, point3);
  return  dis < 0.5 && dis > -0.5;
}


float findDistance(final wmPoint point1,final wmPoint point2,final wmPoint point3){
  if(point1.equals(point3) || point2.equals(point3)){
    return 99999;
  }
  final float dis1 = dist(point1.x,point1.y,point2.x,point2.y);
  final float dis2 = dist(point1.x,point1.y,point3.x,point3.y);
  final float dis3 = dist(point2.x,point2.y,point3.x,point3.y);
  final float dis = dis1-dis2-dis3;
  return dis < 0 ? dis * -1: dis;
}