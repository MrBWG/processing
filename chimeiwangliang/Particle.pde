// A simple Particle class

class Particle {
  PVector position;
  PVector destPosition;
  PVector velocity;
  PVector acceleration;
  float lifespan;
  color cl;
  boolean runningFlg;

  Particle(PVector pos, color c) {
    acceleration = new PVector(-2, 2);
    velocity = new PVector(random(-3, -2), random(-4, 0));
    position = pos.copy();
    cl = c;
    lifespan = alpha(c);
    runningFlg = false;
  }
  
  Particle(PVector pos, PVector dest, color c) {
    position = pos.copy();
    destPosition = dest.copy();
    cl = c;
    lifespan = alpha(c);
    runningFlg = false;
  }

  void run() {
    //if(position.x > -100 && position.y > -100) {
      //update();
      directGoDest(position, destPosition);
      lifespan -= 2.0;
      if(lifespan < 0) lifespan=0.0;
    //}
    //display();
  }
  
  float checkDistance(PVector p1, PVector p2) {
    float dist = 0.0;
    dist=sqrt(pow((p2.x-p1.x),2)+pow((p2.y-p1.y),2));
    return dist;
  }
  
  void directGoDest(PVector p1, PVector p2) {
    float dist = checkDistance(p1,p2);
    PVector vel;
    if(dist <= 20) {
      p1.x = p2.x;
      p1.y = p2.y;
    } else {
      float step = 1.0;
      if(dist > 500) {
        step = dist/6;
      } else if(dist > 200) {
        step = dist/5;
      } else if(dist > 100) {
        step = dist/4;
      } else if(dist > 20) {
        step = 10;
      } else {
        step = 10;
      }
      if(dist > 100) {
        vel =new PVector((p2.x-p1.x)/step+random(-5,5), (p2.y-p1.y)/step+random(-5,5));
      } else {
        vel =new PVector((p2.x-p1.x)/step, (p2.y-p1.y)/step);
      }
      p1.add(vel);
    }
  }
  

  // Method to update position
  void update() {
    velocity.add(acceleration);
    position.add(velocity);
    lifespan -= 1.0;
  }

  // Method to display
  void display() {
    float dist = checkDistance(position,destPosition);
    float alpha = 50.0;
    float redV = red(cl);
    float greenV = green(cl);
    float blueV = blue(cl);
    color rndCl;
    //alpha = map(dist, width*3/4, 10, 10, 220);
    if(dist > 400) {
      alpha=random(20,50);
      rndCl=color(redV + random(150), greenV+random(150), blueV+random(150));
    }
    else if(dist > 200) {
      alpha=random(50,80);
      rndCl=color(redV + random(100), greenV+random(100), blueV+random(100));
    }
    else if(dist > 10) {
      alpha=random(80,150);
      rndCl=color(redV + random(50), greenV+random(50), blueV+random(50));
    }
    else {
      alpha=random(150,230);
      rndCl = cl;
    }
    //for gif 1-4 for gif5 use liftspan for alpha channel
    //lifespan = alpha;
    stroke(rndCl, lifespan);
    fill(rndCl, lifespan);
    if(dist <= 10) {
      rect(position.x, position.y, 1, 1);
    } else {
      ellipse(position.x, position.y, 1, 1);
    }
  }

  // Is the particle still useful?
  boolean isDead() {
    if (lifespan <= 0.0) {
      return true;
    } else {
      return false;
    }
  }
}
