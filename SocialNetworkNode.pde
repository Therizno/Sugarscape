class SocialNetworkNode{
  private boolean painted;
  private int depthFrom;
  private Agent a;
  
  public SocialNetworkNode(Agent a){
    this.a = a;
    this.painted = false;
    this.depthFrom = -1;
  }
  
  public boolean painted(){
    return this.painted;
  }
  
  public void paint(){
    this.painted = true;
  }
  
  public void unpaint(){
    this.painted = false;
  }
  
  public Agent getAgent(){
    return this.a;
  }
  
  public void setDepth(int d){
    this.depthFrom = d;
  }
  
  public int getDepth(){
    return this.depthFrom;
  }
}