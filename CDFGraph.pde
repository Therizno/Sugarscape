abstract class CDFGraph extends Graph{
  int numUpdates;

  public CDFGraph(int x, int y, int howWide, int howTall, String xlab, String ylab){
    super(x, y, howWide, howTall, xlab, ylab);
    numUpdates = 0;
  }
  
  public abstract void reset(SugarGrid g);
  
  public abstract int nextPoint(SugarGrid g);
  
  public abstract int getTotalCalls(SugarGrid g);
  
  public void update(SugarGrid g){
    numUpdates = 0;
    super.update(g);
    reset(g);
    
    int numPerCell = super.howWide/getTotalCalls(g);
    
    while(numUpdates < getTotalCalls(g)){
      stroke(0);
      rect(numUpdates, nextPoint(g), numPerCell, 1);
    }
  }
}


class WealthCDFGraph extends CDFGraph{

  public WealthCDFGraph(int x, int y, int howWide, int howTall, String xlab, String ylab){
    super(x, y, howWide, howTall, xlab, ylab);
  }
  
  public void reset(SugarGrid g){}
  
  public int nextPoint(SugarGrid g){
    return 0;
  }
  
  public int getTotalCalls(SugarGrid g){
    return 0;
  }
  
}