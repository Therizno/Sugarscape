class Agent{
  
  private int metabolism;
  private int vision;
  private int storedSugar;
  private int initialSugar;
  private int age;
  private char sex;
  private boolean[] culture;
  MovementRule move;
  
  public Agent(int metabolism, int vision, int initialSugar, MovementRule m){
    this.metabolism = metabolism;
    this.vision = vision;
    this.storedSugar = initialSugar;
    this.initialSugar = initialSugar;
    this.move = m;
    this.age = 0;
    culture = new boolean[11];
    
    for(int i = 0; i < culture.length; i++){
      if((int)random(0, 2) == 0){
        this.culture[i] = true;
      }
    }
    
    if((int)random(0, 2) == 0){
      this.sex = 'X';
    }
    else{
      this.sex = 'Y';
    }
  }
  
  public Agent(int metabolism, int vision, int initialSugar, MovementRule m, char sex){
    this.metabolism = metabolism;
    this.vision = vision;
    this.storedSugar = initialSugar;
    this.move = m;
    this.age = 0;
    this.sex = sex;
    culture = new boolean[11];
    
    for(int i = 0; i < culture.length; i++){
      if((int)random(0, 2) == 0){
        this.culture[i] = true;
      }
    }
    
    assert(sex == 'Y' || sex == 'X');
  }
  
  public int getAge(){
    return this.age;
  }
  
  public int getMetabolism(){
    return this.metabolism;
  }
  
  public int getVision(){
    return this.vision;
  }
  
  public int getSugarLevel(){
    return this.storedSugar;
  }
  
  public int getInitialSugar(){
    return this.initialSugar;
  }
  
  public MovementRule getMovementRule(){
    return this.move;
  }
  
  char getSex(){
    return this.sex;
  }
  
  public void setAge(int howOld){
    if(howOld < 0){
      assert false;
    }
    this.age = howOld;
  }
  
  public void move(Square source, Square destination){
    Agent a = source.getAgent();
    destination.setAgent(a);
    source.setAgent(null);
  }
  
  public void step(){
    this.storedSugar = this.storedSugar - this.metabolism;
    this.age++;
  }
  
  public boolean isAlive(){
    if(this.storedSugar > 0){
      return true;
    }
    return false;
  }
  
  public void eat(Square s){
    this.storedSugar += s.getSugar();
    s.setSugar(0);
  }
  
  public void gift(Agent other, int amount){
    assert(this.storedSugar >= amount);
    this.storedSugar -= amount;
    other.storedSugar += amount;
    other.initialSugar += amount;
  }
  
  public void influence(Agent other){
    int cult = (int)random(0, 11);
    if(this.culture[cult] != other.culture[cult]){
      other.culture[cult] = this.culture[cult];
    }
  }
  
  public void nurture(Agent parent1, Agent parent2){
    for(int i = 0; i < 11; i++){
      if((int)random(0, 2) == 0){
        this.culture[i] = parent1.culture[i];
      }
      else{
        this.culture[i] = parent2.culture[i];
      }
    }
  }
  
  public boolean getTribe(){
    int t = 0;
    int f = 0;
    for(int i = 0; i < 11; i++){
      if(this.culture[i]){
        t++;
      }
      else{
        f++;
      }
    }
    return t > f;
  }
  
  public void influenceArea(int x, int y, SugarGrid g, int power){
    LinkedList<Square> area = g.generateVision(x, y, 1);
    for(Square temp : area){
      if(temp.getAgent() != null && (int)random(0, power) == 0){
        this.influence(temp.getAgent());
      }
    }
  }
  
  public void display(int x, int y, int scale, FertilityRule f){
    
    if(k == 'c'){
      if(this.getTribe()){
        fill(255, 0, 0);
      }
      else{
        fill(0, 0, 255);
      }
    }
    else if(k == 'f'){
      if(f.isFertile(this)){
        fill(0, 255, 0);
      }
      else{
        fill(0, 0, 255);
      }
    }
    ellipse(x*scale + scale/2, y*scale + scale/2, 3*scale/4, 3*scale/4);
  }
  
}