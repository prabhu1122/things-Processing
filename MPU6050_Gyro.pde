////////////////////////Processing Code//////////////////////

import processing.serial.*;
Serial myPort;

//PFont myFont;
int angleX = 0;
int angleY = 0;
int angleZ = 0;

String data = "";
int comma_index = 0;
int dot_index = 0;
int size = 80;

void setup() {

  size(600,650);

  String portName = Serial.list()[3];
  myPort =new Serial(this, portName, 9600);
  myPort.bufferUntil('\n');
  //myFont = loadFont("font_example.vlw");
  //textFont(myFont,80);
  
}

void draw() {

  background(200);
  fill(200, 100, 50);
  textSize(size);
  text(angleX+"°",200, 200);

  fill(20, 100, 50);
  textSize(size);
  text(angleY+"°", 200, 400);

  fill(20, 100, 50);
  textSize(size);
  text(angleZ+"°", 200, 600);
}


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
  
  Wire.beginTransmission(0b1101000);
  Wire.write(0x6B);
  Wire.write(0b00000000);
  Wire.endTransmission();
  
  Wire.beginTransmission(0b1101000);
  Wire.write(0x1B);
  Wire.write(0b00000000);
  Wire.endTransmission();
  
}
void receiveGyro(){
  
  Wire.beginTransmission(0b1101000);
  Wire.write(0x43);
  Wire.endTransmission();
  Wire.requestFrom(0b1101000,6);
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
  //Serial.print(",°");
  Serial.print(",");
  Serial.print(int(angleY));
  //Serial.print(".°");
  Serial.print(".");
  Serial.print(int(angleZ));
  //Serial.print("\n°");
  Serial.print("\n");
  delay(100);
}
*/
