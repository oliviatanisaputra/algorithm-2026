
import java.util.*;

// =====================================
// BFS & DFS GRAPH TRAVERSAL
// =====================================

// Number of vertices
final int V = 8;

// Pastel color palette
color bgColor = color(235, 245, 250);       
color pinkColor = color(255, 205, 215);    
color blueColor = color(140, 190, 230);    
color darkColor = color(70, 85, 110);      
color visitedColor = color(196, 220, 245); 
color whiteColor = color(255);
color edgeColor = color(190, 190, 210);
color currentColor = color(255, 210, 220);

// Graph representation
ArrayList<Integer>[] graph;

PVector[] nodes;

boolean[] visited;
ArrayList<Integer> traversal = new ArrayList<Integer>();

int stepIndex = 0;
int currentNode = -1;

String algorithm = "NONE";

boolean running = false;
boolean finished = false;

int lastStepTime = 0;
int stepDelay = 800;

// Buttons
int bfsX = 40;
int dfsX = 160;
int resetX = 280;
int buttonY = 90;


// =====================================
// SETUP
// =====================================

void setup() {
  size(900, 700);

  textAlign(CENTER, CENTER);

  initializeGraph();
  initializeNodes();
  resetTraversal();
}


// =====================================
// DRAW
// =====================================

void draw() {
  background(bgColor);

  // Title
  fill(darkColor);
  textSize(28);
  text("BFS & DFS Graph Traversal", width/2, 40);

  fill(130, 130, 150);
  textSize(13);
  text("Explore graph traversal step by step", width/2, 65);

  // Buttons
  drawButton(bfsX, buttonY, "BFS");
  drawButton(dfsX, buttonY, "DFS");
  drawButton(resetX, buttonY, "RESET");

  // Graph
  drawEdges();
  drawNodes();

  // Information
  drawInformation();

  // Animation
  if (running && millis() - lastStepTime >= stepDelay) {

    if (stepIndex < traversal.size()) {

      currentNode = traversal.get(stepIndex);
      visited[currentNode] = true;

      stepIndex++;
      lastStepTime = millis();
    }

    if (stepIndex >= traversal.size()) {
      running = false;
      finished = true;
    }
  }
}


// =====================================
// INITIALIZE GRAPH
// =====================================

void initializeGraph() {

  graph = (ArrayList<Integer>[]) new ArrayList[V];

  for (int i = 0; i < V; i++) {
    graph[i] = new ArrayList<Integer>();
  }

  // Undirected graph connections
  addEdge(0, 1);
  addEdge(0, 2);

  addEdge(1, 2);
  addEdge(1, 3);

  addEdge(2, 3);
  addEdge(2, 4);

  addEdge(3, 4);
  addEdge(3, 5);

  addEdge(4, 5);
  addEdge(4, 6);

  addEdge(5, 7);
  addEdge(5, 6);

  addEdge(6, 7);
}

void addEdge(int u, int v) {
  graph[u].add(v);
  graph[v].add(u);
}


// =====================================
// NODE POSITIONS
// =====================================

void initializeNodes() {

  nodes = new PVector[V];

  nodes[0] = new PVector(450, 210);
  nodes[1] = new PVector(250, 300);
  nodes[2] = new PVector(650, 300);
  nodes[3] = new PVector(170, 470);
  nodes[4] = new PVector(450, 410);
  nodes[5] = new PVector(730, 470);
  nodes[6] = new PVector(350, 570);
  nodes[7] = new PVector(600, 570);
}


// =====================================
// DRAW EDGES
// =====================================

void drawEdges() {

  stroke(edgeColor);
  strokeWeight(3);

  for (int i = 0; i < V; i++) {

    for (int j : graph[i]) {

      // Draw each edge only once
      if (i < j) {

        line(
          nodes[i].x, nodes[i].y,
          nodes[j].x, nodes[j].y
        );
      }
    }
  }
}


// =====================================
// DRAW NODES
// =====================================

void drawNodes() {

  for (int i = 0; i < V; i++) {

    // Default color
    fill(whiteColor);

    // Visited nodes
    if (visited[i]) {

      if (algorithm.equals("BFS")) {
        fill(pinkColor);
      } else {
        fill(blueColor);
      }
    }

    // Current node
    if (i == currentNode) {
      fill(currentColor);
    }

    stroke(darkColor);
    strokeWeight(2);

    ellipse(
      nodes[i].x,
      nodes[i].y,
      55,
      55
    );

    fill(darkColor);
    textSize(18);
    text(i, nodes[i].x, nodes[i].y);
  }
}


// =====================================
// BREADTH-FIRST SEARCH
// =====================================

void BFS(int start) {

  visited = new boolean[V];

  Queue<Integer> queue = new LinkedList<Integer>();

  visited[start] = true;
  queue.add(start);

  while (!queue.isEmpty()) {

    int current = queue.poll();

    traversal.add(current);

    for (int neighbor : graph[current]) {

      if (!visited[neighbor]) {

        visited[neighbor] = true;
        queue.add(neighbor);
      }
    }
  }
}


// =====================================
// DEPTH-FIRST SEARCH
// =====================================

void DFS(int current) {

  visited[current] = true;

  traversal.add(current);

  for (int neighbor : graph[current]) {

    if (!visited[neighbor]) {

      DFS(neighbor);
    }
  }
}


// =====================================
// START BFS
// =====================================

void startBFS() {

  resetTraversal();

  algorithm = "BFS";

  BFS(0);

  startAnimation();
}


// =====================================
// START DFS
// =====================================

void startDFS() {

  resetTraversal();

  algorithm = "DFS";

  visited = new boolean[V];

  DFS(0);

  startAnimation();
}


// =====================================
// ANIMATION
// =====================================

void startAnimation() {

  visited = new boolean[V];

  stepIndex = 0;
  currentNode = -1;

  running = true;
  finished = false;

  lastStepTime = millis();
}


// =====================================
// RESET
// =====================================

void resetTraversal() {

  visited = new boolean[V];

  traversal.clear();

  stepIndex = 0;
  currentNode = -1;

  algorithm = "NONE";

  running = false;
  finished = false;
}


// =====================================
// BUTTONS
// =====================================

void drawButton(int x, int y, String label) {

  if (label.equals("BFS")) {
    fill(pinkColor);
  }
  else if (label.equals("DFS")) {
    fill(blueColor);
  }
  else {
    fill(whiteColor);
  }

  stroke(darkColor);
  strokeWeight(1.5);

  rect(x, y, 100, 40, 12);

  fill(darkColor);
  textSize(16);

  text(label, x + 50, y + 20);
}


// =====================================
// INFORMATION
// =====================================

void drawInformation() {

  textAlign(LEFT, CENTER);
  fill(darkColor);
  textSize(16);

  text("Algorithm: " + algorithm, 40, 620);

  String order = "Traversal Order: ";

  for (int i = 0; i < stepIndex; i++) {

    order += traversal.get(i);

    if (i < stepIndex - 1) {
      order += " -> ";
    }
  }

  text(order, 40, 655);

  if (finished) {

    fill(100, 160, 130);
    textAlign(CENTER, CENTER);

    text("Traversal Completed!", 730, 655);
  }

  textAlign(CENTER, CENTER);
}


// =====================================
// MOUSE INTERACTION
// =====================================

void mousePressed() {

  if (mouseY >= buttonY && mouseY <= buttonY + 40) {

    if (mouseX >= bfsX && mouseX <= bfsX + 100) {
      startBFS();
    }

    else if (mouseX >= dfsX && mouseX <= dfsX + 100) {
      startDFS();
    }

    else if (mouseX >= resetX && mouseX <= resetX + 100) {
      resetTraversal();
    }
  }
}
