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
  text("Insertion Sort", width/2, 30);
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
  
  insertionSort();
  
  list = lists.get(loop);
  list.printArray();
}


void insertionSort() {
  int i, j;
  int temp;

  // Start from the second element
  for (i=1; i<len; i++) {
    // Get the current array
    plist = lists.get(loop);
    
    // Make a copy for the next animation frame
    lists.add(new Array(len, plist.arr, i, i));
    
    loop++;
    list = lists.get(loop);
    list.insertIndex = 1;
    
    // Save the value we want to insert
    temp = list.arr[i];
    
    // Move larger values to the right
    for(j=i-1; j>=0; j--) {
      
      // Highlight the current position
      plist = lists.get(loop);
      
      lists.add(new Array(len, plist.arr, i, j));
      
      loop++;
      list = lists.get(loop);
      
      if (temp < list.arr[j]) {
        list.arr[j+1] = list.arr[j];
      } else {
        break;
      }
    }
      
    // Put temp into the correct position
    list.arr[j+1] = temp;
    
    list.insertIndex = j+1;
  }
}
