class AgentFactory{
  
  int minMetabolism, maxMetabolism, minVision, maxVision, minInitialSugar, maxInitialSugar;
  MovementRule m;

  public AgentFactory(int minMetabolism, int maxMetabolism, int minVision, int maxVision, int minInitialSugar, int maxInitialSugar, MovementRule m){
    this.minMetabolism = minMetabolism;
    this.maxMetabolism = maxMetabolism;
    this.minVision = minVision;
    this.maxVision = maxVision;
    this.minInitialSugar = minInitialSugar;
    this.maxInitialSugar = maxInitialSugar;
    this.m = m;
  }
  
  public Agent makeAgent(){
    Agent a = new Agent((int)random(this.minMetabolism, this.maxMetabolism + 1), (int)random(this.minVision, this.maxVision + 1), (int)random(this.minInitialSugar, this.maxInitialSugar + 1), m);
    assert a.getMetabolism() <= this.maxMetabolism;
    return a;
  }
  
}