class PollutionRule{
  
  int gatheringPollution, eatingPollution;

  public PollutionRule(int gatheringPollution, int eatingPollution){
    this.gatheringPollution = gatheringPollution;
    this.eatingPollution = eatingPollution;
  }
  
  public void pollute(Square s){
    if(s.getAgent() != null){
      Agent A = s.getAgent();
      s.setPollution(s.getPollution() + eatingPollution*A.getMetabolism() + s.getSugar()*gatheringPollution);
    }
  }
  
}