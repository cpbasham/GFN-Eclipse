class Circle {

  float xAngle;
  float yAngle;
  float xScalar;
  float yScalar;
  float xSpeed;
  float ySpeed;

  float x;
  float y;
  float radius;

  color c;

  Circle(float xPos, float yPos, float r, color col) { // user-controlled circle
    x = xPos;
    y = yPos;
    radius = r;
    c = col;
  }

  void initialize_random_values() {
    xAngle = random(3.14159);
    yAngle = random(3.14159);
    xScalar = random(550 + (75-radius));
    yScalar = random(285 + (75-radius));
    xSpeed = random(.05);
    ySpeed = random(.04);
    x = width/2 + cos(xAngle) * xScalar;
    y = height/2 + sin(yAngle) * yScalar;
  }

  void play_display(boolean user_circle) {
    stroke(c);
    fill(c);
    if (user_circle) { // base movement on touch
      x = mouseX;
      y = mouseY;
    } else { // roam
      x = width/2 + cos(xAngle) * xScalar;
      y = height/2 + sin(yAngle) * yScalar;
      xAngle += xSpeed;
      yAngle += ySpeed;
    }
    
    ellipse(x, y, radius*2, radius*2);
  }
  
  void immobile_display() {
    stroke(c);
    fill(c);
    ellipse(x, y, radius*2, radius*2);
  }





  float getLeftX() {
    return x - radius;
  }
  float getRightX() {
    return x + radius;
  }
  float getTopY() {
    return y - radius;
  }
  float getBotY() {
    return y + radius;
  }

  boolean encompassesRoamer(Circle other) {
    return (getLeftX()  < other.getLeftX()  && getTopY() < other.getTopY() &&
            getRightX() > other.getRightX() && getBotY() > other.getBotY());
  }
  
  boolean seesRoamer(Circle other) {
    return sqrt(pow(x - other.x, 2) + pow(y - other.y, 2)) < radius + other.radius;
  }
  
  boolean encompassesScreen(int sWidth, int sHeight) { // There's surely some math I can do to make this better
    return (getLeftX() < -1 * sWidth  && getRightX() > sWidth &&
            getTopY()  < -1 * sHeight && getBotY()   > sHeight);
  }
}

