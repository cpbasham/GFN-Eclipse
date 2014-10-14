Circle roamer, user;
color c;

int mode;
// modes:
// 1 - playing
// 

void setup() {
  orientation(LANDSCAPE);
  user = new Circle(0, 0, 200, color(0)); // black circle
  
  // Using custom start for roamer.  After this first time it is randomized.
  float roamer_radius = user.radius * (3.0/4.0);
  roamer = new Circle(width-roamer_radius, 0, roamer_radius, color(255)); // white circle
  roamer.yAngle = 0;
  roamer.yScalar = 250;
  roamer.ySpeed = .01;
  roamer.xAngle = 0;
  roamer.xScalar = width/2 - roamer_radius;
  roamer.xSpeed = 0;
  
  c = roamer.c;

  mode = 1;
}

void draw() {
  if (mode == 1) {
    background(c);
    user.play_display(true);
    roamer.play_display(false);
    if (user.encompassesRoamer(roamer)) {
      mouseX = int(roamer.x);
      mouseY = int(roamer.y);
      mode = 2;
    }
  } else if (mode == 2) {
    if (user.encompassesScreen(width, height)) {
      swap_circles();
      mode = 1;
      background(c);
      user.play_display(true);
      roamer.play_display(false);
    } else {
      user.radius += 10;
      background(c);
      user.immobile_display();
      roamer.play_display(true);
    }
  }
}

void swap_circles() {
  Circle temp = roamer;
  roamer = user;
  user = temp;
  roamer.radius = user.radius * (3.0/4.0);
  while (true) {
    roamer.initialize_random_values();
    if (! user.seesRoamer(roamer)) {
      break;
    }
  }
  c = roamer.c;
}
