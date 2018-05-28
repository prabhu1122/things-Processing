/////////////////////////Processing Code/////////////////////////

import processing.serial.*;
Serial myPort;

String angle = "";
String data = "";
String portName = "";

void setup(){
  
  size(600,600);
  
  portName = Serial.list()[3];
  myPort = new Serial(this,portName,9600);
  myPort.bufferUntil(',');

}

void draw(){
  
  background(200);
  fill(100,30,20);
  textSize(100);
  text(angle+"°",200,300);
}

void serialEvent(Serial myPort){
   
  data = myPort.readStringUntil(',');
  angle = data.substring(0,data.length()-1);
  
}
/*
///////////////////////////////Arduino code///////////////////////////


#include<SoftwareSerial.h>
#include<Servo.h>
Servo myServo;
SoftwareSerial BT(10,11);

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  BT.begin(9600);
  myServo.attach(9);
}

void loop() {
  // put your main code here, to run repeatedly:
  if(BT.available()!=0){
    delay(10);
    int c = BT.read();
    Serial.print(c);
    Serial.print(",");
    myServo.write(c);
  }
}
*/
  
