import java.util.Collections;

interface MovementRule{

  public Square move(LinkedList<Square> neighbourhood, SugarGrid g, Square middle);
  
}

class PollutionMovementRule implements MovementRule{

  public PollutionMovementRule(){}
  
  public Square move(LinkedList<Square> neighborhood, SugarGrid g, Square middle){
    Square biggest = new Square(0, 0, 0, 0);
    int n = -1;
    
    Collections.shuffle(neighborhood);
    
    for(Square temp : neighborhood){
      if(temp.getPollution() == 0){
      biggest = temp;
      break;
      }
      else if(temp.getSugar()/temp.getPollution() > n){
        biggest = temp;
        n = temp.getSugar()/temp.getPollution();
      }
    }
    
    for(Square temp : neighborhood){
      if(temp.getPollution() == 0){
        if(g.euclidianDistance(middle, biggest) > g.euclidianDistance(middle, temp)){
          biggest = temp;
        }
      }
      
      else if(biggest.getPollution() != 0 && temp.getSugar()/temp.getPollution() == biggest.getSugar()/biggest.getPollution()){
        if(g.euclidianDistance(middle, biggest) > g.euclidianDistance(middle, temp)){
          biggest = temp;
        }
      }
    }
    
    return biggest;
  }
  
}

class SugarSeekingMovementRule implements MovementRule{

  public SugarSeekingMovementRule(){}
  
  public Square move(LinkedList<Square> neighborhood, SugarGrid g, Square middle){
    Square biggest = new Square(0, 0, 0, 0);
    int n = -1;
    
    Collections.shuffle(neighborhood);
    
    for(Square temp : neighborhood){
      if(temp.getSugar() > n){
        biggest = temp;
        n = temp.getSugar();
      }
    }
    
    for(Square temp : neighborhood){
      if(temp.getSugar() == biggest.getSugar()){
        if(g.euclidianDistance(middle, biggest) > g.euclidianDistance(middle, temp)){
          biggest = temp;
        }
      }
    }
    
    return biggest;
  }
  
}

class CombatMovementRule extends SugarSeekingMovementRule{

  int alpha;
  
  public CombatMovementRule(int alpha){
    super();
    this.alpha = alpha;
  }
  
  public Square move(LinkedList<Square> neighbourhood, SugarGrid g, Square middle){
    
    Agent middleAgent = middle.getAgent();
    
    //removes agents of same tribe or greater sugar
    Iterator<Square> si1 = neighbourhood.iterator();
    while(si1.hasNext()){
      Agent z = si1.next().getAgent();
      if(z != null && (middleAgent.getTribe() == z.getTribe() || middleAgent.getSugarLevel() <= z.getSugarLevel())){
        si1.remove();
      }
    }
    
    //removes squares where middleAgent could be attacked if it moved there
    Iterator<Square> si2 = neighbourhood.iterator();
    while(si2.hasNext()){
      Square temp = si2.next();
      if(temp.getAgent() != null){
        boolean removeThisOne = false;
        LinkedList<Square> moveViz = g.generateVision(temp.getX(), temp.getY(), middleAgent.getVision());
        for(Square temp2 : moveViz){
          if(temp2.getAgent() != null && temp2.getAgent().getSugarLevel() > middleAgent.getSugarLevel() && middleAgent.getTribe() != temp2.getAgent().getTribe()){
            removeThisOne = true;
            break;
          }
        }
        if(removeThisOne){
          si2.remove();
        }
      }
    }
    
    //replaces agent squares with empty squares containing that agent's sugar
    LinkedList<Square> originalSquares = new LinkedList<Square>();
    for(int k = 0; k < neighbourhood.size(); k++){
      Square temp3 = neighbourhood.get(k);
      Agent y = temp3.getAgent();
      if(y != null){
        originalSquares.add(temp3);
        neighbourhood.set(k, new Square(alpha + y.getSugarLevel() + temp3.getSugar(), alpha + y.getSugarLevel() + temp3.getSugar(), temp3.getX(), temp3.getY()));
      }
    }
    
    Square target = super.move(neighbourhood, g, middle);
    
    //relates target back to the originalSquares list
    for(Square temp4 : originalSquares){
      if(temp4.getX() == target.getX() && temp4.getY() == target.getY()){
        target = temp4;
        break;
      }
    }
    
    if(target.getAgent() != null){
      Agent casualty = target.getAgent();
      target.setAgent(null);
      //increase middleAgent's sugar level by alpha + casualty's sugarLevel
      middleAgent.eat(new Square(alpha + casualty.getSugarLevel(), alpha + casualty.getSugarLevel(), 0, 0));
      g.killAgent(casualty); //killAgent does nothing as of now
    }
    
    return target;
    
  }
  
}