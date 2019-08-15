

class wmPoint{
  private float x, y, dist;
  private int pivotNumber;
  
  public wmPoint(float x, float y){
   this.x = x;
   this.y = y;
   dist = 0;
   pivotNumber = 0;
  }
  
  public void setX(float x){this.x = x;}
  public float getX(){return x;}
  
  public void setY(float y){this.y = y;}
  public float getY(){return y;}
  
  public void setDist(float dist){this.dist = dist;}
  public float getdist(){return dist;}
  
  public void setPivotNumber(int pivotNumber){this.pivotNumber = pivotNumber;}
  public float getPivotNumber(){return pivotNumber;}
}