CompassManager compass;
compassDile c;

float direction;

void setup() {
  size(displayWidth, displayHeight); 
  compass = new CompassManager(this);
  c = new compassDile(width/2, height/2);
  
}

void pause() {
  if (compass != null) compass.pause();
}

void resume() {
  if (compass != null) compass.resume();
}

void draw() {
  background(100,150);
 // c.dile();
  c.arrow();
  c.degree();
}

void directionEvent(float newDirection) {
  direction = newDirection;
}
