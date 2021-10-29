import processing.video.*;
//import gifAnimation.*;  //not support this version.

Movie saveMovie;
float angle = 0.0;
PImage tximg1, tximg2, tximg3, tximg4;
PGraphics bufImage;
float bgZ = 0.0, frontY = 0.0;
ParticleSystem ps;
boolean running = false;
int runningCount = 0;
int recordIndex = 0;
boolean recordFlag = false;
ArrayList<Sprite> sprites;
ArrayList<Sprite> spriteGroup;
int groupCount = 500;
int lineIndex = 0;
int radiIndex = 0;  //for round setp via radius
float maxRadius = 0.0;
float minRadius = 0.0;
float checkRadius = 0.0;
float checkStep = 1;
boolean finishFlg = false;
int drawIndex = -10;
boolean particleFlg = false;
PImage particleBufImg;

void setup() {
  size(1000,1000, P3D);
  sprites = new ArrayList<Sprite>();
  spriteGroup = new ArrayList<Sprite>();
  tximg1 = loadImage("chi2s.png");
  tximg2 = loadImage("mei2s.png");
  tximg3 = loadImage("wang2s.png");
  tximg4 = loadImage("liang2s.png");
  
  //tximg1.resize(int(400+random(100)),int(400+random(100)));
  //for last gif.5 img400+rnd
  //tximg1.resize(600,600);
  tximg1.resize(int(400+random(120)),int(400+random(120)));
  tximg2.resize(int(400+random(120)),int(400+random(120)));
  tximg3.resize(int(400+random(120)),int(400+random(120)));
  tximg4.resize(int(400+random(120)),int(400+random(120)));
  //for gif 04_3/04_4
  //minRadius = 0.0;
  //maxRadius = sqrt(pow(600/2,2) + pow(600/2,2));
  //checkRadius = maxRadius;
  //for gif 5. original point out screen. at(-200,1200)
  minRadius = sqrt(pow(600/2,2) + pow(600/2,2))+70;
  maxRadius = sqrt(pow(1200,2) + pow(1200,2));
  println("min:"+minRadius+" max"+maxRadius);
  checkRadius = minRadius;

  //bufImage = new
  bufImage = createGraphics(1000,1000);
  particleBufImg = createImage(1000,1000,0);
  //for single sprite
  //sprites.add(new Sprite(bufImage, new PVector(width/2, height/2), color(200, 20, 20, 180), tximg1));
  //for 4 sprites.
  sprites.add(new Sprite(bufImage, new PVector(width/3+random(-50,50), height/3+random(-50,50)), color(200, 20, 20, 180), tximg1));
  sprites.add(new Sprite(bufImage, new PVector(width*2/3+random(-50,50), height/3+random(-50,50)), color(200, 200, 20, 180), tximg2));
  sprites.add(new Sprite(bufImage, new PVector(width/3+random(-50,50), height*2/3+random(-50,50)), color(200, 20, 200, 180), tximg3));
  sprites.add(new Sprite(bufImage, new PVector(width*2/3+random(-50,50), height*2/3+random(-50,50)), color(20, 20, 200, 180), tximg4));
  //sprites.add(new Sprite(bufImage, new PVector(width/2, height/2), color(200, 200, 20, 180), tximg2));
  //sprites.add(new Sprite(bufImage, new PVector(width/2, height/2), color(200, 20, 200, 180), tximg3));
  //sprites.add(new Sprite(bufImage, new PVector(width/2, height/2), color(20, 20, 200, 180), tximg4));
  ps = new ParticleSystem();
  //lineIndex = sprites.get(0).spriteImage.height-1;
  lineIndex = 0;
  //addParticleLine(sprites.get(2).spriteImage, lineIndex);
  //addParticleCircle(sprites.get(2).spriteImage, checkRadius);
  //addParticleCircle2(sprites.get(3).spriteImage, checkRadius);
  //initParticleSystem(sprites.get(0).spriteImage);
  frameRate(10);
  finishFlg = true;
  //drawImages();
  //drawQuiteImages();   //last gif
}

void addGroup() {
  int rndWidth = int(100 + random(300));
  int rndHeight = rndWidth;
  //int imgIndex = int(map(random(0,1),0,1,0,3));
  int imgIndex = int(random(0,3.49));
  float rndX = random(0,width);
  float rndY = random(0,height);
  color rndC = color(random(20,250), random(20, 250), random(20,250), random(100,230));
  tximg1 = loadImage("chi2s.png");
  tximg2 = loadImage("mei2s.png");
  tximg3 = loadImage("wang2s.png");
  tximg4 = loadImage("liang2s.png");
  switch(imgIndex) {
    case 0:
      tximg1.resize(rndWidth, rndHeight);
      Sprite tmp1 = new Sprite(bufImage, new PVector(rndX, rndY), rndC, tximg1);
      tmp1.setAngle(random(-PI/2, PI/2));
      spriteGroup.add(tmp1);
      break;
    case 1:
      tximg2.resize(rndWidth, rndHeight);
      Sprite tmp2 = new Sprite(bufImage, new PVector(rndX, rndY), rndC, tximg2);
      tmp2.setAngle(random(-PI/2, PI/2));
      spriteGroup.add(tmp2);
      break;
    case 2:
      tximg3.resize(rndWidth, rndHeight);
      Sprite tmp3 = new Sprite(bufImage, new PVector(rndX, rndY), rndC, tximg3);
      tmp3.setAngle(random(-PI/2, PI/2));
      spriteGroup.add(tmp3);
      break;
    case 3:
      tximg4.resize(rndWidth, rndHeight);
      Sprite tmp4 = new Sprite(bufImage, new PVector(rndX, rndY), rndC, tximg4);
      tmp4.setAngle(random(-PI/2, PI/2));
      spriteGroup.add(tmp4);
      break;
    default:
      tximg4.resize(rndWidth, rndHeight);
      Sprite tmp = new Sprite(bufImage, new PVector(rndX, rndY), rndC, tximg4);
      tmp.setAngle(random(-PI/2, PI/2));
      spriteGroup.add(tmp);
      break;
  }
}

void draw() {
  background(0);
  //addLight();
  //drawImages();
  //drawGogogo();
  //drawGroup();
  //drawBufImage();
  if(running)
    ps.run();
  if(finishFlg) {
    //drawImage(3);   //draw single sprite
    //drawImages();
    drawQuiteImages();
    drawBufImage();
  } else {
    ps.display();
    /*---- for gif_4_2-----*/
    //if(lineIndex < sprites.get(2).spriteImage.height) {
    //  lineIndex += 1;
    //  addParticleLine3(sprites.get(2).spriteImage, lineIndex);
    //} else {
    //  if(checkGenieFinish()) {
    //    finishFlg = true;
    //    //clear particles.
    //  }
    //}
    /*------for gif 4_3--------*/
    //if(checkRadius < maxRadius) {
    //  checkRadius += checkStep;
    //  addParticleCircle(sprites.get(2).spriteImage, checkRadius);
    //} else {
    //  if(checkGenieFinish()) {
    //    finishFlg = true;
    //  }
    //}
    /*------for gif 4_4--------*/
    //if(checkRadius > 0) {
    //  checkRadius -= checkStep;
    //  if(checkRadius < 0 ) checkRadius = 0.0;
    //  addParticleCircle2(sprites.get(3).spriteImage, checkRadius);
    //} else {
    //  if(checkGenieFinish()) {
    //    finishFlg = true;
    //  }
    //}
    
  }
  if(recordFlag) {
    if(recordIndex < 2000) {
      recordFrame();
      recordIndex+=1;
    }
  }
  if(runningCount < 20000) {
    runningCount +=1;
  } else {
    runningCount = 0;
  }
}


void drawBufImage() {
  //textureMode(NORMAL); 
  pushMatrix();
  translate(width/2, height/2, 0); 
  //rotateY(0.5);
  //noFill();
  rotateY(angle);
  beginShape();
  noStroke();
  texture(bufImage);
  vertex((-1)*bufImage.width/2, (-1)*bufImage.height/2, 0, 0, 0);
  vertex( bufImage.width/2, (-1)*bufImage.height/2, 0, bufImage.height, 0);
  vertex( bufImage.width/2,  bufImage.height/2, 0, bufImage.width, bufImage.height);
  vertex((-1)*bufImage.width/2,  bufImage.height/2, 0, 0,  bufImage.height);
  endShape();
  popMatrix();
  if(bgZ > -1000) {
    bgZ -= 10;
  } else {
    bgZ = 0;
  }
  //addLight();
  //lights();
}

void drawImages() {
  bufImage.beginDraw();
  bufImage.background(0);
  for (int i = 0; i< sprites.size(); i++) {
    Sprite sp = sprites.get(i);
    sp.chaosDisplay();
  }
  bufImage.endDraw();
}

void drawQuiteImages() {
  bufImage.beginDraw();
  bufImage.background(0);
  for (int i = 0; i< sprites.size(); i++) {
    //Sprite sp = sprites.get(i);
    float redV = red(sprites.get(i).lc);
    float greenV = green(sprites.get(i).lc);
    float blueV = blue(sprites.get(i).lc);
    float alphaV = alpha(sprites.get(i).lc);
    //change color all to red.
    if(drawIndex > 5 && drawIndex <= 20) {
      if(redV < 200) redV += 3;
      if(greenV > 20) greenV -= 3;
      if(blueV > 20) blueV -= 3;
      sprites.get(i).changeImgColor2(sprites.get(i).spriteImage, color(redV, greenV, blueV, alphaV));
      println("change red color:"+drawIndex+" redV:"+redV + " greenV:"+greenV + " blueV:"+blueV);
    }
    //change color all to grey.
    if(drawIndex > 20 && drawIndex < 35) {
      if(redV < 220) redV += 3;
      if(greenV < 220) greenV += 3;
      if(blueV < 220) blueV += 3;
      sprites.get(i).changeImgColor2(sprites.get(i).spriteImage, color(redV, greenV, blueV, alphaV));
      println("change grey color:"+drawIndex+" redV:"+redV + " greenV:"+greenV + " blueV:"+blueV);
    }
    if(i<drawIndex) {
      float rndAngle = 0.0;
      if(!particleFlg)
        sprites.get(i).quiteDisplay(rndAngle);
    }
  }
  if(drawIndex >= 36) {
    if(!running) {
      //init particles this particles use bufImage.
      println("ready running particles");
      particleFlg = true;
      running = true;
      //create new buffile.
      //particleBufImg = bufImage;
      //particleBufImg.beginDraw();
      //pimg.copy(src, sx, sy, sw, sh, dx, dy, dw, dh)
      //particleBufImg.copy(bufImage,0,0,width,height,0,0,width,height);
      //particleBufImg.endDraw();
      //particleBufImg.pixels = bufImage.pixels;
      particleBufImg=bufImage.get();
      
    } else {
      //draw new buf and create particle
      /*------for gif 5--------*/
      if(checkRadius < maxRadius) {
        checkRadius += checkStep;
        addParticleGroup(particleBufImg, checkRadius);
        //println("add particles");
        //ps.display();
      }
      //draw new buf.
      //bufImage.pushMatrix();
      bufImage.image(particleBufImg,0, 0);
      ps.display();
      //bufImage.popMatrix();
    }
    
  }
  bufImage.endDraw();
  if(runningCount%5==0)
    drawIndex += 1;
}

void drawImage(int i) {
  bufImage.beginDraw();
  bufImage.background(0);
  Sprite sp = sprites.get(i);
  sp.chaosDisplay();
  bufImage.endDraw();
}

void drawGogogo() {
  bufImage.beginDraw();
  bufImage.background(0);
  for (int i = 0; i< sprites.size(); i++) {
    Sprite sp = sprites.get(i);
    sp.goDisplay();
    sp.gogogo();
  }
  bufImage.endDraw();
}

void drawGroup() {
  bufImage.beginDraw();
  bufImage.background(0);
  println(spriteGroup.size());
  for (int i = 0; i< spriteGroup.size(); i++) {
    Sprite sp = spriteGroup.get(i);
    sp.groupDisplay();
  }
  bufImage.endDraw();
  if(runningCount<90)
    addGroup();
}

void initParticleSystem(PImage img) {
  for(int i=0; i<img.width; i++) {
    for(int j=0; j<img.height; j++) {
      color c = img.get(i,j);
      float alp = alpha(c);
      if(alp > 127) {
        PVector posVector = new PVector(-100,-100);
        PVector destVector = new PVector((width-img.width)/2+i,(height-img.height)/2+j);
        ps.addParticle(posVector, destVector, c);
      }
    }
  }
}

void addParticleLine(PImage img, int lineIndex) {
  for(int i=0; i<img.width; i++) {
    color c = img.get(i,lineIndex);
    float alp = alpha(c);
    if(alp > 127) {
      PVector posVector = new PVector(random(-20,width+20),random(-20,600));
      PVector destVector = new PVector((width-img.width)/2+i,(height-img.height)/2+lineIndex);
      ps.addParticle(posVector, destVector, c);
    }
  }
}

void addParticleLine2(PImage img, int lineIndex) {
  for(int i=0; i<img.width; i++) {
    color c = img.get(i,lineIndex);
    float alp = alpha(c);
    if(alp > 127) {
      PVector posVector = new PVector(random(-200,width+200),random(0,height+300));
      PVector destVector = new PVector((width-img.width)/2+i,(height-img.height)/2+lineIndex);
      ps.addParticle(posVector, destVector, c);
    }
  }
}

void addParticleLine3(PImage img, int lineIndex) {
  for(int i=0; i<img.width; i++) {
    color c = img.get(i,lineIndex);
    float alp = alpha(c);
    if(alp > 127) {
      PVector posVector = new PVector(random(-200,width+200),random(0,height+300));
      PVector destVector = new PVector((width-img.width)/2+i,(height-img.height)/2+lineIndex);
      ps.addParticle(posVector, destVector, c);
    }
  }
}

void addParticleCircle(PImage img, float checkR) {
  for(int i=0; i<img.width; i++) {
    for(int j=0; j<img.height; j++) {
      PVector Vo = new PVector(img.width/2,img.height/2);
      PVector Vxy = new PVector(i,j);
      float dist = checkDistance(Vo, Vxy);
      if(dist >= checkR && dist <checkR+checkStep) {
        //println(dist);
        color c = img.get(i,j);
        float alp = alpha(c);
        if(alp > 127) {
          //PVector posVector = new PVector(random(-200,width+200),random(-200,height+200));
          PVector So = new PVector(width/2,height/2);
          PVector posN = new PVector((width-img.width)/2+i,(height-img.height)/2+j);
          PVector posVector = So.sub(posN);
          posVector.mult(random(1,1+checkR/maxRadius+0.9));
          posN.sub(posVector);
          PVector destVector = new PVector((width-img.width)/2+i,(height-img.height)/2+j);
          ps.addParticle(new PVector(posN.x + random(-200,200),posN.y+random(-200,200)), destVector, c);
        }
      }
    }
  }
}

void addParticleCircle2(PImage img, float checkR) {
  for(int i=0; i<img.width; i++) {
    for(int j=0; j<img.height; j++) {
      PVector Vo = new PVector(img.width/2,img.height/2);
      PVector Vxy = new PVector(i,j);
      float dist = checkDistance(Vo, Vxy);
      if(dist > checkR-checkStep && dist <=checkR) {
        //println(dist);
        color c = img.get(i,j);
        float alp = alpha(c);
        if(alp > 127) {
          //PVector posVector;
          //if(i>=0 && i<img.width/2 && j>=0 && j<img.height/2) {   //area 1
          //  posVector = new PVector(random(-100,width/4+50),random(-100,height/4+50));
          //} else if(i>=img.width/2 && i<=img.width && j>=0 && j<img.height/2) {   //area 2
          //  posVector = new PVector(random(width*3/4-50,width+100),random(-100,height/4+50));
          //} else if(i>=0 && i<img.width/2 && j>=img.height/2 && j<=img.height) {   //area 1
          //  posVector = new PVector(random(-100,width/4+50),random(height*3/4-50,height+100));
          //} else {
          //  posVector = new PVector(random(width*3/4-50,width+100),random(height*3/4-50,height+100));
          //}
          PVector So = new PVector(width/2,height/2);
          PVector posN = new PVector((width-img.width)/2+i,(height-img.height)/2+j);
          PVector posVector = So.sub(posN);
          posVector.mult(random(1,1+1-checkR/maxRadius+0.5));
          posN.sub(posVector);
          PVector destVector = new PVector((width-img.width)/2+i,(height-img.height)/2+j);
          //ps.addParticle(posVector, destVector, c);
          ps.addParticle(new PVector(posN.x + random(-50,50),posN.y+random(-50,50)), destVector, c);
        }
      }
    }
  }
}

//add particles for last gif deal with bufImage.
//add a particle replace the pixel to transpalante pixel
void addParticleGroup(PImage img, float checkR) {
  for(int i=0; i<img.width; i++) {
    for(int j=0; j<img.height; j++) {
      PVector Vo = new PVector(-200,height+200);
      PVector Vxy = new PVector(i,j);
      //PVector Vxy  = new PVector((width-img.width)/2+i,(height-img.height)/2+j);
      float dist = checkDistance(Vo, Vxy);
      //println(dist);
      if(dist >= checkR && dist <checkR+checkStep) {
        //println(dist);
        color c = img.get(i,j);
        color replaceC = color(0,0,0,255);
        float alp = alpha(c);
        float redV = red(c);
        float greenV = green(c);
        //println("alp:"+alp+" redV"+redV+" greenV"+greenV);
        if(alp > 10 && redV > 10 && greenV > 10) {
          //generate a new particle
          //PVector posVector = new PVector(random(-200,width+200),random(-200,height+200));
          color goldC = color(220+random(35), 160+random(50), random(20), 200);
          color goldC2 = color(220+random(35), 160+random(50), random(20), 100);
          PVector posN = new PVector(random(-400,50),random(-300,height+300));
          PVector posVector = new PVector((width-img.width)/2+i,(height-img.height)/2+j);
          ps.addParticle(posVector, new PVector(posN.x + random(-10,10),posN.y+random(-10,10)), goldC);
          //add an only show particle.
          ps.addParticle(new PVector(posVector.x+random(50),posVector.y-random(50)), new PVector(posN.x + random(-10,10),posN.y+random(-10,10)), goldC2);
          //ps.addParticle(new PVector(posVector.x+random(50),posVector.y-random(50)), new PVector(posN.x + random(-10,10),posN.y+random(-10,10)), goldC);
          //replace pixel.
          //println("gen a particle");
          img.set(i,j,replaceC);
          //img.fill(replaceC);
          //img.rect(i,j,1,1);
        }
      }
    }
  }
}

boolean checkGenieFinish() {
  boolean finishFlg = true;
  for(int i=0; i<ps.particles.size(); i++) {
    Particle pa = ps.particles.get(i);
    if((pa.position.x != pa.destPosition.x) || (pa.position.y != pa.destPosition.y)) {
      finishFlg = false;
      break;
    }
  }
  return finishFlg;
}

float checkDistance(PVector p1, PVector p2) {
  float dist = 0.0;
  dist=sqrt(pow((p2.x-p1.x),2)+pow((p2.y-p1.y),2));
  return dist;
}
  
void addLight() {
  ambientLight(218, 211, 27);
  directionalLight(218, 211, 27, 0, 0, -100);
  spotLight(255, 0, 0, width/2, height/2, 10, 10, 0, -100, PI/4, 2);

}

void mouseDragged() {
  //angle = TWO_PI/10/abs(pmouseX-mouseX);
  println(angle);
  //rotateY(angle);
}

void roundY() {
  if(angle < TWO_PI) {
    angle += 0.05;
  } else {
    angle = 0.0;
  }
}

void mousePressed() {
  lights();
  running = true;
  if (mouseButton == LEFT) {
    //angle += 0.2;
    for (int i = 0; i< sprites.size(); i++) {
      Sprite sp = sprites.get(i);
      //sp.reset();
    }
  } else if(mouseButton == RIGHT) {
    //angle -= 0.2;
    ;
  }
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      if(!recordFlag) {
        println("begin record screen");
        recordFlag = true;
        recordIndex = 0;
      } else {
        println("end record screen");
        recordFlag = false;
      }
    } else if (keyCode == DOWN) {
      //save file
      println("save files");
      String fileName = "./img/" +millis() + ".png";
      saveFrame(fileName);
    } 
  }
}

void createGif() {
  ;  //add later
}

void recordFrame() {
  String fileName = "./gif/" +recordIndex + ".png";
  saveFrame(fileName);
}
