class Square{
  
  Agent occupied;
  private int sugar, maxSugar, x, y, pollution;

  public Square(int sugar, int maxSugar, int x, int y){
    this.sugar = sugar;
    this.maxSugar = maxSugar;
    this.x = x;
    this.y = y;
    this.pollution = 0;
  }
  
  public int getSugar(){
    return this.sugar;
  }
  
  public int getMaxSugar(){
    return this.maxSugar;
  }
  
  public int getX(){
    return this.x;
  }
  
  public int getY(){
    return this.y;
  }
  
  public int getPollution(){
    return this.pollution;
  }
  
  public Agent getAgent(){
    return occupied;
  }
  
  public void setSugar(int s){
    if(s < 0){
      this.sugar = 0;
    }
    else if(s > this.maxSugar){
      this.sugar = this.maxSugar;
    }
    else{
      this.sugar = s;
    }
  }
  
  public void setMaxSugar(int m){
    if(m < 0){
      this.maxSugar = 0;
    }
    else{
      this.maxSugar = m;
    }
    if(this.sugar > this.maxSugar){
      this.sugar = this.maxSugar;
    }
  }
  
  public void setAgent(Agent a){
    if(this.occupied != null && !this.occupied.equals(a) && a != null){
      assert (false);
    }
    this.occupied = a;
  }
  
  public void setPollution(int level){ 
    this.pollution = level;
  }
  
  public void display(int size){
    stroke(255);
    strokeWeight(4);
    //fill(255, 255 - pollution/6.0*255, 255 - sugar/6.0*255);
    fill(255, 255, 255 - sugar/6.0*255);
    rect(x*size, y*size, size, size);
    
    if(occupied != null){
      occupied.display(x, y, size, f);
    }
  }
  
}