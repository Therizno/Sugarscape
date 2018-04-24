abstract class LineGraph extends Graph{

  int updateCalls;
  
  public LineGraph(int x, int y, int howWide, int howTall, String xlab, String ylab){
    super(x, y, howWide, howTall, xlab, ylab);
    this.updateCalls = 0;
  }
  
  public abstract int nextPoint(SugarGrid g);
  
  public void update(SugarGrid g){
  
    if(updateCalls == 0){
      super.update(g);
    }
    else{
      stroke(0);
      strokeWeight(2);
      point(this.x + updateCalls, this.y + this.howTall - nextPoint(g));
    }
    updateCalls++;
    
    if(updateCalls > howWide){
      updateCalls = 0;
    }
  }
}

class NumAgentGraph extends LineGraph{
  
  public NumAgentGraph(int x, int y, int howWide, int howTall, String xlab, String ylab){
    super(x, y, howWide, howTall, xlab, ylab);
  }
  
  public int nextPoint(SugarGrid g){
    ArrayList<Agent> agList = g.getAgents();
    int fit = agList.size()/howTall;
    
    if(fit == 0){
      return agList.size();
    }
    return agList.size() - fit * howTall;
  }
  
}

class AvSugarGraph extends LineGraph{

  public AvSugarGraph(int x, int y, int howWide, int howTall, String xlab, String ylab){
    super(x, y, howWide, howTall, xlab, ylab);
  }
  
  public int nextPoint(SugarGrid g){
    ArrayList<Agent> agList = g.getAgents();
    int sugarTotal = 0;
    
    for(Agent ag : agList){
      sugarTotal += ag.getSugarLevel();
    }
    
    if(agList.size() > 0){
      int av = sugarTotal/agList.size();
      int fit = av/howTall;
    
      if(fit == 0){
        return av;
      }
      return av - fit * howTall;
      }
      return 0;
  }
  
}

class AvAgeGraph extends LineGraph{

  public AvAgeGraph(int x, int y, int howWide, int howTall, String xlab, String ylab){
    super(x, y, howWide, howTall, xlab, ylab);
  }
  
  public int nextPoint(SugarGrid g){
    ArrayList<Agent> agList = g.getAgents();
    int ageTotal = 0;
    
    for(Agent ag : agList){
      ageTotal += ag.getAge();
    }
    int av = 0;
    if(agList.size() > 0){
      av = ageTotal/agList.size();
    }
    int fit = av/howTall;
    
    if(fit == 0){
      return av;
    }
    return av - fit * howTall;
  }
}

class CultureGraph extends LineGraph{
  
  public CultureGraph(int x, int y, int howWide, int howTall, String xlab, String ylab){
    super(x, y, howWide, howTall, xlab, ylab);
  }
  
  public int nextPoint(SugarGrid g){
    ArrayList<Agent> agList = g.getAgents();
    int cultTotal = 0;
    
    for(Agent ag : agList){
      if(ag.getTribe()){
        cultTotal++;
      }
    }
    
    int fit = cultTotal/howTall;
    
    if(fit == 0){
      return cultTotal;
    }
    return cultTotal - fit * howTall;
  }

}