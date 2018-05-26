import processing.serial.*;
Serial myPort;

String angleX = "";
String angleY = "";
String angleZ = "";

String data = "";
int comma_index = 0;
int dot_index = 0;

void setup(){
  
  size(displayWidth,displayHeight);
  myPort =new Serial(this,COM10,9600);
  myPort.bufferUntil("\n");
  
}

void draw(){
  
  background(0);
  fill(20,100,50);
  textSize(80);
  text(angleX,width/2,500);
  
  fill(20,100,50);
  textSize(80);
  text(angleY,width/2,1000);
  
  fill(20,100,50);
  textSize(80);
  text(angleZ,width/2,1500);
  
  
}
void serialEvent(Serial myPort) { 
  
  data = myPort.readStringUntil("\n");
  data = data.substring(0,data.length()-2);
  
  //check for commo
  comma_index = data.indexOf(',');
  angleX = data.substring(0,comma_index);
  
  //check for dot
  dot_index = data.indexOf('.');
  angleY = data.substring(comma_index,dot_index);
  
  //check for \n
  angleZ = data.substring(dot_index,data.length());
  
  
} 


