/** 
 * Implementation of breadth-first search. If the graph is undirected, the
 * edges are regarded as being directed both ways.
 */

NodeQueue queue;

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
        highlight(e);
        if(other.equals(target_node)) {
            color(other, GREEN);
            return;
        }
        highlight(other);
        Double distance = weight(next) + 1;
        setWeight(other, distance);
        put(other, queue);
        endStep();
      }
    }
  }
}

//  [Last modified: 2017 01 18 at 13:20:47 GMT]
