///////////////---------//////////////////----------/////////////
///##This a simple code for the serial communication         ////
///from arduino to Processing                                ////
///##requirment of hardware are Arduino uno,data cable,laptop////
///##requirment of software are Arduino IDE, processing PDE. ////
/////////////////---------//////////////////----------///////////

import processing.serial.*; //import the serialp library;
Serial port;                //make an object of serial port;

color red;
color green;
color blue;

int degree;
int widthX;
int Red;

void setup(){
  //write code run only once;
  size(displayWidth,displayHeight);    //set the dimension of window
  red =   color(255,0,0);
  green = color(0,255,0);
  blue =  color(0,0,255);
  
  //in this Serial constructor function "COM10" is according 
  //to your serial port in the system;you can ckeck it to click 
  //on tools and then click on port ;
  port = new Serial(this,"COM10",9600);
}

void draw(){
  //this code will runs repeatedly;
   background (0);
   setGradiant(0,50,width,100,red,green);
   
   
   if(mousepressed()){
     dragg();
     slider();
   }
   
   //setGradiant(0,100,800,100,green,blue);
}

///////////////////////////////////////////////////////////////
void setGradiant(int x,int y,int w,int h,color c1,color c2){
  for(int i = x;i <= w+x; i++){
    
    float enter = map(i,x,x+w,0,1);
    color c = lerpColor(c1,c2,enter);
    
    stroke(c);
    line(i,y,i,y+h);
    
    
  }
}

///////////////////////////////////////////////////////////////

void dragg(){
  
  if(mouseX>0 && mouseX<width){
    
    if(mouseY>50 && mouseY<=150){
      
      widthX = mouseX;
      textSize(50);
      stroke(0);
      degree = int(map(widthX,0,width,0,180));
      text(degree,width/2,height/2);
      sendMsg(degree);
    }
    else if(mouseX>0 && mouseX<width && mouseY>50 && mouseY<=100){
     
      text(degree,width/2,height/2);
    }
    
  }
  
}

///////////////////////////////////////////////////////////////

void slider(){
  strokeWeight(4);
  stroke(0);
  fill(255);
  rectMode(CENTER);
  rect(mouseX,100,50,120);
}

/////////////////////////////////////////////////////////////////
//check the mousepressed;

boolean mousepressed(){
  
  if(mouseY>40 && mouseY<160){
    
    return true;
  }
  else{
    return false;
  }
  
}

///////////////////////////////////////////////////////////////

void sendMsg(int a){
  
  println(a);    // print the value on Console
  
  port.write(a); //write the value on serial port ;
  
}



/////////////Arduino code/////////////

//this code will controle an LED from the serial 

//data coming from the processing

//the processing code will get from the link below

// "https://github.com/prabhu1122/things-Processing/blob/master/Serial_comm.pde " 

/*
#define led 9      //create pin 9 for led

void setup(){
    
    Serial.begin(9600);  //start the serial port at 
                         //boudRate 9600
    pinMode(led,OUTPUT); //set led pin as output
    
}

void loop(){
    //check wheather any serial data is comming
    
    if(Serial.available()>0){
      
        delay(5);    //delay for stablisation
        
        //read the serial data 
        int data = Serial.read();
        
        int val = map(data,0,180,0,255);
        
        Serial.println(val);   //print the serial data
        
        analogWrite(led,val);
    }
    
}
*/
