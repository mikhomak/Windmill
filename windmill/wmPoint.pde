

class wmPoint{
  private float x, y;
  private int pivotNumber;
  
  public wmPoint(float x, float y){
   this.x = x;
   this.y = y;
   pivotNumber = 0;
  }
  
  public void setX(float x){this.x = x;}
  public float getX(){return x;}
  
  public void setY(float y){this.y = y;}
  public float getY(){return y;}

  public void setPivotNumber(int pivotNumber){this.pivotNumber = pivotNumber;}
  public float getPivotNumber(){return pivotNumber;}
  
  public void addToPivotNumber(){ pivotNumber++; }
}