GrowbackRule law;
SugarGrid grid;
Graph graph;
Graph graph2;
Graph graph3;
Graph graph4;
FertilityRule f;

char k = 'c';

ArrayList<Agent> agentList;

MovementRule move0 = new SugarSeekingMovementRule();
MovementRule move = new PollutionMovementRule();

AgentFactory z = new AgentFactory(1, 4, 1, 6, 50, 100, move0);
//60, 100
ReplacementRule r = new ReplacementRule(180, 300, z);

void setup(){
  size(800, 500);
  frameRate(20);
  
  graph = new AvSugarGraph(520, 120, 150, 100, "Time", "Average Sugar Possesd");
  graph2 = new NumAgentGraph(520, 0, 150, 100, "Time", "Agents");
  graph3 = new AvAgeGraph(520, 250, 150, 100, "Time", "Average Agent Age");
  graph4 = new CultureGraph(520, 383, 150, 100, "Time", "Number of True Agents");
  
  law = new GrowbackRule(1);

  grid = new SugarGrid(40, 40, 10, law);
  
  HashMap<Character, Integer[]> childBegin = new HashMap<Character, Integer[]>();
  HashMap<Character, Integer[]> childEnd = new HashMap<Character, Integer[]>();
  
  //12, 15
  Integer[] begin = {0, 0};
  childBegin.put('X', begin);
  childBegin.put('Y', begin);
  
  //40, 50
  Integer[] endF = {120, 150};
  //50, 60
  Integer[] endM = {150, 180};
  
  childEnd.put('X', endF);
  childEnd.put('Y', endM);
  
  f = new FertilityRule(childBegin, childEnd);
  
  grid.addSugarBlob(15, 15, 5, 5);
  grid.addSugarBlob(30, 30, 5, 5);
  
  //the way agents are added initially causes some instability in the population size
  for(int i = 0; i < 400; i++){
    grid.addAgentAtRandom(z.makeAgent());
  }

  println("push f to display fertility or push c to display culture");
  
}

void draw(){
  
  grid.display();
  grid.update();
  
  graph2.update(grid);
  graph.update(grid);
  graph3.update(grid);
  graph4.update(grid);
  
  r.replaceGrid(grid);
  f.breedAllAgents(grid);
  
  //c displays culture, f displays fertility
  if(keyPressed){
    if(key != 0){
      k = key;
    }
    key = 0;
  }
  
}