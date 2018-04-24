interface GrowthRule{

  public void growBack(Square s);
  
}


class GrowbackRule implements GrowthRule{
  int rate;
  
  public GrowbackRule(int rate){
    this.rate = rate;
  }
  
  public void growBack(Square s){
    s.setSugar(s.getSugar() + rate);
  }
}

class SeasonalGrowbackRule{
  int alpha, beta, gamma, equator, numSquares, seasonCounter;
  String season;
  
  public SeasonalGrowbackRule(int alpha, int beta, int gamma, int equator, int numSquares){
    this.alpha = alpha;
    this.beta = beta;
    this.gamma = gamma; 
    this.equator = equator;
    this.numSquares = numSquares;
    this.season = "northSummer";
    this.seasonCounter = 0;
    }
    
    public void growBack(Square s){
      if(s.getY() <= equator && season.equals("northSummer")){
        s.setSugar(s.getSugar() + alpha);
      }
      else if(s.getY() > equator && season.equals("southSummer")){
        s.setSugar(s.getSugar() + alpha);
      }
      else if(s.getY() > equator && season.equals("northSummer")){
        s.setSugar(s.getSugar() + beta);
      }
      else if(s.getY() <= equator && season.equals("southSummer")){
        s.setSugar(s.getSugar() + beta);
      }
      this.seasonCounter++;
      
      if(gamma*numSquares == seasonCounter){
        if(season.equals("northSummer")){
          this.season = "southSummer";
        }
        else{
          this.season = "northSummer";
        }
      }
    }
    
    public boolean isNorthSummer(){
      if(this.season == "northSummer"){
        return true;
      }
      return false;
    }
    
  }
  
  