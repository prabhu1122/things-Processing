float x, y, x1, y1, x2, y2;
float l1 = 200;
float l2 = 200;
float angle1 = PI/2;
float angle2 = PI/2;
float mass1 = 50;
float mass2 = 50;

float aAcc1 = 0;
float aVel1 = 0;

float aAcc2 = 0;
float aVel2 = 0;
float px2 = -1;
float py2 = -1;
float cx = 0;
float cy = 0;

float g = .8;

PGraphics canvas;

void setup() {
  size(900, 600);
  cx = width/2;
  cy = 200;
  canvas = createGraphics(900,600);
  canvas.beginDraw();
  canvas.background(255);
  canvas.endDraw();
}


void draw() {
  //background(255); 
  float a_nom1 = -g*(2*mass1+mass2)*sin(angle1);
  float a_nom2 = mass2*g*sin(angle1-2*angle2);
  float a_nom3 = 2*sin(angle1-angle2)*mass2;
  float a_nom4 = aVel2*aVel2*l2 + aVel1*aVel1*l1*cos(angle1-angle2);
  
  float a_denom = l1*(2*mass1 + mass2 - mass2*cos(2*angle1-2*angle2));
  
  aAcc1 = (a_nom1-a_nom2-a_nom3*a_nom4)/a_denom;
  
  float b_nom1 = 2*sin(angle1-angle2);
  float b_nom2 = aVel1*aVel1*l1*(mass1+mass2);
  float b_nom3 = g*(mass1+mass2)*cos(angle1);
  float b_nom4 = aVel2*aVel2*l2*mass2*cos(angle1-angle2);
  
  float b_denom = l2*(2*mass1 + mass2 - mass2*cos(2*angle1-2*angle2));
  
  aAcc2 = b_nom1*(b_nom2+b_nom3+b_nom4)/b_denom;
  
  image(canvas,0,0);
  stroke(0);
  strokeWeight(2);
  translate(cx,cy);

  x1 = l1*sin(angle1);
  y1 = l1*cos(angle1);

  x2 = x1 + l2*sin(angle2);
  y2 = y1 + l2*cos(angle2);

  ellipse(x, y, 5, 5);

  fill(0);
  line(x, y, x1, y1);
  ellipse(x1, y1, mass1, mass1);

  line(x1, y1, x2, y2);
  ellipse(x2, y2, mass2, mass2);
  
  aVel1 += aAcc1;
  aVel2 += aAcc2;
  angle1 += aVel1;
  angle2 += aVel2; 
   
  
  canvas.beginDraw();
  canvas.translate(cx,cy);
  canvas.stroke(255,0,0);
  canvas.strokeWeight(2);
  if(frameCount>1){
    canvas.line(px2,py2,x2,y2);
  }
  canvas.endDraw();
  
  px2 = x2;
  py2 = y2;

}
