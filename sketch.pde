float rotateX = 0;

void setup(){
  
  size(displayWidth,displayHeight);
  //orientation(LANDSCAPE);
  
}
void draw(){
  
  background(100);
  direction();
  inclination();
  horizon();
}

void direction(){
  pushMatrix();
  translate(width/2,height/2);
  rotateX = map(mouseX,0,width,radians(90),radians(-90));
  rotate(rotateX);
  textSize(50);
  stroke(255);
  text("0°",-10,-270);
  text("90°",260,10);
  text("-90°",-330,10);
  
  rotate(radians(-90));
  fill(255);
  for(int i = 0;i <= 360;i+=6){
    int a = i%30;
    if(a==0){
      strokeWeight(16);
      stroke(255,0,0);
    }
    else{
      strokeWeight(8);
      stroke(255,255,0);
    }
    point(250*cos(radians(i)),250*sin(radians(i)));
  }  
  popMatrix();
  pushMatrix();
  translate(width/2,height/2);
  fill(255);
  noStroke();
  ellipse(0,0,480,480);
  popMatrix();
}

void inclination(){
  
  pushMatrix();
  translate(width/2,height/2);
  rotate(radians(-90));
  fill(#D25A0F);
  noStroke();
  strokeWeight(4);
  arc(0,0,480,480,radians(90),radians(270),OPEN);
  popMatrix();
}

void horizon(){
  float horizonLineX1 = 240;
  float horizonLineX2 = -240;
  
  float horizonLineY1 = 0;
  float horizonLineY2 = 0;
  
  pushMatrix();
  translate(width/2,height/2);
  rotate(radians(-90));
  strokeWeight(4);
  stroke(100,155,20);
  line(horizonLineX1,horizonLineY1,horizonLineX2,horizonLineY2);
  popMatrix();
  
}

