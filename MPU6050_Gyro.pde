
////////////////////////Processing Code//////////////////////

import processing.serial.*;
Serial myPort;

//PFont myFont;
String angleX = "";
String angleY = "";
String angleZ = "";

String data = "";
int comma_index = 0;
int dot_index = 0;
int size = 80;

void setup() {

  size(displayWidth, displayHeight);

  String portName = Serial.list()[0];
  myPort =new Serial(this, portName, 9600);
  myPort.bufferUntil("\n");
  //myFont = loadFont("font_example.vlw");
  //textFont(myFont,80);
  
}

void draw() {

  background(0);
  fill(20, 100, 50);
  textSize(size);
  text(angleX, width/2, 500);

  fill(20, 100, 50);
  textSize(size);
  text(angleY, width/2, 1000);

  fill(20, 100, 50);
  textSize(size);
  text(angleZ, width/2, 1500);
}


void serialEvent(Serial myPort) { 

  data = myPort.readStringUntil('\n');
  data = data.substring(0, data.length()-2);

  //check for commo
  comma_index = data.indexOf(',');
  angleX = data.substring(0, comma_index);

  //check for dot
  dot_index = data.indexOf('.');
  angleY = data.substring(comma_index+1, dot_index);

  //check for \n
  angleZ = data.substring(dot_index+1, data.length());
  
} 


///////////////////////////Arduino code/////////////////////
/*
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
  
  Serial.print(angleX);
  Serial.print("°,");
  Serial.print(angleY);
  Serial.print("°.");
  Serial.print(angleZ);
  Serial.print("°\n");
  
}
*/
