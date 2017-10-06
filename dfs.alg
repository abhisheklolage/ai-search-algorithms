/**
 * Implements depth-first search of a graph, directed or undirected; in the
 * undirected case, it behaves as if edges were directed in both directions.
 */

int time;
int [] discovery;
int [] finish;
int done = 0;
function visit(Node v, Node parent) {
     if(label(v).equals("target")) {
            display("found the target node");
            color(v, GREEN);
            done = 1;
        }
     if (done == 1) {
          return;
    }
    time = time + 1;
    discovery[id(v)] = time;
    beginStep();
    label(v, discovery[id(v)]);
    mark(v);
    endStep();
    for_outgoing( v, e, w ) {
         if (done == 1) {
	return;
       }
        // the following 'exemption' ensures that the classification of an
        // edge is based on its first encounter only
        if ( ! isDirected() &&
             ( w == parent
               || hasLabel(e) ))
            continue;
        beginStep();
        if (done == 1) {
	return;
       }
        if ( ! marked(w)) {
             if (done == 1) {
	return;
            }
             highlight(e);
             if(!label(w).equals("target")) {
            
            highlight(w);
            }
            visit(w, v);
        }
        else if ( finish[id(w)] == 0 ) { /* ancestor */
            label(e, "B");
        }
        else if ( finish[id(w)]
                  > discovery[id(v)] ) { /* descendant */
            label(e, "F");
        }
        else {
            label(e, "C");
        }
        endStep();
    }
    time = time + 1;
    finish[id(v)] = time;
    setLabel(v, discovery[id(v)] + "/" + finish[id(v)]);
}

algorithm {
  showNodeLabels();
  showEdgeLabels();

  discovery = new int[nodeIds()];
  finish = new int[nodeIds()];
  time = 0;
 
  beginStep();
  clearNodeLabels();
  clearEdgeLabels();
  endStep();
  Node target_node = getNode("Enter the target Node id");
  label(target_node, "target");
  color(target_node, TEAL);
  for_nodes( u ) {
      
    if ( ! marked(u) && done == 0) {
	visit(u, null);
        }
}

//  [Last modified: 2017 01 23 at 22:38:28 GMT]
