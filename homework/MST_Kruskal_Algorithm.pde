
ArrayList<Node> nodes = new ArrayList<Node>();
ArrayList<Edge> edges = new ArrayList<Edge>();
ArrayList<Edge> mst = new ArrayList<Edge>();
ArrayList<Edge> rejected = new ArrayList<Edge>();

int[] parent;
int[] rank;

int currentEdge = -1;
int totalWeight = 0;
int acceptedCount = 0;

boolean finished = false;

String message = "Press NEXT STEP to start.";

// --------------------------------------------------
// SETUP
// --------------------------------------------------

void setup() {
  size(900, 650);

  generateRandomMap();
}

void draw() {
  background(245);

  drawGraph();
  drawInterface();
}

// --------------------------------------------------
// RANDOM GRAPH GENERATION
// --------------------------------------------------

void generateRandomMap() {

  nodes.clear();
  edges.clear();
  mst.clear();
  rejected.clear();

  // Random number of vertices: 5 to 8
  int vertexCount = (int)random(5, 9);

  // Position vertices in a circle
  float centerX = 425;
  float centerY = 260;
  float radius = 190;

  for (int i = 0; i < vertexCount; i++) {

    float angle = TWO_PI * i / vertexCount - HALF_PI;

    float x = centerX + cos(angle) * radius;
    float y = centerY + sin(angle) * radius;

    String name = Character.toString((char)('A' + i));

    nodes.add(new Node(x, y, name));
  }

  // Track existing edges to avoid duplicates
  boolean[][] connected = new boolean[vertexCount][vertexCount];

  // First, create a connected graph.
  // Each new vertex connects to one existing vertex.
  // This guarantees that the graph is connected.

  for (int i = 1; i < vertexCount; i++) {

    int previous = (int)random(0, i);

    addEdge(i, previous, connected);
  }

  // Add extra random edges
  // This makes the graph more interesting.

  int maxEdges = vertexCount * (vertexCount - 1) / 2;

  int extraEdges = (int)random(1, vertexCount + 1);

  for (int i = 0; i < extraEdges; i++) {

    int a = (int)random(vertexCount);
    int b = (int)random(vertexCount);

    if (a != b && !connected[a][b]) {
      addEdge(a, b, connected);
    }
  }

  // Sort edges by ascending weight
  sortEdges();

  // Initialize Kruskal's Algorithm
  resetAlgorithm();

}

// Add an edge with a random weight
void addEdge(int a, int b, boolean[][] connected) {

  int weight = (int)random(1, 21);

  edges.add(new Edge(a, b, weight));

  connected[a][b] = true;
  connected[b][a] = true;
}

// --------------------------------------------------
// SORT EDGES
// --------------------------------------------------

void sortEdges() {

  // Bubble Sort: smallest weight first

  for (int i = 0; i < edges.size() - 1; i++) {

    for (int j = 0; j < edges.size() - i - 1; j++) {

      if (edges.get(j).weight > edges.get(j + 1).weight) {

        Edge temp = edges.get(j);

        edges.set(j, edges.get(j + 1));

        edges.set(j + 1, temp);
      }
    }
  }
}

// --------------------------------------------------
// UNION-FIND
// --------------------------------------------------

void resetAlgorithm() {

  int n = nodes.size();

  parent = new int[n];
  rank = new int[n];

  for (int i = 0; i < n; i++) {
    parent[i] = i;
    rank[i] = 0;
  }

  mst.clear();
  rejected.clear();

  currentEdge = -1;
  totalWeight = 0;
  acceptedCount = 0;

  finished = false;

  message = "Press NEXT STEP to start.";
}

// Find the root of a vertex
int find(int x) {

  if (parent[x] != x) {
    parent[x] = find(parent[x]);
  }

  return parent[x];
}

// Combine two sets
void unionSets(int x, int y) {

  int rootX = find(x);
  int rootY = find(y);

  if (rank[rootX] < rank[rootY]) {

    parent[rootX] = rootY;

  } else if (rank[rootX] > rank[rootY]) {

    parent[rootY] = rootX;

  } else {

    parent[rootY] = rootX;
    rank[rootX]++;
  }
}

// --------------------------------------------------
// KRUSKAL'S ALGORITHM
// --------------------------------------------------

void nextStep() {

  if (finished) return;

  if (acceptedCount == nodes.size() - 1) {

    finished = true;
    message = "MST completed!";
    return;
  }

  currentEdge++;

  if (currentEdge >= edges.size()) {

    finished = true;
    message = "No more edges available.";
    return;
  }

  Edge e = edges.get(currentEdge);

  int rootA = find(e.from);
  int rootB = find(e.to);

  // Check whether adding this edge creates a cycle

  if (rootA != rootB) {

    unionSets(rootA, rootB);

    mst.add(e);

    totalWeight += e.weight;

    acceptedCount++;

    message = "SELECTED: " +
      nodes.get(e.from).name + " - " +
      nodes.get(e.to).name +
      " | Weight: " + e.weight;

  } else {

    rejected.add(e);

    message = "REJECTED: " +
      nodes.get(e.from).name + " - " +
      nodes.get(e.to).name +
      " | Cycle detected!";
  }

  if (acceptedCount == nodes.size() - 1) {

    finished = true;

    message += " | MST completed!";
  }
}

// --------------------------------------------------
// DRAW GRAPH
// --------------------------------------------------

void drawGraph() {

  // Draw all edges
  for (int i = 0; i < edges.size(); i++) {

    Edge e = edges.get(i);

    Node a = nodes.get(e.from);
    Node b = nodes.get(e.to);

    strokeWeight(2);
    stroke(190);

    // Rejected edges: RED
    if (rejected.contains(e)) {

      stroke(220, 60, 60);
      strokeWeight(3);
    }

    // Selected MST edges: GREEN
    if (mst.contains(e)) {

      stroke(30, 160, 80);
      strokeWeight(5);
    }

    // Current edge: YELLOW
    if (i == currentEdge && !mst.contains(e)
        && !rejected.contains(e)) {

      stroke(240, 170, 20);
      strokeWeight(5);
    }

    line(a.x, a.y, b.x, b.y);

    // Draw edge weight
    float mx = (a.x + b.x) / 2;
    float my = (a.y + b.y) / 2;

    fill(255);
    noStroke();
    ellipse(mx, my, 30, 26);

    fill(20);
    textAlign(CENTER, CENTER);
    textSize(15);
    text(e.weight, mx, my);
  }

  // Draw vertices
  for (Node n : nodes) {

    fill(70, 120, 210);

    stroke(30);
    strokeWeight(2);

    ellipse(n.x, n.y, 45, 45);

    fill(255);
    textAlign(CENTER, CENTER);
    textSize(18);

    text(n.name, n.x, n.y);
  }
}

// --------------------------------------------------
// INTERFACE
// --------------------------------------------------

void drawInterface() {

  fill(30);
  textAlign(LEFT);
  textSize(25);

  text("Kruskal's Algorithm - MST", 30, 35);

  textSize(14);

  // Graph information
  text("Vertices: " + nodes.size(), 30, 475);
  text("Total Edges: " + edges.size(), 30, 495);

  text("Processed Edges: " +
    (currentEdge + 1) + " / " + edges.size(), 30, 515);

  text("MST Edges: " + acceptedCount +
    " / " + (nodes.size() - 1), 30, 535);

  text("Total MST Weight: " + totalWeight, 30, 560);

  // Current status
  textSize(15);

  if (finished) {
    fill(30, 150, 80);
  } else {
    fill(30);
  }

  text(message, 30, 590);

  // Legend
  fill(30, 160, 80);
  text("GREEN: Selected MST edge", 650, 35);

  fill(220, 60, 60);
  text("RED: Rejected edge", 650, 55);

  fill(240, 170, 20);
  text("YELLOW: Current edge", 650, 75);

  // NEXT STEP button
  drawButton(680, 470, 190, 40,
    "NEXT STEP", color(50, 130, 90));

  // NEW RANDOM MAP button
  drawButton(680, 520, 190, 40,
    "NEW RANDOM MAP", color(70, 110, 190));

  // RESET button
  drawButton(680, 570, 190, 40,
    "RESET", color(100, 100, 110));
}

void drawButton(float x, float y,
  float w, float h, String label, int c) {

  fill(c);
  noStroke();

  rect(x, y, w, h, 8);

  fill(255);
  textAlign(CENTER, CENTER);
  textSize(15);

  text(label, x + w/2, y + h/2);
}

// --------------------------------------------------
// MOUSE INTERACTION
// --------------------------------------------------

void mousePressed() {

  // NEXT STEP
  if (mouseX >= 680 && mouseX <= 870 &&
      mouseY >= 470 && mouseY <= 510) {

    nextStep();
  }

  // NEW RANDOM MAP
  if (mouseX >= 680 && mouseX <= 870 &&
      mouseY >= 520 && mouseY <= 560) {

    generateRandomMap();
  }

  // RESET
  if (mouseX >= 680 && mouseX <= 870 &&
      mouseY >= 570 && mouseY <= 610) {

    resetAlgorithm();
  }
}

// --------------------------------------------------
// CLASSES
// --------------------------------------------------

class Node {

  float x, y;
  String name;

  Node(float x, float y, String name) {

    this.x = x;
    this.y = y;
    this.name = name;
  }
}

class Edge {

  int from, to, weight;

  Edge(int from, int to, int weight) {

    this.from = from;
    this.to = to;
    this.weight = weight;
  }
}
