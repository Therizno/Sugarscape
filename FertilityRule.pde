class FertilityRule{
  
  Map<Character, Integer[]> childbearingOnset;
  Map<Character,Integer[]> climactericOnset;
  HashMap<Agent, Integer[]> fertilityDict;

   public FertilityRule(Map<Character, Integer[]> childbearingOnset, Map<Character, Integer[]> climactericOnset){
     this.childbearingOnset = childbearingOnset;
     this.climactericOnset = climactericOnset;
     this.fertilityDict = new HashMap<Agent, Integer[]>();
   }
   
   public boolean isFertile(Agent a){
     if(a == null || !a.isAlive()){
       if(fertilityDict.containsKey(a)){
         fertilityDict.remove(a);
       }
       return false;
     }
     if(!fertilityDict.containsKey(a)){
       Integer[] intA = new Integer[] {(int)random(childbearingOnset.get(a.getSex())[0], childbearingOnset.get(a.getSex())[1] + 1), 
                                       (int)random(climactericOnset.get(a.getSex())[0], climactericOnset.get(a.getSex())[1] + 1), 
                                       a.getSugarLevel()};
       fertilityDict.put(a, intA);
       
     }
     return (fertilityDict.get(a)[0] <= a.getAge() && a.getAge() < fertilityDict.get(a)[1] && a.getSugarLevel() >= fertilityDict.get(a)[2]);
   }
  
  public boolean canBreed(Agent a, Agent b, LinkedList<Square> local){
    if(this.isFertile(a) && this.isFertile(b) && a.getSex() != b.getSex()){
      for(Square temp : local){
        if(temp.getAgent() != null && temp.getAgent().equals(b)){
          for(Square temp2 : local){
            if(temp2.getAgent() == null){
              return true;
            }
          }
          return false;
        }
      }
    }
    return false;
  }
  
  public Agent breed(Agent a, Agent b, LinkedList<Square> aLocal, LinkedList<Square> bLocal){
    if(this.canBreed(a, b, aLocal) && this.canBreed(b, a, bLocal)){
      int metabolism;
      int vision;
      Agent child;
      if((int)random(0, 2) == 0){
        metabolism = a.getMetabolism();
      }
      else{
        metabolism = b.getMetabolism();
      }
      
      if((int)random(0, 2) == 0){
        vision = a.getVision();
      }
      else{
        vision = b.getVision();
      }
      
      child = new Agent(metabolism, vision, 0, a.getMovementRule());
      a.gift(child, a.getInitialSugar()/2);
      b.gift(child, b.getInitialSugar()/2);
      
      if((int)random(0, 2) == 0){
        this.placeAtRandom(child, aLocal);
      }
      else{
        this.placeAtRandom(child, bLocal);
      }
      child.nurture(a, b);
      return child;
    }
    return null;
  }
  
  private void placeAtRandom(Agent c, LinkedList<Square> squareL){
    Square s = squareL.get((int)random(0, squareL.size()));
    
    if(s.getAgent() == null){
      s.setAgent(c);
    }
    else{
      placeAtRandom(c, squareL);
    }
  }
  
  public void breedAllAgents(SugarGrid g){
    for(int i = 0; i < g.getHeight(); i++){
      for(int j = 0; j < g.getWidth(); j++){
        Agent a = g.getAgentAt(i, j);
        if(a != null){
          LinkedList<Square> los = g.generateVision(j, i, 1);
          for(Square temp : los){
            Agent b = temp.getAgent();
            if(b != null){
              this.breed(a, b, los, g.generateVision(temp.getX(), temp.getY(), 1));
            }
          }
        }
      }
    }
  }
  
}