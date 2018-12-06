class compassDile{
  Clock C1;
  float _x,_y;
  float aX,aY;
  float radius = 450;
  float c1,c2,a1,a2;
  int angle,angle1;
  int i,j,k;
  String[] a = {"N","NE","E","SN","S","SW","W","NW"};
  
  compassDile(float x,float y){
    C1 = new Clock(0,0);
    this._x = x;
    this._y = y;
  } 
  void arrow(){ 
    resetMatrix();
    pushMatrix();
    translate(width/2,height/2);
    
    //1st circle
    fill(#FF9C2E);
    stroke(0); 
    strokeWeight(14);
    ellipse(0,0,(radius*2)*1.15,(radius*2)*1.15); 
    
    //2nd circle
    fill(200);
    stroke(80);
    strokeWeight(8);
    ellipse(0,0,radius*2,radius*2);             
    
    for(i = 0;i<360;i+=1){
          stroke(#A641DF);
          strokeWeight(2);
          c1 = (radius*0.95)*cos(direction+radians(i));
          c2 = (radius*0.95)*sin(direction+radians(i));
          a1 = (radius*0.99)*cos(direction+radians(i));
          a2 = (radius*0.99)*sin(direction+radians(i));
          line(c1,c2,a1,a2);
     }
        for(j = 0;j<25;j+=1){
          stroke(#DF41BD);
          c1 = (radius*0.92)*cos(direction+radians(15*j));
          c2 = (radius*0.92)*sin(direction+radians(15*j));
          a1 = (radius*0.99)*cos(direction+radians(15*j));
          a2 = (radius*0.99)*sin(direction+radians(15*j));
          line(c1,c2,a1,a2);
        }
        
    //degree numbering
    for(k = 0;k<24;k+=1){
          resetMatrix();
          translate(width/2,height/2);
          rotate(direction+radians(15*k));
          fill(0);
          textSize(30);
          textAlign(CENTER,CENTER);
          text(15*k,0,-radius*0.90);
        }
        resetMatrix();
        translate(width/2,height/2);
        rotate(direction);
        
    //moving arrow
    beginShape();
    noStroke();
    fill(255,0,0);
    vertex(0,-10-(radius*2)*0.54);
    vertex(-35,43-(radius*2)*0.54);
    vertex(35,43-(radius*2)*0.54);
    endShape(CLOSE);
    
    //arc 1st on 2nd circle
    angle1 = int(map(direction,-0,-6.283,360,0));
    if(angle1>=180 && angle1<359){
      stroke(255,0,0);
      strokeWeight(12);
      noFill(); 
      arc(0,0,radius*2,radius*2,radians(-90),radians(359-90-angle1));
    }
    else{
      stroke(255,0,0);
      strokeWeight(12);
      noFill();
      arc(0,0,radius*2,radius*2,radians(-angle1-90),radians(-90));
    }
    
    //3rd circle
    fill(230);
    noStroke();
    strokeWeight(8);
    ellipse(0,0,(radius*2)*0.85,(radius*2)*0.85); 
    
    //print the direction name on dile
    for(int i = 0;i<8;i++){
      resetMatrix();
      translate(width/2,height/2);
      rotate(direction+radians(i*45));
      fill(0);
      textSize(60);
      if(i == 0){
        textSize(80);
        fill(255,0,0);
      }
      textAlign(CENTER,CENTER);
      text(a[i],0,-radius*0.77);
    }
    
    //4rd cirlce
    stroke(#4162DF);
    fill(0);
    ellipse(0,0,(radius*2)*0.7,(radius*2)*0.7);
    
    //5th circle
    stroke(#B63AE9);
    strokeWeight(8);
    ellipse(0,0,25,25);                         
    popMatrix();
  }
  //function for degree
  void degree(){
    pushMatrix();
    translate(width/2,height/2);
    angle = int(map(direction,-0,-6.283,0,360));
    //call clock function
    C1.clkDile(); 
    fill(255);
    stroke(0);
    rectMode(CENTER);
    rect(0,-150,150,100,7);
    fill(0);
    textSize(80);
    textAlign(CENTER,CENTER);
    text(angle+"°",0,-150);
    
    fill(255);
    stroke(0);
    rectMode(CENTER);
    rect(0,150,100,100,7);
    fill(0);
    textSize(80);
    textAlign(CENTER,CENTER);
    if(angle>=0 && angle<22.5 || angle<=359 && angle>337.5){
      text("N",0,150);
    }
    else if (angle<67.5 && angle>22.5){
      text("NE",0,150);
    }
    else if (angle<112.5 && angle>67.5){
      text("E",0,150);
    }
    else if (angle<157.5 && angle>112.5){
      text("SE",0,150);
    }
    else if (angle<202.5 && angle>157.5){
      text("S",0,150);
    }
    else if (angle<247.5 && angle>202.5){
      text("SW",0,150);
    }
    else if (angle<292.5 && angle>247.5){
      text("W",0,150);
    }
    else{
      text("NW",0,150);
    }
    
    //rotate clock by 90 degree
    rotate(radians(-90));
    C1.hrHand();
    C1.mnHand();
    C1.secHand();
    popMatrix();
  }
  
}