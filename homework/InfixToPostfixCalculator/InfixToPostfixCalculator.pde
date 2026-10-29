import java.util.Stack;
import java.util.ArrayList;

// Core calculation states
String infixInput = "3+5*(10-2)/4"; 
String postfixOutput = "";
float calculationResult = 0;
String errorMessage = "";

// Visualization structures
ArrayList<StackStep> shuntingYardSteps = new ArrayList<StackStep>();
TreeNode expressionTreeRoot = null;

void setup() {
  size(1050, 700);
  textFont(createFont("Courier New", 14));
  processExpression(infixInput);
}

void draw() {
  background(242);
  
  // App Header Banner
  fill(40);
  textSize(20);
  text("Infix to Postfix Stack Conversion & Expression Tree Visualizer", 30, 40);
  
  // 1. INPUT DISPLAY WINDOW
  drawDataBox("YOUR INFIX INPUT (Type using computer keyboard)", infixInput, 30, 70, 480, 50, color(255), color(0, 102, 204));
  drawDataBox("CONVERTED POSTFIX NOTATION (RPN)", postfixOutput, 30, 150, 480, 50, color(248), color(40));
  
  // Evaluation Output 
  fill(90);
  textSize(11);
  text("FINAL EVALUATION RESULT", 32, 230);
  if (!errorMessage.equals("")) {
    fill(211, 47, 47);
    textSize(15);
    text("Error: " + errorMessage, 35, 255);
  } else {
    fill(46, 125, 50);
    textSize(28);
    text(calculationResult, 35, 260);
  }
  
  // 2. STACK CONVERSION LOG TABLE
  fill(60);
  textSize(13);
  text("SHUNTING-YARD STACK STEP TRACE", 30, 300);
  
  stroke(210);
  fill(255);
  rect(30, 310, 480, 350, 4);
  
  // Table Headings
  fill(235);
  noStroke();
  rect(31, 311, 478, 25);
  stroke(210);
  line(30, 336, 510, 336);
  
  fill(70);
  textSize(11);
  text("Token", 40, 328);
  text("Operator Stack State", 130, 328);
  text("Output Queue State", 300, 328);
  
  // Render Stack Iteration Rows
  int maxRows = 14; 
  textSize(11);
  for (int i = 0; i < min(shuntingYardSteps.size(), maxRows); i++) {
    StackStep step = shuntingYardSteps.get(i);
    float rowY = 355 + (i * 22);
    
    fill(40);
    text(step.token, 40, rowY);
    
    fill(0, 102, 204);
    text(step.stackState, 130, rowY);
    
    fill(50);
    text(step.outputState, 300, rowY);
  }
  
  // 3. EXPRESSION TREE PANEL
  fill(60);
  textSize(13);
  text("GENERATED PARSE EXPRESSION TREE", 550, 85);
  
  stroke(210);
  fill(250);
  rect(550, 100, 470, 560, 6);
  
  if (expressionTreeRoot != null && errorMessage.equals("")) {
    // Recursively plot expression node branches
    renderTree(expressionTreeRoot, 785, 160, 100);
  } else if (!errorMessage.equals("")) {
    fill(150);
    textSize(14);
    text("[ Tree rendering unavailable due to error ]", 640, 350);
  }
}

// User Keypress input hook listener
void keyPressed() {
  if (key == BACKSPACE) {
    if (infixInput.length() > 0) infixInput = infixInput.substring(0, infixInput.length() - 1);
  } else if (key == ENTER || key == RETURN) {
    processExpression(infixInput);
  } else if (isValidKey(key)) {
    infixInput += key;
  }
}

boolean isValidKey(char k) {
  return (k >= '0' && k <= '9') || k == '.' || k == '+' || k == '-' || k == '*' || k == '/' || k == '(' || k == ')';
}

void drawDataBox(String label, String contents, float x, float y, float w, float h, color bg, color textCol) {
  fill(bg); stroke(215); rect(x, y, w, h, 4);
  fill(110); textSize(10); text(label, x + 2, y - 6);
  fill(textCol); textSize(16);
  text(contents.isEmpty() ? "Type your equation..." : contents, x + 12, y + 32);
}

// Visual expression node layout processor
void renderTree(TreeNode node, float x, float y, float xOffset) {
  if (node == null) return;
  
  // Draw link vectors to child stems
  stroke(160);
  strokeWeight(2);
  if (node.left != null) {
    line(x, y, x - xOffset, y + 70);
    renderTree(node.left, x - xOffset, y + 70, xOffset * 0.5);
  }
  if (node.right != null) {
    line(x, y, x + xOffset, y + 70);
    renderTree(node.right, x + xOffset, y + 70, xOffset * 0.5);
  }
  
  // Render physical circular structure nodes
  strokeWeight(1);
  if (isOperator(node.value)) {
    fill(0, 102, 204); stroke(0, 76, 153);
  } else {
    fill(255); stroke(140);
  }
  
  ellipse(x, y, 36, 36);
  
  // Render inside characters
  if (isOperator(node.value)) fill(255);
  else fill(40);
  
  textSize(13);
  textAlign(CENTER, CENTER);
  text(node.value, x, y - 1);
  textAlign(LEFT, BASELINE); // reset layout alignment
}

// Processing coordinator pipeline
void processExpression(String input) {
  errorMessage = "";
  shuntingYardSteps.clear();
  expressionTreeRoot = null;
  
  String cleanInput = input.replaceAll("\\s+", "");
  if (cleanInput.isEmpty()) { postfixOutput = ""; calculationResult = 0; return; }
  
  try {
    ArrayList<String> tokens = tokenize(cleanInput);
    ArrayList<String> postfixList = infixToPostfix(tokens);
    
    postfixOutput = String.join(" ", postfixList);
    calculationResult = evaluatePostfix(postfixList);
    
    // Parse expression tree build step out of postfix string sequence
    expressionTreeRoot = buildExpressionTree(postfixList);
  } catch (Exception e) {
    postfixOutput = "---";
    errorMessage = e.getMessage() != null ? e.getMessage() : "Syntax Error";
  }
}

// --- TOKENIZER STRATEGY ---
ArrayList<String> tokenize(String input) {
  ArrayList<String> tokens = new ArrayList<String>();
  String currentNum = "";
  for (int i = 0; i < input.length(); i++) {
    char c = input.charAt(i);
    if ((c >= '0' && c <= '9') || c == '.') {
      currentNum += c;
    } else {
      if (!currentNum.isEmpty()) { tokens.add(currentNum); currentNum = ""; }
      tokens.add(String.valueOf(c));
    }
  }
  if (!currentNum.isEmpty()) tokens.add(currentNum);
  return tokens;
}

// --- SHUNTING YARD TRACE LOGGING ---
ArrayList<String> infixToPostfix(ArrayList<String> tokens) {
  ArrayList<String> output = new ArrayList<String>();
  Stack<String> operatorStack = new Stack<String>();
  
  for (String token : tokens) {
    if (isNumeric(token)) {
      output.add(token);
    } else if (token.equals("(")) {
      operatorStack.push(token);
    } else if (token.equals(")")) {
      while (!operatorStack.isEmpty() && !operatorStack.peek().equals("(")) {
        output.add(operatorStack.pop());
      }
      if (operatorStack.isEmpty()) throw new IllegalArgumentException("Mismatched Parentheses");
      operatorStack.pop(); 
    } else if (isOperator(token)) {
      while (!operatorStack.isEmpty() && precedence(operatorStack.peek()) >= precedence(token)) {
        output.add(operatorStack.pop());
      }
      operatorStack.push(token);
    }
    // Snapshot internal state execution trace step
    shuntingYardSteps.add(new StackStep(token, operatorStack.toString(), output.toString()));
  }
  
  while (!operatorStack.isEmpty()) {
    String top = operatorStack.pop();
    if (top.equals("(") || top.equals(")")) throw new IllegalArgumentException("Mismatched Parentheses");
    output.add(top);
    shuntingYardSteps.add(new StackStep("END", operatorStack.toString(), output.toString()));
  }
  return output;
}

// --- PARSE EXPRESSION TREE STRUCTURING ENGINE ---
TreeNode buildExpressionTree(ArrayList<String> postfixTokens) {
  if (postfixTokens.isEmpty()) return null;
  Stack<TreeNode> treeStack = new Stack<TreeNode>();
  
  for (String token : postfixTokens) {
    if (isNumeric(token)) {
      treeStack.push(new TreeNode(token));
    } else if (isOperator(token)) {
      if (treeStack.size() < 2) return null;
      TreeNode rightChild = treeStack.pop();
      TreeNode leftChild = treeStack.pop();
      
      TreeNode parentNode = new TreeNode(token);
      parentNode.left = leftChild;
      parentNode.right = rightChild;
      
      treeStack.push(parentNode);
    }
  }
  return treeStack.isEmpty() ? null : treeStack.pop();
}

// --- POSTFIX EVALUATOR ---
float evaluatePostfix(ArrayList<String> postfixTokens) {
  if (postfixTokens.isEmpty()) return 0;
  Stack<Float> evaluationStack = new Stack<Float>();
  
  for (String token : postfixTokens) {
    if (isNumeric(token)) {
      evaluationStack.push(Float.parseFloat(token));
    } else if (isOperator(token)) {
      float operand2 = evaluationStack.pop();
      float operand1 = evaluationStack.pop();
      evaluationStack.push(applyOp(token, operand1, operand2));
    }
  }
  return evaluationStack.pop();
}

boolean isNumeric(String str) { return str.matches("\\d+(\\.\\d+)?"); }
boolean isOperator(String str) { return str.equals("+") || str.equals("-") || str.equals("*") || str.equals("/"); }

int precedence(String op) {
  if (op.equals("+") || op.equals("-")) return 1;
  if (op.equals("*") || op.equals("/")) return 2;
  return -1;
}

float applyOp(String op, float a, float b) {
  if (op.equals("+")) return a + b;
  if (op.equals("-")) return a - b;
  if (op.equals("*")) return a * b;
  if (op.equals("/")) {
    if (b == 0) throw new ArithmeticException("Divide by zero error.");
    return a / b;
  }
  return 0;
}

// --- BASIC DATA STRUCTS ---

class StackStep {
  String token, stackState, outputState;
  StackStep(String t, String s, String o) {
    this.token = t;
    this.stackState = s;
    this.outputState = o;
  }
}

class TreeNode {
  String value;
  TreeNode left, right;
  TreeNode(String val) {
    this.value = val;
    this.left = null;
    this.right = null;
  }
}
