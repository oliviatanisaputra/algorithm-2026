
ArrayList<Frame> frames = new ArrayList<Frame>();
int frameIndex = 0;

RBNode root;

//int[] numbers = {10, 20, 30, 15, 25, 5, 1, 8, 12, 18};
int[] numbers = new int[20];

void setup() {
  size(1000, 650);
  textAlign(CENTER, CENTER);
  buildAnimation();
}

void draw() {
  background(240);

  fill(30);
  textSize(26);
  text("Red-Black Tree Animation", width/2, 30);

  fill(80);
  textSize(14);
  text("SPACE / RIGHT: Next step     LEFT: Previous step     R: Restart",
       width/2, 62);

  if (frames.size() == 0) return;

  Frame f = frames.get(frameIndex);

  // Draw connections first, behind the nodes
  drawEdges(f.root, 0, 0);

  // Draw the nodes
  drawNodes(f.root, 0, 0);

  // Display the algorithm explanation
  fill(255);
  stroke(190);
  rect(20, height-100, width-40, 75, 10);

  fill(30);
  noStroke();
  textSize(16);
  textAlign(LEFT, CENTER);
  text(f.message, 35, height-75, width-70, 45);
  textAlign(CENTER, CENTER);

  fill(70);
  textSize(13);
  text("Step " + (frameIndex+1) + " / " + frames.size(),
       width/2, height-12);
}

void keyPressed() {
  if (key == ' ' || keyCode == RIGHT) {
    if (frameIndex < frames.size()-1) {
      frameIndex++;
    }
  } 
  else if (keyCode == LEFT) {
    if (frameIndex > 0) {
      frameIndex--;
    }
  } 
  else if (key == 'r' || key == 'R') {
    buildAnimation();
  }
}

// Build the entire sequence of animation frames
void buildAnimation() {
  frames.clear();
  root = null;
  frameIndex = 0;
  
  // Generate unique random numbers
  int[] numbers = new int[20];
  
  for (int i=0; i<numbers.length; i++) {
    int value;
    
    do {
      value = (int)random(100);
    } while (containsNumber(numbers, i, value));
    
    numbers[i] = value;
  }

  addFrame("Start: The tree is empty.");

  for (int value : numbers) {
    insert(value);
  }
}


boolean containsNumber(int[] arr, int length, int value) {
  for (int i=0; i<length; i++) {
    if (arr[i] == value) {
      return true;
    }
  }
  return false;
}


void addFrame(String message) {
  frames.add(new Frame(snapshot(root), message));
}

// Create an independent copy of the current tree
SnapNode snapshot(RBNode node) {
  if (node == null) return null;

  SnapNode copy = new SnapNode(node.val, node.red);
  copy.left = snapshot(node.left);
  copy.right = snapshot(node.right);

  return copy;
}

// Insert using the Binary Search Tree rule first
void insert(int value) {
  RBNode z = new RBNode(value);
  RBNode parent = null;
  RBNode current = root;

  while (current != null) {
    parent = current;

    if (value < current.val) {
      current = current.left;
    } 
    else if (value > current.val) {
      current = current.right;
    } 
    else {
      return; // Ignore duplicate values
    }
  }

  z.parent = parent;

  if (parent == null) {
    root = z;
  } 
  else if (value < parent.val) {
    parent.left = z;
  } 
  else {
    parent.right = z;
  }

  z.red = true;

  addFrame("Insert " + value + " as a RED node.");

  fixInsert(z);
}

// Repair Red-Black Tree rules after insertion
void fixInsert(RBNode z) {
  while (z != root &&
         z.parent.red) {

    RBNode parent = z.parent;
    RBNode grand = parent.parent;

    // Parent is the left child of the grandparent
    if (parent == grand.left) {
      RBNode uncle = grand.right;

      // CASE 1: Uncle is RED
      if (isRed(uncle)) {
        parent.red = false;
        uncle.red = false;
        grand.red = true;

        addFrame("Case 1: Parent and uncle are RED. "
                 + "Recolor both BLACK and grandparent RED.");

        z = grand;
      } 
      else {
        // CASE 2: Triangle shape
        if (z == parent.right) {
          z = parent;
          rotateLeft(z);

          addFrame("Case 2: Left rotation changes "
                   + "the triangle into a line.");

          parent = z.parent;
          grand = parent.parent;
        }

        // CASE 3: Line shape
        parent.red = false;
        grand.red = true;

        rotateRight(grand);

        addFrame("Case 3: Recolor and rotate right.");
      }
    } 
    else {
      // Mirror cases: parent is the right child
      RBNode uncle = grand.left;

      // CASE 1: Uncle is RED
      if (isRed(uncle)) {
        parent.red = false;
        uncle.red = false;
        grand.red = true;

        addFrame("Mirror Case 1: Parent and uncle are RED. "
                 + "Recolor both BLACK and grandparent RED.");

        z = grand;
      } 
      else {
        // CASE 2: Triangle shape
        if (z == parent.left) {
          z = parent;
          rotateRight(z);

          addFrame("Mirror Case 2: Right rotation changes "
                   + "the triangle into a line.");

          parent = z.parent;
          grand = parent.parent;
        }

        // CASE 3: Line shape
        parent.red = false;
        grand.red = true;

        rotateLeft(grand);

        addFrame("Mirror Case 3: Recolor and rotate left.");
      }
    }
  }

  root.red = false;
  addFrame("The root must be BLACK. Insertion complete.");
}

boolean isRed(RBNode node) {
  return node != null && node.red;
}

// Left rotation
void rotateLeft(RBNode x) {
  RBNode y = x.right;

  x.right = y.left;

  if (y.left != null) {
    y.left.parent = x;
  }

  y.parent = x.parent;

  if (x.parent == null) {
    root = y;
  } 
  else if (x == x.parent.left) {
    x.parent.left = y;
  } 
  else {
    x.parent.right = y;
  }

  y.left = x;
  x.parent = y;
}

// Right rotation
void rotateRight(RBNode x) {
  RBNode y = x.left;

  x.left = y.right;

  if (y.right != null) {
    y.right.parent = x;
  }

  y.parent = x.parent;

  if (x.parent == null) {
    root = y;
  } 
  else if (x == x.parent.right) {
    x.parent.right = y;
  } 
  else {
    x.parent.left = y;
  }

  y.right = x;
  x.parent = y;
}

// Calculate a node's screen position
float nodeX(int index, int depth) {
  return width * (index + 0.5) / pow(2, depth);
}

float nodeY(int depth) {
  return 115 + depth * 75;
}

// Draw the edges
void drawEdges(SnapNode node, int index, int depth) {
  if (node == null) return;

  float x = nodeX(index, depth);
  float y = nodeY(depth);

  stroke(100);
  strokeWeight(2);

  if (node.left != null) {
    line(x, y, nodeX(index*2, depth+1), nodeY(depth+1));
    drawEdges(node.left, index*2, depth+1);
  }

  if (node.right != null) {
    line(x, y, nodeX(index*2+1, depth+1), nodeY(depth+1));
    drawEdges(node.right, index*2+1, depth+1);
  }
}

// Draw red and black nodes
void drawNodes(SnapNode node, int index, int depth) {
  if (node == null) return;

  float x = nodeX(index, depth);
  float y = nodeY(depth);

  if (node.left != null) {
    drawNodes(node.left, index*2, depth+1);
  }

  if (node.right != null) {
    drawNodes(node.right, index*2+1, depth+1);
  }

  stroke(255);
  strokeWeight(2);

  if (node.red) {
    fill(210, 50, 50);
  } 
  else {
    fill(30);
  }

  ellipse(x, y, 44, 44);

  fill(255);
  noStroke();
  textSize(15);
  text(node.val, x, y);
}

class RBNode {
  int val;
  boolean red = true;

  RBNode left;
  RBNode right;
  RBNode parent;

  RBNode(int value) {
    val = value;
  }
}

// An immutable snapshot used for animation
class SnapNode {
  int val;
  boolean red;
  SnapNode left;
  SnapNode right;

  SnapNode(int value, boolean isRed) {
    val = value;
    red = isRed;
  }
}

class Frame {
  SnapNode root;
  String message;

  Frame(SnapNode tree, String explanation) {
    root = tree;
    message = explanation;
  }
}
