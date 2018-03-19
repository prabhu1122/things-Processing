//This is code for fireworks apk file on apde Processing

//I have made it with the hlep of youtube videos of "The Coding Train."

//You can also see tutorials on my youtube channel prabhuTech fun.


                       /////****Fireworks****////
            
//**with the help of youtube channel "The Coding Train" by Shiffman.***//


ArrayList<Firework> fireworks;

PVector gravity = new PVector(0,0.2);

void setup(){
  
  size(displayWidth,displayHeight);
  fireworks = new ArrayList<Firework>(); 
  
}


void draw(){
  
  noStroke(); 
  fill(0,30); 
  rect(0,0,width,height);
  
  if(random(1)<0.1){
    
    fireworks.add(new Firework(random(255),random(255),random(255)));
  }
  
   for(int i = fireworks.size()-1;i>=0;i--){
    
      Firework f = fireworks.get(i);
      
      f.run();
      
      if(f.done()){
        
        fireworks.remove(i); 
        
      }  
      
   }
  
}

////////////////////////////////////////////////////

class Firework{
  
  ArrayList<Particles> particles;
  
  Particles firework;
  
  float red;
  float green;
  float blue;
  
  Firework(float fcol1,float fcol2,float fcol3 ){
    
    red = fcol1;
    green = fcol2;
    blue = fcol3;
    
    particles = new ArrayList<Particles>();
    firework = new Particles(random(0,width),random(200,900),random(red),random(green),random(blue));
    
  }
  boolean done(){
    
    if(firework == null && particles.isEmpty()){
      return true;
    }else{
      return false;
    } 
  }
  void run(){
    
    if(firework != null){
      
      fill(red,green,blue);
      firework.applyForce(gravity);
      firework.update();
      firework.display();
      
      if(firework.explode()){
        
        for(int i = 0; i<300; i++){
          
          particles.add(new Particles(firework.loc,random(red),random(green),random(blue)));
          
        }
        firework = null;
      }
    }
    for(int i = particles.size()-1;i>=0;i--){
      Particles p = particles.get(i);
      
      p.applyForce(gravity);
      p.run();
      
      if(p.dead()){
        particles.remove(i);
        
      }
    }
  }
  
  boolean dead(){
    
    if(particles.isEmpty()){
      return true;
    }
    else{
      return false;
    }
  }
  
}

///////////////////////////////////////////////////////

class Particles{
  
  PVector loc;
  PVector acc;
  PVector vel;
  
  float lifespan;
  float red;
  float green;
  float blue;
  
  boolean seed = false;
  
  Particles(float x,float y,float col1,float col2,float col3){
    
    red = col1; 
    green = col2; 
    blue = col3;
    
    loc = new PVector(x,y); 
    vel = new PVector(0,random(-19,-10));
    acc = new PVector(0,0);
    
    seed = true;
    lifespan = 255;
    
  }
  Particles(PVector l,float col1,float col2,float col3){
    
    red = col1;
    green = col2;
    blue = col3;
    
    acc = new PVector(0,0);
    
    vel = PVector.random3D();
    
    vel.mult(random(10));  
    
    loc = new PVector(l.x,l.y,l.z);
    
    lifespan = 255;
    
  }   
  
  void applyForce(PVector force){
    
    acc.add(force);
    
  }
 
  void run(){
    
    update();
    display();
    
  }
  
  void update(){
    
    vel.add(acc);
    loc.add(vel); 
    
    lifespan -= 8;
    acc.mult(0);
    
  }
  
  void display(){
    
    if(!seed && mousePressed){
      
      stroke(red,green,blue,lifespan);
      
      if(seed){
        strokeWeight(10); 
      }
      else{   
        strokeWeight(5);      
      } 
    }
    else{  
      stroke(red,green,blue,lifespan);
    if(seed){    
      strokeWeight(10);    
    }  
    else{    
      strokeWeight(5);    
    }  
  }
  
  //ellipse(loc.x,loc.y,.5,.5);
  point(loc.x,loc.y,loc.z);
  
 }

 boolean explode(){
   
   if(seed && vel.y>0 || seed && vel.y<255){
     
     lifespan = 0;
     
     return true;   
   } 
   else{
     
     return false;
     
   }
   
 }
 
 boolean dead(){
   
   if(lifespan < 0){
     
     return true;   
   } 
   else{    
     return false;
     
   }
   
 }
 
}
