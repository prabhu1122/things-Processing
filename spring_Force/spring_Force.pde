float m;
float x = 300;
float y = 300;
float x1;
float y1;
float p = 0;
float sConst = 1;
float damping = 1;
float vel = 0;
float acc = 0;

void setup(){
 size(displayWidth,displayHeight);
 surface.setResizable(true);
}
void draw(){
  background(255);
  
  stroke(150);
  strokeWeight(4);
  line(x,y,x1,y1);
  fill(100);
  rectMode(CENTER);
  rect(x1,y1,40,40);
  
  p = dist(x,y,x1,y1);
  acc = (sConst/m)*p + (damping)/m*vel; 
  vel += acc;
  p += vel;
}
