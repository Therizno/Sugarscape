import java.util.LinkedList;

class SugarGrid{
  
  Square[][] grid;
  private int sideLength;
  private int w;
  private int h;
  GrowbackRule regen;

  public SugarGrid(int w, int h, int sideLength, GrowbackRule g){
    this.sideLength = sideLength;
    this.regen = g;
    this.w = w;
    this.h = h;
    //h and i are y
    //w and j are x
    grid = new Square[h][w];
    for(int i = 0; i < h; i++){
      for(int j = 0; j < w; j++){
        grid[i][j] = new Square(0, 0, j, i);
      }
    }
  }
  
  public int getWidth(){
    return this.w;
  }
  
  public int getHeight(){
    return this.h;
  }
  
  public int getSquareSize(){
    return sideLength;
  }
  
  public int getSugarAt(int i, int j){
    Square s = this.grid[i][j];
    return s.getSugar();
  }
  
  public int getMaxSugarAt(int i, int j){
    Square s = this.grid[i][j];
    return s.getMaxSugar();
  }
  
  public Agent getAgentAt(int i, int j){
    Square s = this.grid[i][j];
    return s.getAgent();
  }
  
  public void placeAgent(Agent a, int x, int y){
    Square s = this.grid[y][x];
    if(s.getAgent() == null){
      s.setAgent(a);
    }
    else { 
      assert false;
    }
  }
  
  public double euclidianDistance(Square s1, Square s2){
    int x1 = s1.getX();
    int y1 = s1.getY();
    int x2 = s2.getX();
    int y2 = s2.getY();
    
    int tempx = abs(x2 - x1);
    int tempy = abs(y2- y1);
    
    int dx = min(tempx, w - tempx);
    int dy = min(tempy, h - tempy);
    
    return sqrt(pow(dx, 2) + pow(dy, 2));

  }
    

  
  public void addSugarBlob(int x, int y, int radius, int max){
    Square center = grid[y][x];
    if(max > center.getMaxSugar()){
      center.setMaxSugar(max);
      center.setSugar(max);
    }
    else{
      center.setSugar(center.getMaxSugar());
    }
    
    for(int i = 0; i < h; i++){
      for(int j = 0; j < w; j++){
        Square s = grid[i][j];
        double eud = euclidianDistance(center, s);
        if(eud <= radius){
          if(max > s.getMaxSugar()){
            s.setMaxSugar(max - 1);
            s.setSugar(max - 1);
          }
          else{
            s.setSugar(s.getMaxSugar());
          }
          
        }
        else if(eud <= radius*2){
          if(max > s.getMaxSugar()){
            s.setMaxSugar(max - 2);
            s.setSugar(max - 2);
          }
          else{
            s.setSugar(s.getMaxSugar());
          }
        }
      }
    }
  }
  
  public LinkedList<Square> generateVision(int x, int y, int radius){
    LinkedList<Square> l = new LinkedList<Square>();
    l.add(grid[y][x]);
    
    for(int i = 1; i <= radius; i++){
      int a = x + i;
      if(a >= w){
        a = a - w;
      }
      int b = x - i;
      if(b < 0){
      b = b + w;
      }
      int c = y + i;
      if(c >= h){
        c = c - h;
      }
      int d = y - i;
      if(d < 0){
      d = d + h;
      }
    
      l.add(grid[y][a]);
      l.add(grid[y][b]);
      l.add(grid[c][x]);
      l.add(grid[d][x]);
    }

    return l;
  }
  
  public LinkedList<Square> generateVision2(int x, int y, int radius) {
    LinkedList<Square> retval = new LinkedList<Square>();
    
    if (radius < 0) {
      radius = -radius;
    }
    for (int i = -radius; i <= radius; i++) {
      if (y+i >= 0 && y+i < height && x >= 0 && x < width) {
        retval.add(grid[x][y+i]);
      }
      if (x+i >= 0 && x+i < width && i != 0 && y >= 0 && y < height) {
        retval.add(grid[x+i][y]);
      }
    }
    
    return retval;
    
  }
  
  
  
  public void addAgentAtRandom(Agent a){
    int randW = (int)random(w);
    int randH = (int)random(h);
    
    Agent b = getAgentAt(randH, randW);
    
    if(b == null){
      this.placeAgent(a, randW, randH);
    }
    else{
      this.addAgentAtRandom(a);
    }
  }
  
  public void killAgent(Agent a){
    //stub
  }
  
  public ArrayList<Agent> getAgents(){
    ArrayList<Agent> aList = new ArrayList<Agent>();
    for(int i = 0; i < h; i++){
      for(int j = 0; j < w; j++){
        Square s = grid[i][j];
        if(s.getAgent() != null){
          aList.add(s.getAgent());
        }
      }
    }
    //String str = aList.toString();
    //System.out.println(str);
    return aList;
  }
  
  
  public void display(){
    for(int i = 0; i < h; i++){
      for(int j = 0; j < w; j++){
        Square s = grid[i][j];
        //System.out.println(i + ", " + j);
        s.display(sideLength);
      }
    }
  }
  
  public void update(){
    for(int i = 0; i < h; i++){
      for(int j = 0; j < w; j++){
      
        Square s = grid[i][j];
        
        PollutionRule p = new PollutionRule(1, 2);
        p.pollute(s);
        
        regen.growBack(s);
        
        if(s.getAgent() != null){
        
          Agent a = s.getAgent();
          
          LinkedList<Square> see = generateVision(j, i, a.getVision());
          MovementRule m = a.getMovementRule();
          Square moveSquare = m.move(see, this, s);
          
          if(moveSquare.getAgent() == null){
            a.move(s, moveSquare);
            a.step();
          
            if(a.isAlive()){
              a.eat(moveSquare);
            }
            else{
              moveSquare.setAgent(null);
            }
          }
          else{
            
            a.step();
          
            if(a.isAlive()){
              a.eat(s);
            }
            else{
              s.setAgent(null);
            }
          }
          a.influenceArea(s.getX(), s.getY(), this, 1);
        }
      }
    }
  }
}