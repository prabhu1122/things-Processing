//////////////////////Processing Code /////////////////////
//  This code receive data from the arduino and get      //
//  it in the form of string and then use that data      //
//  in the programe.                                     //
//  Auther of this code is Prabhat Yadav                 //
//  link to download this code is:                       //
//                                                       //
///////////////////////////////////////////////////////////
import processing.serial.*;
Serial serial;
int val = 0;
String data = "";
int index = 0;
void setup (){
  size(600,700);
  String portName =  Serial.list()[3];
  serial  = new Serial(this,portName,9600);
  serial.bufferUntil('\n');
}

void draw(){
  background(200); 
  fill(#4DC0F7);
  textSize(80);
  text(val,200,height/2);
  
}

void serialEvent(Serial serial){
  
  data = serial.readStringUntil('\n');
  data  = data.substring(0,data.length()-2);
  
  index = data.indexOf('.');
  val = int(data.substring(0,index));
  
}

/*
//////////////////////Arduino Code ////////////////////////
//  This code send data from the processing and send     //
//  it in the form of string and then use that data      //
//  in the programe.                                     //
//  Auther of this code is Prabhat Yadav                 //
//  link to download this code is:                       //
//                                                       //
///////////////////////////////////////////////////////////

int potPin = A0;

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  pinMode(potPin,INPUT);
}

void loop() {
  // put your main code here, to run repeatedly:
  int val = analogRead(potPin);
  int voltage = map(val,0,1023,0,255);
  Serial.print(voltage);
  Serial.print(".Volt");
  Serial.print("\n");
  
}
*/
