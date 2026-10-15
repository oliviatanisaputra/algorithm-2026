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
  text("Selection Sort", width/2, 30);
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
  
  selectionSort();
  
  list = lists.get(loop);
  list.printArray();
}


void selectionSort() {
  int i, j;
  int max;
  int maxIndex;
  
  for(i=0; i<len-1; i++) {
    // Get the current array
    plist = lists.get(loop);
    
    // Make a copy for the next animation frame
    lists.add(new Array(len, plist.arr, i, 0));
    
    loop++;
    list = lists.get(loop);
    max = maxIndex = -1;
    
    // Find the largest number
    for(j=0; j<len-i; j++) {
      if(max<list.arr[j]) {
        max = list.arr[j];
        maxIndex = j;
      }
      
      // Remember which number is currently the biggest
      list.maxIndex = maxIndex;
      
      // Save this comparison as an animation frame
      plist = lists.get(loop);
      
      lists.add(new Array(len, plist.arr, i, j));
      
      loop++;
      list = lists.get(loop);
      
      // Copy the max index to the new frame
      list.maxIndex = maxIndex;
    }
    
    // Put the largest number at the end
    if(maxIndex != -1) {
      swap(list.arr, maxIndex, len-i-1);
    }
  }
}


void swap(int[] arr, int i, int j) {
  int temp = arr[j];
  arr[j] = arr[i];
  arr[i] = temp;
}
