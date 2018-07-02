float x,y;
float x1,y1;
float a = PI/4;
float r = 500;
float m = 200;
float aAcc = 0.01;
float aVel = 0.0;
float damp = 0.995;
float g = 4;

boolean drag = false;
void setup(){
  size(displayWidth,displayHeight);
}

void draw(){
  
  background(255);
  translate(width/2,200);
  dragging(mouseX,mouseY);
  if(!drag)
    aAcc = -g/r*sin(a);
    aVel += aAcc;
    a += aVel; 
    aVel *= damp;
  
  
  x1 = r*sin(a);
  y1 = r*cos(a);
  
  stroke(0);
  strokeWeight(8);
  point(x,y);
  
  stroke(0);
  strokeWeight(2);
  line(x,y,x1,y1);
  fill(150);
  if(drag)
  fill(0);
  ellipse(x1,y1,m,m);
  
}

void notDragging(int mx,int my){
 float d = dist(x1+width/2,y1+200,mx,my);
  if(d < m/2){
      aVel = 0;
      drag = false;
   }
}

void dragging(int mx,int my){
  if (drag){
    float d = dist(x1+width/2,y1+200,mx,my);
  if(d < m/2){
      float xD = width/2-mouseX;
      float yD = 200-mouseY;
      a = atan2(-yD,xD) - radians(90);     // Angle relative to vertical axis
    }
    else{
        aAcc = -g/r*sin(a);
        aVel += aAcc;
        a += aVel; 
        aVel *= damp;
    }
  }
}

void mouseclicked(int mx,int my){
  float d = dist(x1+width/2,y1+200,mx,my);
  if(d < m/2){
    drag = true;
  }
}

void mousePressed(){
  
  mouseclicked(mouseX,mouseY);
}

void mouseReleased(){
  
  notDragging(mouseX,mouseY);
}