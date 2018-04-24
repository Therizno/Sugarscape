import java.util.LinkedList;
class SocialNetwork{
  LinkedList<SocialNetworkNode>[] adj;
  SocialNetworkNode[] owner;
  
  public SocialNetwork(SugarGrid g){
    
    if(g != null){
      this.adj = new LinkedList[g.getWidth() * g.getHeight()];
    
      int k = 0;
      for(int i = 0; i < g.getHeight(); i++) {
        for(int j = 0; j < g.getWidth(); j++) {
        
          if(g.getAgentAt(i, j) != null){
            adj[k] = new LinkedList<SocialNetworkNode>();
            SocialNetworkNode m = new SocialNetworkNode(g.getAgentAt(i, j));
            adj[k].add(m);
            for(Square s : g.generateVision(i, j, g.getAgentAt(i, j).getVision())){
              if(s.getAgent() != null){
                SocialNetworkNode n = new SocialNetworkNode(s.getAgent());
                adj[k].add(n);
              }
            }
          }
          k++;
        }
      }
    }
  }
  
  public boolean adjacent(SocialNetworkNode x, SocialNetworkNode y){
    
    //go through list of social network nodes
    for(int l = 0; l < adj.length; l++){
   
      //if any network's list's first node == x
      if(adj[l] != null && adj[l].get(0).equals(x)){

        //go through all of those nodes on that list
        for(int t = 0; t < adj[l].size(); t++){
          //and if that node == y
          if(adj[l].get(t).getAgent().equals(y.getAgent())){
            return true;
          }
        }
      }
    }
    return false;
  }
  
  public List<SocialNetworkNode> sees(SocialNetworkNode y){
    LinkedList<SocialNetworkNode> newList = new LinkedList<SocialNetworkNode>();
    for(int i = 0; i < this.adj.length; i++){
      if(adj[i] != null && adj[i].get(0).equals(y)){
        for(int j = 1; j < adj[i].size(); j++){
          newList.add(adj[i].get(j));
        }
      }
    }
    if(newList.size() > 0){
      return newList;
    }
    return null;
  }
  
  public List<SocialNetworkNode>seenBy(SocialNetworkNode x){
    LinkedList<SocialNetworkNode> seen = new LinkedList<SocialNetworkNode>();
    for(int i = 0; i < this.adj.length; i++){
      if(adj[i] != null){
        for(int j = 1; j < adj[i].size(); j++){
          SocialNetworkNode temp = adj[i].get(j);
          if(temp.getAgent().equals(x.getAgent())){
            seen.add(adj[i].get(j));
          }
        }
      }
    }
    if(seen.size() > 0){
      return seen;
    }
    return null;
  }
  
  public void resetPaint(){
    for(int i = 0; i < adj.length; i++){
      for(int j = 0; j < adj[i].size(); j++){
        adj[i].get(j).unpaint();
      }
    }
  }
  
  public SocialNetworkNode getNode(Agent a){
    for(int i = 0; i < adj.length; i++){
      if (adj[i].get(0).getAgent().equals(a)){
        return adj[i].get(0);
      }
    }
    return null;
  }
  
  public boolean pathExists(Agent x, Agent y){
    List viz = sees(getNode(x));
    for(int i = 0; i < viz.size(); i++){
      //if(!viz.get(i).painted()){
        
      //}
    }
    return false;
  }
  
  public List<Agent> bacon(Agent x, Agent y){
    LinkedList<SocialNetworkNode> breadthSearch = new LinkedList<SocialNetworkNode>();
    
    SocialNetworkNode begin = getNode(x);
    breadthSearch.addFirst(begin);
    
    int depth = 0;
    while(breadthSearch.size() > 0){   
      print(breadthSearch.size() + " ");
      
      for(SocialNetworkNode temp : breadthSearch){
        println("Q: " + temp.getAgent().getSugarLevel());
      }
      
      
      SocialNetworkNode currNode = breadthSearch.removeLast();
      println("painted: " + currNode.painted());
      currNode.setDepth(depth);
      currNode.paint();
      println(currNode.getDepth());
      println("painted: " + currNode.painted());
      
      println(currNode.getAgent().getSugarLevel());
      println(y.getSugarLevel());
      
      if(currNode.getAgent().equals(y)){
        println("found y");
        return backTrack(currNode);
      }
      
      List<SocialNetworkNode> view = sees(currNode);
      if(view != null){
        for(int i = 0; i < view.size(); i++){
          println("seen painted: " + view.get(i).painted());
          if(!view.get(i).painted()){
            breadthSearch.addFirst(view.get(i));
          }
        }
        println("");
      }
      else{
      println("end.");
      }
      
      depth++;
    }
    
    return null;
  }
  
  private List<Agent> backTrack(SocialNetworkNode s){
    LinkedList<Agent> path = new LinkedList<Agent>();
    List<SocialNetworkNode> view = seenBy(s);
    
    assert(s.getDepth() > -1);
    
    if(s.getDepth() == 0){
      path.addFirst(s.getAgent());
      return path;
    }
    else if(view != null){
      
      for(int i = 0; i < view.size(); i++){
        if(view.get(i).getDepth() > -1){
          List<Agent> pathFrom = backTrack(view.get(i));
          
          //null pathFrom means dead end
          if(pathFrom != null){
            for(int j = 0; j < pathFrom.size(); j++){
              path.addFirst(pathFrom.get(j));
            }
          } 
        }
      }
    }
    if(path.size() == 0){
      return path;
    }
    return null;
  }
  
}
    
  

  