abstract class Sorter{

  public abstract void sort(ArrayList<Agent> al);
  
  public boolean lessThan(Agent a, Agent b){
    if(a.getSugarLevel() < b.getSugarLevel()){
      return true;
    }
    return false;
  }
}

class BubbleSorter extends Sorter{

  public BubbleSorter(){}
  
  public void sort(ArrayList<Agent> al){ 
    
    for(int i = 0; i < al.size() - 1; i++){
      for(int j = 0; j < al.size() - 1 - i; j++){
        Agent b = al.get(j);
        Agent a = al.get(j + 1);
        if(lessThan(a, b)){
          al.set(j, a);
          al.set(j + 1, b);
        }
      }
    }
  }
}

class InsertionSorter extends Sorter{

  public InsertionSorter(){}
  
  public void sort(ArrayList<Agent> al){
    
    for(int i = 1; i < al.size(); i++){
      Agent a = al.get(i);
      
      for(int j = i - 1; j >=0; j--){
        Agent b = al.get(j);
        
        if(lessThan(a, b)){
          al.add(j, al.remove(al.indexOf(a)));
        }
      }
    }
  }
}


class MergeSorter extends Sorter{

  public MergeSorter(){}
  
  public void sort(ArrayList<Agent> al){
    ArrayList<Agent> al1 = new ArrayList<Agent>();
    ArrayList<Agent> al2 = new ArrayList<Agent>();
    
    if(al.size() > 1){
      
      for(int i = 0; i < al.size()/2; i++){
        al1.add(al.get(i));
      }
      for(int j = al.size()/2; j < al.size(); j++){
        al2.add(al.get(j));
      }
      sort(al1);
      sort(al2);
      al = merger(al1, al2);
    }
  }

  private ArrayList<Agent> merger(ArrayList<Agent> a, ArrayList<Agent> b){
    ArrayList<Agent> alist = new ArrayList<Agent>();
    int i = 0;
    int j = 0;
    
    while(i < a.size() || j < b.size()){
      
    print("[");
    for(Agent temp : alist){
      print(temp.getSugarLevel() + " ");
    }
    println("] ");
      
      if(i >= a.size()){
        for(int n = 0; n < b.size(); n++){
          alist.add(b.get(n));
        }
        println("done with list A");
        j = b.size();
      }
      
      else if(j >= b.size()){
        for(int m = 0; m < a.size(); m++){
          alist.add(a.get(m));
        }
        println("done with list B");
        i = a.size();
      }
      
      else if(lessThan(a.get(i), b.get(j))){
        alist.add(a.get(i));
        i++;
      }
      else{
        alist.add(b.get(j));
        j++;
      }
    }
    println(".....");
    print("[");
    for(Agent temp : alist){
      print(temp.getSugarLevel() + " ");
    }
    println("] ");
    println(" ");
    
    //assert(!alist.isEmpty());
    return alist;
  }
}


class QuickSorter extends Sorter{

  public QuickSorter(){}
  
  public void sort(ArrayList<Agent> al){
    Collections.shuffle(al);
    int index = (int)random(al.size());
    Agent a = al.get(index);
    
    for(int o = 0; o < al.size(); o++){
      Agent temp = al.get(o);
      al.remove(temp);
      if(lessThan(temp, a)){
        al.add(al.indexOf(a), temp);
      }
      else{
        al.add(al.indexOf(a) + 1, temp);
      }
    }
    
    ArrayList<Agent> al1 = new ArrayList<Agent>();
    ArrayList<Agent> al2 = new ArrayList<Agent>();
    for(int i = 0; i < al.indexOf(a); i++){
      al1.add(al.get(i));
    }
    for(int j = al.indexOf(a) + 1; j < al.size(); j++){
      al2.add(al.get(j));
    }
    if(al1.size() > 1){
      sort(al1);
    }
    if(al2.size() > 1){
      sort(al2);
    }
    
    al = al1;
    al1.add(a);
    for(int l = 0; l < al2.size(); l++){
      al.add(al2.get(l));
    }
  }
}