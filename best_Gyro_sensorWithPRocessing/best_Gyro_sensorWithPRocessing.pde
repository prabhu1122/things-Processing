/* //////////////////////////////////////////////////////////////////// *
*    cool project for the sensor MPU6050 to read data on                *
*    dashboard created throught "processing"                            *
*    Materials required in Hardware are arduino uno,MPU6050 sensor,     *
*    male female jmper wire,                                            *
*    materials required in Software are Arduino IDE,Processing IDE      *
*    Author 'prabhat yadav'                                             *
*    created on 30 may 2018                                             *
*    uploaded link: 
*///////////////////////////////////////////////////////////////////////*

////////////////////////Processing Code/////////////////////////////////

import processing.serial.*;     //import library for Serial
Serial myPort;                  //Create an object for Serial

PFont numFont;                  //create objects for fonts
PFont charFont;
PFont logoFont;
int angleX = 0;
int angleY = 0;
int angleZ = 0;

float rotateX = 0;
float rotateY = 0;
float signRotateX = 0;
float signRotateY = 0;
String data = "";
int comma_index = 0;
int dot_index = 0;

void setup() {
  size(800,450);                                    //***************SIZE MUST BE IN THE "2:1" FOR BEST LOOK*******************//
  smooth(16);
  
  String portName = Serial.list()[3];                    //choose your serial port from list; 
  myPort =new Serial(this, portName, 9600);              
  myPort.bufferUntil('\n');                              //Serial port will read upcoming data till '\n' this epecial
                                                         //char are not appeares
  numFont = loadFont("Sylfaen-48.vlw");                  //uploaded fonts for numbers and as wel as charecters
  charFont = loadFont("ComicSansMS-Bold-48.vlw");
  logoFont = loadFont("AngsanaNew-Bold-48.vlw");
}

void draw() {

  background(200);
  
  arrowMeter(angleY);
  heightMeter(angleY);                                            //call function for the measuring the level of height 
  tilt(angleX);                                              //call direction function to show the tilt
  inclination(angleY);                                            //call inclination function to show the height and depth
  Shapes();                                                       
  basePart();
  danger();                                                 //red dot indicate the tilting more than 60 dregree
  
}

//Start the SerialEvent to communicate data and collecting data from arduino
void serialEvent(Serial myPort) { 

  data = myPort.readStringUntil('\n');
  data = data.substring(0, data.length()-2);

  //check for commo
  comma_index = data.indexOf(',');
  angleX = int(data.substring(0, comma_index));

  //check for dot
  dot_index = data.indexOf('.');
  angleY = int(data.substring(comma_index+1, dot_index));

  //check for \n
  angleZ = int(data.substring(dot_index+1, data.length()));
  
} 

void tilt(int angle){
  pushMatrix();
  translate(width-width/2,height-height/2);
  rotateX = map(angle,-125,125,-90,90);
  signRotateX= -(rotateX);
  rotate(radians(signRotateX));
  textFont(numFont,15);
  stroke(255,0,0);
  fill(255,0,0);
  text("0°",-(width-width*0.996),-(height-height*.67));
  text("90°",width-width*0.82,height-height*0.99);
  text("-90°",-(width-width*0.8),height-height*0.99);
  text("180°",-(width-width*0.99),height-height*.66);
  
  fill(255);
  for(int i = 0;i <= 360;i+=6){
    int a = i%30;
    int b = i%90;
    if(a==0){
      if(b!=0){
        strokeWeight(8);
        stroke(255,0,0);
      }  
    }
    else{
      strokeWeight(4);
      stroke(100,100,255);
    }
    if(b!=0){
      point((width-width*0.813)*cos(radians(i)),(height-height*0.665)*sin(radians(i)));
    }
  }  
  popMatrix();
  pushMatrix();
  translate(width-width/2,height-height/2);
  fill(255);
  noStroke();
  ellipse(width-width*0.0,height-height*0.0,width-width*0.65,height-height*0.377);
  popMatrix();
}

void inclination(int heightInlcint){
  
  pushMatrix();
  translate(width-width/2,height-height/2);
  rotateY = map(heightInlcint,-125,125,-90,90);
  signRotateY= -(rotateY);
  //rotate(radians(-90));
  fill(#D25A0F);
  noStroke();
  strokeWeight(4);
  arc(width*0.0,height*0.0,width-width*.648,height-height*0.375,radians(0+signRotateX+signRotateY),radians(180+signRotateX-signRotateY),OPEN);
  popMatrix();
}

void Shapes(){
 arrowShape(); 
}

void arrowShape(){
  noStroke();
  fill(255,0,0);
  beginShape(TRIANGLES);
  vertex(width-width*0.49, height-height*0.97);
  vertex(width-width*0.50, height-height*0.95);
  vertex(width-width*0.50, height-height*0.88);
  endShape();
  
  beginShape(TRIANGLES);
  fill(255,0,0,150);
  vertex(width-width*0.51, height-height*0.97);
  vertex(width-width*0.50, height-height*0.95);
  vertex(width-width*0.50, height-height*0.88);
  endShape();
}

void heightMeter(int AngleY){
  
  pushMatrix();
  //translate(width-width*0.20,height-height*0.138);
  translate(width-width*0.20,height-height*0.5);
  float depthAngle = 0;
  
  depthAngle = map(AngleY,-100,100,(height-height*0.685),-(height-height*0.685));
  //depthAngle = map(mouseY,0,height,-(height-height*0.685),(height-height*0.685));                        //mapning the value
  rectMode(CORNER);
  fill(#E477FA);
  noStroke();
  rect(-width*0.01,0,width-width*.98,depthAngle);
  line(0,-(height-height*0.685),-width*.01,-(height-height*0.685));                                      //border lines of data meter
  line(0,(height-height*0.685),-width*.01,(height-height*0.685));
  fill(255,0,0);
  rectMode(CENTER);
  stroke(0);
  rect(0,(height-height*0.66),width-width*.98,(height-height*0.63)-(height-height*0.685),0,0,20,20);     //down red part of meter
  stroke(0);
  rect(0,-(height-height*0.66),width-width*.98,(height-height*0.63)-(height-height*0.685),20,20,0,0);    //upper red part of meter
  stroke(0);
  strokeWeight(2);
  rectMode(CENTER);
  noFill();                                
  line(-(width-width*0.985),0,-(width-width*.960),0);                                                    //middle point
                                            //data part of height meter
  rectMode(CENTER);
  noFill();
  stroke(0);
  rect(0,0,width-width*.98,2*(height-height*0.685));                                       //upper part or background of data slider meter
  popMatrix();
  
}


void arrowMeter(int angleArrow){
  pushMatrix();
  translate(width-width*0.28,height-height*0.5);
  
  //float meterHeight = map(mouseY,0,height,-(height-height*0.685),(height-height*0.685));
  float horizonAngle = map(angleArrow,-125,125,-90,90);
  float meterHeight = map(horizonAngle,-100,100,(height-height*0.685),-(height-height*0.685));
  
  //code for arrowMeter 
  beginShape();
  noStroke();
  fill(255,0,0);
  vertex(width-width*0.87,-(height-height*0.98)+meterHeight);
  vertex(width-width*0.88,meterHeight);
  vertex(width-width*0.908,meterHeight);
  endShape();
  
  beginShape();
  noStroke();
  fill(255,0,0,150);
  vertex(width-width*0.87,(height-height*0.98)+meterHeight);
  vertex(width-width*0.88,meterHeight);
  vertex(width-width*0.908,meterHeight);
  endShape();
  
  ////////////////meter box of Y_angle///////////////////////
  rectMode(CENTER);
  fill(255,0,0);
  rect(width-width*0.833,meterHeight,width-width*0.925,height-height*0.962);
  rectMode(CENTER);
  fill(255,255,255);
  rect(width-width*0.833,meterHeight,width-width*0.95,height-height*0.975);
  textFont(charFont);
  stroke(0);
  fill(0);
  textSize(15);
  text(angleY+"°",width-width*0.845,meterHeight+5);
  popMatrix();
}

/////////////////////////////////////////////////////////////
void danger(){
 stroke(0);
 strokeWeight(4);
 if(signRotateX>60 || signRotateX<-60){
   
    fill(255,0,0); 
  }
  else{
     fill(255);
  }
 ellipse(width*0.5,height*0.5,20,20);
}

void basePart(){
  fill(#5A25F2);
  textFont(logoFont,35); 
  text("MPU6050 GYROSENSOR & ACCELEROMETER",width-width*0.82,height-height*0.05);
  stroke(#5A25F2);
  line(width-width*0.83,height-height*0.04,width-width*.17,height-height*0.03);
  fill(#74FF8C);
  textFont(charFont,20); 
  text("X-Angle:",width-width*0.98,height-height*0.20);   //texts for the inclination along X-axis
  fill(#FF74DD);
  textFont(numFont,20);
  text(rotateX,width-width*0.85,height-height*0.20);
  textFont(charFont,20);
  fill(#74FF8C);
  text("Y-Angle:",width-width*0.98,height-height*0.15);    //texts for the inclination along Y-axis
  fill(#FF74DD);
  textFont(numFont,20);
  text(angleY,width-width*0.85,height-height*0.15);
  stroke(0);
  strokeWeight(4);
  noFill();
  ellipse(width-width*0.5,height-height*0.5,width-width*0.60,height-height*0.29);          //outer cirlce of the ring
  ellipse(width-width*0.5,height-height*0.5,width-width*0.648,height-height*0.37);         //inner circle of the ring
  line(width-width*0.325,height-height*0.49,width-width*0.675,height-height*0.49);         //upper line of the horizon
  line(width-width*0.325,height-height*0.51,width-width*0.675,height-height*0.51);         //lower part of horizon
  strokeWeight(2);
  line(width-width*0.5,height-height*0.85,width-width*0.5,height-height*0.15);             //vertical line of the ring
   
  
}

/*
///////////////////////////Arduino code///////////////////////////
#include<Wire.h>
long rotX,rotY,rotZ;
float angleX,angleY,angleZ;
void setup(){
  
  Serial.begin(9600);
  Wire.begin();
  MPUsetup();
  
}
void loop(){
  receiveGyro();
}
void MPUsetup(){
  
  Wire.beginTransmission(0x68);
  Wire.write(0x6B);
  Wire.write(0);
  Wire.endTransmission(true);
  
}
void receiveGyro(){
  
  Wire.beginTransmission(0x68);
  Wire.write(0x3B);
  Wire.endTransmission(true);
  Wire.requestFrom(0x68,6,true);
  while(Wire.available()<6);
  
  rotX = Wire.read()<<8|Wire.read();
  rotY = Wire.read()<<8|Wire.read();
  rotZ = Wire.read()<<8|Wire.read();
  
  processingData();
  
}
void processingData(){
  
  angleX = rotX/131;
  angleY = rotY/131;
  angleZ = rotZ/131;
  
  printAngle();
}
void printAngle(){
  
  Serial.print(int(angleX));
  Serial.print(",");
  Serial.print(int(angleY));
  Serial.print(".");
  Serial.print(int(angleZ));
  Serial.print("\n");
  delay(100);
}
*/
