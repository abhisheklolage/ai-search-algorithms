double [] heuristic_astar;
Node t;

function double euclidian(Node v, Node w) {
    return getPosition(v).distance(getPosition(w));
}

function init_edge_costs() {
  for_edges(edge) {
    if ( ! hasWeight(edge) ) {
      double distance = euclidian(source(edge), target(edge));
      setWeight(edge, distance);
    }
  }
}

function init_heuristic_costs() {
  heuristic_astar = new double[nodeIds()];
  for_nodes(node) {
       if(id(node) == 3) {
       	heuristic_astar[id(node)] = 50;
      }
       else {
	heuristic_astar[id(node)] = euclidian(node, t) / 100;
       }
       
  }
}

algorithm {
  showNodeWeights();
  showEdgeWeights();
  NodePriorityQueue pq = new NodePriorityQueue();
  Edge [] chosenEdge = new Edge[nodeIds()];
  beginStep();
  init_edge_costs();
  for_nodes(node) {
    setWeight(node, INFINITY);
    insert(node, pq);
  }

  Node s = getNode("Start vertex?");
  setWeight(s, 0);
  changeKey(s, pq);
  color(s, BLUE);
  endStep();

  t= getNode("Target vertex?");
  color(t, TEAL);
  endStep();

  init_heuristic_costs();

  //System.out.println(Arrays.toString(heuristic_astar));
  display(Arrays.toString(heuristic_astar));
  while ( ! empty(pq) ) {
    Node v = removeBest(pq);
    mark(v);        // nodes are marked when visited
    unhighlight(v); // and highlighted when on the frontier
    if(!v.equals(s)) {
	double v_weight = weight(v);
	v_weight = v_weight - heuristic_astar[id(v)];
    	setWeight(v, v_weight);
    }
    if(v.equals(t)) {
        color(t, GREEN);
        return;
    }
    
    for_outgoing ( v, e, w ) {
      if ( ! marked(w) )  {
        if ( ! highlighted(w) ) highlight(w);
        double distance = weight(v) + weight(e) + heuristic_astar[id(w)];
        if ( distance < weight(w) ) {
          beginStep();
          highlight(e);
          Edge previous_chosen = chosenEdge[id(w)];
          if (previous_chosen != null )
            unhighlight(previous_chosen);
          //distance = weight(v) + weight(e);
          setWeight(w, distance);
          changeKey(w, pq);
          chosenEdge[id(w)] = e;
          endStep();
        }
      } // end, neighbor not visited (not in tree); do nothing if node
      // is already in tree
    } // end, adjacency list traversal
  } // stop when priority queue is empty
} // end, algorithm

//  [Last modified: 2017 04 18 at 19:25:58 GMT]
