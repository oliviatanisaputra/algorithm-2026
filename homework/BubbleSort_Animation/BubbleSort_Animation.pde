ArrayList<Array> lists;
Array list, plist;
int len=50, index=0, loop=0, napTime=50;
boolean autoFlag=true;


void setup() {
  size(600, 400);
  run();
  list = lists.get(0);
}


void draw() {
  background(235, 245, 250);
  list = lists.get(index);
  list.draw();
  fill(0);
  
  textAlign(CENTER);
  text("Bubble Sort", width/2, 30);
  text(index+"/"+loop, width/2, 50);
  
  if (autoFlag) nextStep();
}


void nextStep() {
  delay(napTime);
  
  if (index<loop) index++;
  else autoFlag = false;
}


void keyPressed() {
  // Space = pause/play
  if(key == ' ') {
    autoFlag = !autoFlag;
  }
  
  // A = faster
  else if(key == 'a') {
    if(napTime>50)
      napTime -= 50;
  }
  
  // S = slower
  else if(key == 's') {
    napTime += 50;
  }
  
  // Left arrow = previous frame
  else if(key == CODED && keyCode == LEFT) {
    if(index>0){
      index--;
    }  
  }
  
  // Right arrow = next frame
  else if(key == CODED && keyCode == RIGHT) {
    if(index<loop){
      index++;
    }
  }
}


void mousePressed() {
  if(autoFlag) autoFlag=false;
  if(mouseButton == LEFT) {
    if(index>0) index--;
  }
  else if(mouseButton == RIGHT) {
    if(index<loop) index++;
  }
}


void run() {
  loop = index = 0;
  lists = new ArrayList<Array>();
  
  // Create the original random array
  lists.add(new Array(len, 0, -1));
  list = lists.get(0);
  list.printArray();
  
  bubbleSort();
  
  list = lists.get(loop);
  list.printArray();
}


void bubbleSort() {
  int i, j;

  // Repeat passes
  for (j=0; j<len-1; j++) {
    // Get the current array
    plist = lists.get(loop);
    
    // Make a copy for the next animation frame
    lists.add(new Array(len, plist.arr, j, 0));
    
    loop++;
    list = lists.get(loop);
    
    // Compare adjacent numbers
    for(i=0; i<len-j-1; i++) {
      
      // Highlight the two numbers being compared
      plist = lists.get(loop);
      
      lists.add(new Array(len, plist.arr, j, i));
      
      loop++;
      list = lists.get(loop);
      
      // Compare adjacent values
      if (list.arr[i] > list.arr[i+1]) {
        swap(list.arr, i, i+1);
      }
    }
  }
}


void swap(int[] arr, int i, int j) {
  int temp = arr[j];
  arr[j] = arr[i];
  arr[i] = temp;
}
