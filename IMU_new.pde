import processing.serial.*;
Serial port;

String data="", acc="", gyro="", fusion="";
int index=0, index2=0;

int rec1x=25,rec1y=80;
int rec2x=rec1x+275,rec2y=rec1y;
int rec3x=rec2x+275,rec3y=rec1y;

float x1,y1,x2,y2,cx,cy,a,b;
float ang1=0,ang2=0,ang3=0,angle1,angle2,angle3;
float inc1=1,inc2=1.2;

PFont font1,font2,font3,font4;

void setup()
{
 size(1000,400);
 smooth();
 port=new Serial(this, "COM3", 9600);
 port.bufferUntil('.');
 font1=loadFont("CopperplateGothic-Bold-50.vlw");
 font2=loadFont("Bauhaus93-80.vlw");
 font3=loadFont("ARBONNIE-100.vlw"); 
}

void draw()
{
  background(50);
  textFont(font2,60);
  fill(40,200,255);
  text("mpu-6050",360,50);
  textFont(font2,24);
  fill(0,150,255);
  text("by pvt",640,50);
  fill(1,255,1);
  noStroke();
  rect(880,80,100,40,10,10,10,10);
  fill(255,1,1);
  noStroke();
  rect(880,140,100,40,10,10,10,10);
  
  ang1=float(acc);
  ang2=float(gyro);
  ang3=float(fusion);
                                          //accelerometer
  noStroke();
  fill(50,10,250);
  rect(rec1x,rec1y,250,20);
  textFont(font1,22);
  fill(255);
  text("accelerometer",50,98);
  noStroke();
  fill(50,20,200,80);
  rect(rec1x,rec1y+20,250,250);
  noStroke();
  fill(0);
  ellipse(rec1x+(250/2),rec1y+20+(250/2),240,240);
                                      //acc_line
  cx=rec1x+(250/2);
  cy=rec1y+20+(250/2);
  angle1=radians(ang1);
  a=120*cos(angle1);
  b=120*sin(angle1);
  x1=cx-a;
  y1=cy-b;
  x2=cx+a;
  y2=cy+b;
  stroke(255,0,0);
  strokeWeight(2);
  line(x1,y1,x2,y2);
  fill(0);
  noStroke();
  ellipse(cx,cy,80,80);
  textFont(font3,70);
  fill(40,200,255);
  text(abs(int(ang1)),cx-30,cy+22);
                                             //gyroscope
  noStroke();
  fill(50,10,250);
  rect(rec2x,rec2y,250,20);
  textFont(font1,22);
  fill(255);
  text("gyroscope",350,98);
  noStroke();
  fill(50,20,200,80);
  rect(rec2x,rec2y+20,250,250);
  fill(0);
  ellipse(rec2x+(250/2),rec2y+20+(250/2),240,240);
                                          //gyro_line
  cx=rec2x+(250/2);
  cy=rec2y+20+(250/2);
  angle2=radians(ang2);
  a=120*cos(angle2);
  b=120*sin(angle2);
  x1=cx-a;
  y1=cy-b;
  x2=cx+a;
  y2=cy+b;
  stroke(2,2,255);
  strokeWeight(2);
  line(x1,y1,x2,y2);
  fill(0);
  noStroke();
  ellipse(cx,cy,80,80);
  textFont(font3,70);
  fill(40,200,255);
  text(abs(int(ang2)),cx-30,cy+22);
                                                  //fusion
  noStroke();
  fill(50,10,250);
  rect(rec3x,rec3y,250,20);
  textFont(font1,22);
  fill(255);
  text("fusion",660,98);
  noStroke();
  fill(50,20,200,80);
  rect(rec3x,rec3y+20,250,250);
  fill(0);
  ellipse(rec3x+(250/2),rec3y+20+(250/2),240,240);
                                           //fusion_line
  cx=rec3x+(250/2);
  cy=rec3y+20+(250/2);
  angle3=radians(ang3);
  a=120*cos(angle3);
  b=120*sin(angle3);
  x1=cx-a;
  y1=cy-b;
  x2=cx+a;
  y2=cy+b;
  stroke(0,255,0);
  strokeWeight(2);
  line(x1,y1,x2,y2);
  fill(0);
  noStroke();
  ellipse(cx,cy,80,80);
  textFont(font3,70);
  fill(40,200,255);
  text(abs(int(ang3)),cx-30,cy+22);
                                             //animation
  if (mousePressed==true)
  {  
   if (get(mouseX,mouseY)==color(1,255,1))
   {
     fill(50);
     stroke(1,255,1);
     strokeWeight(5);
     rect(880,80,100,40,10,10,10,10);
    ang1=ang1+inc1;
    ang2=ang2+inc2;
    ang3=(0.8*ang1)+(0.2*ang2);
     if (ang1>90 || ang1<-90)
     {
      inc1=-inc1;
     }
     if (ang2>90 || ang2<-90)
     {
      inc2=-inc2;
     }
    }
  }
  //shuting animation down; no click required
  if (get(mouseX,mouseY)==color(255,1,1))
  {
    fill(0,100,200);
    stroke(255,1,1);
    strokeWeight(5);
    rect(880,140,100,40,10,10,10,10);
    if (ang1>0)
    {
      ang1--;
    }
    if (ang2>0)
    {
      ang2--;
    }
    if (ang1<0)
    {
      ang1++;
    }
    if (ang2<0)
    {
      ang2++;
    }
    ang3=(0.9*ang1)+(0.1*ang2);
  }  
}
void serialEvent(Serial port)
{
  data= port.readStringUntil('.');
  data=data.substring(0,data.length()-1);
  index= data.indexOf("*");
  index2=data.indexOf("@");
  acc= data.substring(0,index);
  gyro= data.substring(index+1,index2);
  fusion=data.substring(index2+1,data.length());
}


