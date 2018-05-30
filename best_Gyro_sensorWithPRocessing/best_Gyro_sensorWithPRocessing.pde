/* //////////////////////////////////////////////////////////////////// *
*    cool project for the sensor MPU6050 to read data on                *
*    dashboard created throught "processing"                            *
*    Materials required in Hardware are arduino uno,MPU6050 sensor,     *
*    male female jmper wire,                                            *
*    materials required in Software are Arduino IDE,Processing IDE      *
*    Author 'prabhat yadav'                                             *
*    created on 30 may 2018                                             *
*    uploaded link: https://github.com/prabhu1122/things-Processing/    *
*    edit/master/best_Gyro_sensorWithPRocessing/                        *
*    best_Gyro_sensorWithPRocessing.pde                                 *
*///////////////////////////////////////////////////////////////////////*

////////////////////////Processing Code/////////////////////////////////

import processing.serial.*;     //import library for Serial
Serial myPort;                  //Create an object for Serial

PFont numFont;                  //create objects for fonts
PFont charFont;
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
int size = 80;

void setup() {

  size(displayWidth,displayHeight);
  //orientation(LANDSCAPE);
  smooth(16);
  
  String portName = Serial.list()[3];                    //choose your serial port from list; 
  myPort =new Serial(this, portName, 9600);               
  myPort.bufferUntil('\n');                              //Serial port will read upcoming data till '\n' this epecial
                                                         //char are not appeares
  numFont = loadFont("Sylfaen-48.vlw");                  //uploaded fonts for numbers and as wel as charecters
  charFont = loadFont("ComicSansMS-Bold-48.vlw");
  
}

void draw() {

  background(200);
  
  direction(angleX);                                        //call direction function to show the direction
  inclination(angleY);
  
  Shapes();
  danger();
  
  //call inclination function to show the height and depth
  textFont(charFont,30);
  text("X_Angle: ",width*0.02,height*0.25);
  textFont(numFont,30);
  text(rotateX,width*0.18,height*0.25);
  textFont(charFont,40);
  text("X-angle: ",width*0.02,height*0.45);
  textFont(numFont,30);
  text(angleX,width*0.18,height*0.45);
  
  stroke(0);
  strokeWeight(4);
  noFill();
  ellipse(width/2,height/2,width-width*0.60,height-height*0.29);
  ellipse(width/2,height/2,width-width*0.648,height-height*0.37);
  
  line(width*0.675,height*0.51,width*0.325,height*0.51);       //line of the horizon 
  line(width*0.675,height*0.49,width*0.325,height*0.49);
  strokeWeight(2);  
  
  line(width*0.5,height*0.15,width*0.5,height*0.85);           //line of vertical 
  
}
/////////////////////////////////////////////////////////////////////

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
///////////////////////////////////////////////////////////////////
void direction(int angle){
  pushMatrix();
  translate(width/2,height/2);
  
  rotateX = map(angle,-125,125,-90,90);
  signRotateX= -(rotateX);
  rotate(radians(signRotateX));
  
  textFont(numFont,20);
  stroke(255,0,0);
  fill(255,0,0);
  text("0°",-width*0.004,-height*.330);
  text("90°",width*0.180,height*0.010);
  text("-90°",-width*0.200,height*0.010);
  text("180°",-width*0.01,height*.340);
  
  rotate(radians(-90));
  fill(255);
  for(int i = 0;i <= 360;i+=6){
    int a = i%30;
    int b = i%90;
    if(a==0){
      if(b!=0){
        strokeWeight(16);
        stroke(255,0,0);
      }  
    }
    else{
      strokeWeight(8);
      stroke(255,255,0);
    }
    if(b!=0){
      point(257*cos(radians(i)),257*sin(radians(i)));
    }
  }  
  popMatrix();
  
  pushMatrix();
  translate(width/2,height/2);
  fill(255);
  noStroke();
  ellipse(width*0.0,height*0.0,width*0.35,height*0.623);
  popMatrix();

}
//////////////////////////////////////////////////////////////////////////

void inclination(int heightInlcint){
  
  pushMatrix();
  translate(width/2,height/2);
  rotateY = map(heightInlcint,-125,125,-90,90);
  signRotateY= -(rotateY);
  rotate(radians(-90));
  fill(#D25A0F);
  noStroke();
  strokeWeight(4);
  arc(width*0.0,height*0.0,width*.352,height*0.625,radians(90+signRotateX+signRotateY),radians(270+signRotateX-signRotateY),OPEN);
  popMatrix();
}

void Shapes(){
 arrowShape(); 
}
///////////////////////////////////////////////////////////////////////////
void arrowShape(){
  noStroke();
  fill(255,0,0);
  beginShape(TRIANGLES);
  vertex(width*0.51, height*0.03);
  vertex(width*0.50, height*0.05);
  vertex(width*0.50, height*0.12);
  endShape();
  
  beginShape(TRIANGLES);
  fill(255,0,0,150);
  vertex(width*0.49, height*0.03);
  vertex(width*0.50, height*0.05);
  vertex(width*0.50, height*0.12);
  endShape();
}
////////////////////////////////////////////////////////////////////
void danger(){
 stroke(0);
 strokeWeight(4);
 if(signRotateX>60 || signRotateX<-60){
    fill(255,0,0); 
  }
  else{
     fill(255);
  }
 ellipse(100,100,20,20);
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
