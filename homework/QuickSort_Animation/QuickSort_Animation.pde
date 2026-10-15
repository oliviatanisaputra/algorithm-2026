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
  text("Quick Sort", width/2, 30);
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
  
  quickSort(0, len-1);
  
  list = lists.get(loop);
  list.printArray();
}


// Create a new animation frame
void saveFrame(int i, int j) {
  plist = lists.get(loop);
  lists.add(new Array(len, plist.arr, i, j));
  
  loop++;
  list = lists.get(loop);
}


void quickSort(int low, int high) {
  if (low < high) {
    // Partition the array and get pivot position
    int pivotIndex = partition(low, high);
    
    // Sort the right part
    quickSort(low, pivotIndex-1);
    
    // Sort the right part
    quickSort(pivotIndex+1, high);
  }
}


// Partition the array around the pivot
int partition(int low, int high) {
  // Choose the last element as pivot
  int pivot = lists.get(loop).arr[high];
  
  // Position for smaller elements
  int i = low - 1;
  
  // Compare each element with the pivot
  for (int j=low; j<high; j++) {
    // Save comparison frame
    saveFrame(i, j);
    list.pivotIndex = high;
    
    if (list.arr[j] <= pivot) {
      i++;
      
      // Move smaller element to the left
      swap(list.arr, i, j);
    }
  }
  
  // Put pivot in its correct position
  saveFrame(i+1, high);
  list.pivotIndex = high;
  swap(list.arr, i+1, high);
  
  // Save the frame after placing the pivot
  saveFrame(i+1, -1);
  list.pivotIndex = i+1;
  
  return i+1;
}


void swap(int[] arr, int i, int j) {
  int temp = arr[j];
  arr[j] = arr[i];
  arr[i] = temp;
}
