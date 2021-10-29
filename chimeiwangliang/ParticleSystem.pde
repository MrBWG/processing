// A class to describe a group of Particles
// An ArrayList is used to manage the list of Particles 

class ParticleSystem {
  ArrayList<Particle> particles;
  PVector origin;

  ParticleSystem() {
    particles = new ArrayList<Particle>();
  }
  
  ParticleSystem(PVector position) {
    origin = position.copy();
    particles = new ArrayList<Particle>();
  }

  void addParticle() {
    color c = color(255,255,255);
    particles.add(new Particle(origin,c));
  }
  
  void addParticle(PVector position, color c) {
    particles.add(new Particle(position, c));
  }
  
  void addParticle(PVector position,PVector destPosition, color c) {
    particles.add(new Particle(position, destPosition, c));
  }

  void run() {
    for (int i = particles.size()-1; i >= 0; i--) {
      Particle p = particles.get(i);
      p.run();
      if (p.isDead()) {
        particles.remove(i);
      }
    }
  }
  
  void display() {
    for (int i = particles.size()-1; i >= 0; i--) {
      Particle p = particles.get(i);
      p.display();
      if (p.isDead()) {
        particles.remove(i);
      }
    }
  }
  
}
