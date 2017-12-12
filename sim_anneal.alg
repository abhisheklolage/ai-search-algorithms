import java.util.Calendar;
import java.util.Date;
import java.time.ZonedDateTime;

NodeQueue queue;

 int k = 1;
double INFINITY = Double.POSITIVE_INFINITY;
double  temperature = INFINITY;
function double acceptanceProbability(Node node, Node next, Node end) {
  // If the new solution is better, accept it
  if (temperature == INFINITY) {
    temperature = euclidian(getStartNode(), end);
  }
  temperature = temperature/2;
  if (euclidian(next, end) < euclidian(node, end)) {
    return 1.0;
  }
  // If the new solution is worse, calculate an acceptance probability
  return Math.exp((euclidian(node, end) - euclidian(next, end)) / temperature);
}
function double euclidian(Node v, Node w) {
    return getPosition(v).distance(getPosition(w));
}

algorithm {
  showNodeWeights();
  queue = new NodeQueue();
  beginStep();
  for_nodes( v ) {
    setWeight(v, INFINITY);
  }

  Node start = getStartNode();
  Node target_node = getNode("Enter the target Node id");
  label(target_node, "target");
  color(target_node, TEAL);

  Random generator = new Random(0);
  double random;
  setWeight(start, 0);
  
  put(start, queue);
  endStep();
  String label_read;
  while ( ! empty(queue) ) {
    Node next = get(queue);
    if(next.equals(target_node)) {
        color(next, GREEN);
        return;
    }

    highlight(start);
    highlight(next); 

    for_outgoing( next, e, other ) {
      if ( ! highlighted(other) ) { 
        beginStep();
        
        random = generator.nextDouble();
        color(other, YELLOW);
        highlight(other);
        if (acceptanceProbability(next, other, target_node) > random) {
           highlight(e);
           
           if(other.equals(target_node)) {
             color(other, GREEN);
             return;
           }
           highlight(other);
           Double distance = weight(next) + 1;
           setWeight(other, distance);
           put(other, queue);
        }
        endStep();
      }
    }
  }
}

//  [Last modified: 2017 01 18 at 13:20:47 GMT]
