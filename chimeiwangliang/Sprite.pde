// A simple Particle class

class Sprite {
  PVector position;
  PVector velocity;
  float angle;
  color lc;
  boolean runningFlg;
  PImage spriteImage;
  PGraphics bufImage;

  Sprite(PGraphics pg, PVector pos, color c, PImage img) {
    position = pos.copy();
    lc = c;
    runningFlg = false;
    bufImage = pg;
    spriteImage = img;
    changeImgColor(spriteImage, lc);
    angle = 0.0;
    //init random velocity
    float dirRnd = random(0,1);
    if(dirRnd >= 0 && dirRnd <= 0.25) {   //x+left
      velocity = new PVector(random(-30, -10), 0);
    } else if(dirRnd > 0.25 && dirRnd <= 0.5) {   //x+right
      velocity = new PVector(random(10, 30), 0);
    } else if(dirRnd > 0.5 && dirRnd <= 0.75) {   //y+up
      velocity = new PVector(0, random(-30, -10));
    } else {   //y+down
      velocity = new PVector(0, random(10, 30));
    }
  }

  void setAngle(float ang) {
    angle = ang;
  }
  
  void gogogo() {
    position.add(velocity);
    //if(position.x < -120) position.x = width+110;
    //if(position.x > width+120) position.x = -110;
    //if(position.y < -120) position.y = height+110;
    //if(position.y > height+120) position.y = -110;
    if(position.x < spriteImage.width/2-20 || position.x > width-spriteImage.width/2+20 || position.y < spriteImage.height/2-20 || position.y > height-spriteImage.height/2+20) {
      velocity.x *= -1;
      velocity.y *= -1;
    }
  }
  
  void reset() {
    position.x = random(spriteImage.width/2, width-spriteImage.width/2);
    position.y = random(spriteImage.height/2, height-spriteImage.height/2);
    float dirRnd = random(0,1);
    if(dirRnd >= 0 && dirRnd <= 0.25) {   //x+left
      velocity = new PVector(random(-30, -10), 0);
    } else if(dirRnd > 0.25 && dirRnd <= 0.5) {   //x+right
      velocity = new PVector(random(10, 30), 0);
    } else if(dirRnd > 0.5 && dirRnd <= 0.75) {   //y+up
      velocity = new PVector(0, random(-30, -10));
    } else {   //y+down
      velocity = new PVector(0, random(10, 30));
    }
  }
  

  // Method to update position
  void update() {
    position.add(velocity);
  }

  void changeImgColor(PImage img,  color lcc) {
    lc = lcc;
    float redV = red(lcc);
    float greenV = green(lcc);
    float blueV = blue(lcc);
    float alphaV = alpha(lcc);
    for(int i=0; i<img.width; i++) {
      for(int j=0; j<img.height; j++) {
        color c = img.get(i,j);
        float alp = alpha(c);
        if(alp > 40) {
          float redRnd = redV + random(50);
          if(redRnd > 255)  redRnd = 255;
          float greenRnd = greenV + random(50);
          if(greenRnd > 255)  greenRnd = 255;
          float blueRnd = blueV + random(50);
          if(blueRnd > 255)  blueRnd = 255;
          float alphaRnd = alphaV + random(50);
          if(alphaRnd > 255)  alphaRnd = 255;
          color nc = color(redRnd, greenRnd, blueRnd, alphaRnd);
          img.set(i,j,nc);
        }
      }
    }
  }
  
  void changeImgColor2(PImage img,  color lcc) {
    lc = lcc;
    float redV = red(lcc);
    float greenV = green(lcc);
    float blueV = blue(lcc);
    float alphaV = alpha(lcc);
    //println("change color:"+drawIndex+" redV:"+redV + " greenV:"+greenV + " blueV:"+blueV);
    for(int i=0; i<img.width; i++) {
      for(int j=0; j<img.height; j++) {
        color c = img.get(i,j);
        float alp = alpha(c);
        if(alp > 40) {
          float redRnd = redV + random(50);
          if(redRnd > 255)  redRnd = 255;
          float greenRnd = greenV + random(50);
          if(greenRnd > 255)  greenRnd = 255;
          float blueRnd = blueV + random(50);
          if(blueRnd > 255)  blueRnd = 255;
          float alphaRnd = alphaV + random(50);
          if(alphaRnd > 255)  alphaRnd = 255;
          
          color nc = color(redRnd, greenRnd, blueRnd, alphaRnd);
          img.set(i,j,nc);
        }
      }
    }
  }
  
  void addColorDot(int dotCount, int x, int y,  color lc) {
    float redV = red(lc);
    float greenV = green(lc);
    float blueV = blue(lc);
    float alphaV = alpha(lc);
    for(int i=0; i<dotCount; i++) {
       float redRnd = redV + random(50);
       if(redRnd > 255)  redRnd = 255;
       float greenRnd = greenV + random(50);
       if(greenRnd > 255)  greenRnd = 255;
       float blueRnd = blueV + random(50);
       if(blueRnd > 255)  blueRnd = 255;
       float alphaRnd = alphaV + random(50);
       if(alphaRnd > 255)  alphaRnd = 255;
       color nc = color(redRnd, greenRnd, blueRnd, alphaRnd);
       int dotX = x+int(random(0-width/2,width/2));
       int dotY = y+int(random(0-width/2,height/2));
       int dotDiam = int(random(1,10));
       bufImage.fill(nc);
       bufImage.ellipse(dotX, dotY, dotDiam, dotDiam);
    }
  }
  
  // Method to display
  void chaosDisplay() {
    float rndAngle = 0.0;
    //bufImage.beginDraw();
    //bufImage.background(0);
    bufImage.pushMatrix();
    bufImage.translate(position.x+random(-10,10), position.y+random(-10,10));
    rndAngle = map(random(0,1),0,1,0-PI/12,PI/12);
    angle = rndAngle;
    bufImage.rotate(rndAngle);
    addColorDot(int(random(100)), 0, 0, lc);
    bufImage.image(spriteImage,0-spriteImage.width/2, 0-spriteImage.height/2);
    bufImage.popMatrix();
    //bufImage.endDraw();
  }
  
  void quiteDisplay(float angle) {
    float rndAngle = angle;
    //bufImage.beginDraw();
    //bufImage.background(0);
    bufImage.pushMatrix();
    bufImage.translate(position.x, position.y);
    //rndAngle = map(random(0,1),0,1,0-PI/12,PI/12);
    angle = rndAngle;
    bufImage.rotate(rndAngle);
    //addColorDot(int(random(100)), 0, 0, lc);
    bufImage.image(spriteImage,0-spriteImage.width/2, 0-spriteImage.height/2);
    bufImage.popMatrix();
    //bufImage.endDraw();
  }
  
  void goDisplay() {
    float rndAngle = 0.0;
    bufImage.pushMatrix();
    bufImage.translate(position.x+random(-10,10), position.y+random(-10,10));
    rndAngle = map(random(0,1),0,1,0-PI/10,PI/10);
    angle = rndAngle;
    bufImage.rotate(rndAngle);
    addColorDot(int(random(100)), 0, 0, lc);
    bufImage.image(spriteImage,0-spriteImage.width/2, 0-spriteImage.height/2);
    bufImage.popMatrix();
    //gogogo();
  }
  
  void groupDisplay() {
    bufImage.pushMatrix();
    bufImage.translate(position.x+random(-10,10), position.y+random(-10,10));
    //bufImage.translate(position.x, position.y);
    bufImage.rotate(angle);
    addColorDot(int(random(80)), 0, 0, lc);
    bufImage.image(spriteImage,0-spriteImage.width/2, 0-spriteImage.height/2);
    bufImage.popMatrix();
    //gogogo();
  }
}
