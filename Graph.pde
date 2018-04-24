class Graph{
  
  int x, y, howWide, howTall; 
  String xlab, ylab;

  public Graph(int x, int y, int howWide, int howTall, String xlab, String ylab){
    this.x = x;
    this.y = y;
    this.howWide = howWide;
    this.howTall = howTall;
    this.xlab = xlab;
    this.ylab = ylab;
  }
  
  public void update(SugarGrid g){
  
    fill(255);
    noStroke();
    rect(this.x, this.y, this.howWide, this.howTall);
    
    stroke(0);
    strokeWeight(1);
    line(this.x, this.y + this.howTall, this.x + this.howWide, this.y + this.howTall);
    line(this.x, this.y, this.x, this.y + this.howTall);
    
    fill(0);
    textAlign(CENTER, TOP);
    text(this.xlab, this.x + this.howWide/2, this.y + this.howTall);
    
    textAlign(CENTER, BOTTOM);
    pushMatrix();
    translate(this.x - 3, this.y + this.howTall/2);
    rotate(-PI/2.0);
    text(ylab, 0, 0 );
    popMatrix();
  }
  
}