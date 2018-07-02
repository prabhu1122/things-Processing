/////////////////////////////////////////////////////////////////////////////////////////////////////////
//                *******************Code for Double Pendulum********************                      // 
//                             source for help is "The coding train"                                   //
// and formules from link:"https://www.myphysicslab.com/pendulum/double-pendulum-en.html"              //
//                                  Written by:Prabhat Yadav                                           //
/////////////////////////////////////////////////////////////////////////////////////////////////////////
 float x, y, x1, y1, x2, y2;
 int l1 = 300;
 int l2 = 300;
 float angle1 = PI/2;  
 float angle2 = PI/3;
 int mass1 = 80;
 int mass2 = 80;   
 float aAcc1 = 0.0;
 float aVel1 = 0.0;
 float aAcc2 = 0.0;
 float aVel2 = 0.0;
 float px2 = -1;
 float py2 = -1;
 float px1 = -1;
 float py1 = -1;
 float cx = 0.0;
 float cy = 0.0; 
 float g = .89; 
 
 boolean drag1 = false;
 boolean drag2 = false;
 
 PGraphics canvas; 
 
 void setup() { 
size(displayWidth, displayHeight);
   surface.setResizable(true);
   cx = width/2; 
   cy = 50; 
   fill(200);
   canvas = createGraphics(displayWidth, displayHeight); 
   canvas.beginDraw(); 
   canvas.background(255); 
   canvas.endDraw();
 } 
 void draw() { 
   background(255); 
   float nom1 = -g*(2*mass1+mass2)*sin(angle1); 
   float nom2 = mass2*g*sin(angle1-2*angle2); 
   float nom3 = 2*sin(angle1-angle2)*mass2; 
   float nom4 = aVel2*aVel2*l2 + aVel1*aVel1*l1*cos(angle1-angle2); 
   float denom = l1*(2*mass1 + mass2 - mass2*cos(2*angle1-2*angle2)); 
   
   aAcc1 = (nom1-nom2-nom3*nom4)/denom;

   nom1 = 2*sin(angle1-angle2); 
   nom2 = aVel1*aVel1*l1*(mass1+mass2); 
   nom3 = g*(mass1+mass2)*cos(angle1);
   nom4 = aVel2*aVel2*l2*mass2*cos(angle1-angle2);
   denom = l2*(2*mass1 + mass2 - mass2*cos(2*angle1-2*angle2));

   aAcc2 = nom1*(nom2+nom3+nom4)/denom;

   image(canvas,0,0); 
   stroke(0); 
   strokeWeight(4); 
   translate(cx,cy);
   
   dragging();
   
   x1 = l1*sin(angle1); 
   y1 = l1*cos(angle1); 
   x2 = x1 + l2*sin(angle2); 
   y2 = y1 + l2*cos(angle2); 
   
   ellipse(x, y, 5, 5); 
   fill(200);
   if(drag2&&!drag1)
     fill(0); 
     line(x1, y1, x2, y2); 
     ellipse(x2, y2, mass2, mass2);
     if(drag1&&!drag2)
     fill(0);
     line(x, y, x1, y1); 
     ellipse(x1, y1, mass1, mass1); 
   
   canvas.beginDraw(); 
   canvas.translate(cx,cy);
   canvas.strokeWeight(8); 
   if(frameCount>1){ 
     canvas.stroke(#B91DF2);
     canvas.line(px2,py2,x2,y2);
     canvas.stroke(#1DF250);
     canvas.line(px1,py1,x1,y1);
   } 
   canvas.fill(200,30);
   canvas.noStroke();
   canvas.rect(-width/2,-50,width,height);
   canvas.endDraw(); 
   px1 = x1;
   py1 = y1;
   px2 = x2; 
   py2 = y2;
}

void noDragging(){
    aVel1 = 0;
    drag1 = false;
    aVel2 = 0;
    drag2 = false;
}


void onClick(int mx,int my){
  
  float d1 = dist(x1+cx,y1+cy,mx,my);
  float d2 = dist(x2+cx,y2+cy,mx,my);
  if(d1<mass1/2){
    drag1 = true;
    drag2 = false;
  }
  if(d2<mass2/2){
    drag2 = true;
    drag1 = false;
  }
}

void dragging(){
  if(drag1){
    
    float xD_1 = cx-mouseX;
    float yD_1 = cy-mouseY;
    angle1 = atan2(-yD_1,xD_1)-radians(90);
  }
  if(drag2){
    float xD_2 = x1+cx-mouseX;
    float yD_2 = y1+cy-mouseY;
    angle2 = atan2(-yD_2,xD_2)-radians(90);
    }
    else{
      go();
    }
}

void go(){
      aVel1 += aAcc1; 
      angle1 += aVel1; 
      aVel2 += aAcc2; 
      angle2 += aVel2;
}

void mousePressed(){
  
  onClick(mouseX,mouseY);
}

void mouseReleased(){
    noDragging();
}
