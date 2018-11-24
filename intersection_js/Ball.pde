class Ball{
  float xPos;
  float yPos;
  float radius = 48;
  color c;
  Ball(float x,float y){
   xPos = x;
   yPos = y;

  }
  
  
  void changeColor(){
    color c = color(random(255),random(255),random(255)); 
    fill(c);
  }
  
  boolean intersect(Ball b){
    float dis = dist(xPos,yPos,b.xPos,b.yPos); 
    if(dis <= (radius+b.radius)){
    return true;
  }
  return false; 
  }
  void display(){
    stroke(255);
    ellipse(xPos,yPos,radius*2,radius*2);
  }
  void update(){
    xPos = xPos + random(-1,1);
    yPos = yPos + random(-1,1);
  }
  
}
