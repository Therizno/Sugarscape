import java.util.*;

class ReplacementRule{

  private HashMap<Agent, Integer> ageList;
  private int minAge, maxAge;
  AgentFactory fac;
  
  public ReplacementRule(int minAge, int maxAge, AgentFactory fac){
    this.minAge = minAge;
    this.maxAge = maxAge;
    this.fac = fac;
    this.ageList = new HashMap<Agent, Integer>();
  }
  
  public boolean replaceThisOne(Agent A){
    
    if(A == null){
      return false;
    }
    
    if(!ageList.containsKey(A)){
      
      ageList.put(A, (int)random(minAge, maxAge));
      
    }
    
    if(ageList.get(A) < A.getAge() || !A.isAlive()){
      A.setAge(this.maxAge + 1);
      return true;
    }
    
    return false;
  }
  
  
  public Agent replace(Agent A, List<Agent> others){
    return this.fac.makeAgent();
  }
  
  public void replaceGrid(SugarGrid g){
    for(int i = 0; i < g.getHeight(); i++){
      for(int j = 0; j < g.getWidth(); j++){
        if(this.replaceThisOne(g.getAgentAt(i, j))){
          g.grid[i][j].setAgent(null);
        }
      }
    }
  }
  
}