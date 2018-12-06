class Clock{
  float m,h,hr,mn,_x,_y;
  int i,j,k,s,sec;
  Clock(float x,float y){
    _x = x;
    _y = y;
  }
  void clkDile(){
     fill(#89FBCF);
     noStroke();
     ellipse(_x,_y,530,530);
    for(i = 0;i<360;i++){
      stroke(200,150);
      strokeWeight(4);
      line(248*cos(radians(i*6)),248*sin(radians(i*6)),
      263*cos(radians(i*6)),263*sin(radians(i*6)));
    }
    //clock dile and number both
    for(i = 360;i>0;i--){
      stroke(#8E5AFC);
      strokeWeight(8);
      line(240*cos(radians(i*30)),240*sin(radians(i*30)),
      262*cos(radians(i*30)),262*sin(radians(i*30)));
    }
    for(i = 1;i<13;i++){
      fill(200);
      textSize(60);
      textAlign(CENTER,CENTER);
      text(i,290*cos(radians(30*i-90)),290*sin(radians(30*i-90)));
    }
  }
  
  void secHand(){
    sec = second();
    s = int(map(sec,0,60,0,360));
    fill(#002FFF);
    stroke(#002FFF);
    strokeWeight(4);
    line(_x,_y,230*cos(radians(s)),230*sin(radians(s)));
    ellipse(_x,_y,10,10);
  }
  
  void mnHand(){
    mn = minute();
    m = map(mn,0,60,0,360);
    fill(#0068FF);
    stroke(#0068FF,180);
    strokeWeight(8);
    line(_x,_y,200*cos(radians(m)),200*sin(radians(m)));
    ellipse(_x,_y,20,20);
  }
  
  void hrHand(){
    hr = hour();
    h = map(hr,0,12,0,360);
    fill(#00A7FF);
    stroke(#00A7FF,210);
    strokeWeight(16);
    line(_x,_y,150*cos(radians(h)),150*sin(radians(h)));
    ellipse(_x,_y,30,30);
  }
}