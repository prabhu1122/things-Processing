Ball b1;
Ball b2;
void setup(){
  size(displayWidth,displayHeight);
  b1 = new Ball(300,200);
  b2 = new Ball(250,300);
}

void draw(){
  background(0);
  b1.display();
  b1.update();
  b2.display();
  b2.update();
  
  
  if(b1.intersect(b2)){
   b1.changeColor();
  }
}

//void mousePressed(){
//   b1.changeColor();
//  }
  
