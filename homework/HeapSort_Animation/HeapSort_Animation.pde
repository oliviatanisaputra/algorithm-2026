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
  text("Heap Sort", width/2, 30);
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
  
  heapSort();
  
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


void heapSort() {
  // Build a max heap
  for (int i=len/2-1; i>=0; i--) {
    siftDown(len, i);
  }
  
  // Move the largest value to the end
  for (int end=len-1; end>0; end--) {
    // Save the frame before swapping
    saveFrame(0, end);
    
    // Swap the root (largest) with the last unsorted value
    swap(list.arr, 0, end);
    
    // Save the frame after swapping
    saveFrame(end, 0);
    
    // Restore the max heap, excluding sorted values
    siftDown(end, 0);
  }
}


// Restore the max heap
void siftDown(int size, int root) {
  while (true) {
    int largest = root;
    int left = 2*root+1;
    int right = 2*root+2;
    
    // Compare the largest so far with left child
    if (left < size) {
      saveFrame(root, left);
      
      if (list.arr[left] > list.arr[largest]) {
        largest = left;
      }
    }
    
    // Compare the largest so far with right child
    if (right < size) {
      saveFrame(root, right);
      
      if (list.arr[right] > list.arr[largest]) {
        largest = right;
      }
    }
    
    // Parent is already the largest
    if (largest == root) {
      break;
    }
    
    // Swap parent with the larger child
    swap(list.arr, root, largest);
    
    // Save the frame after swapping
    saveFrame(root, largest);
    
    // Continue down the heap
    root = largest;
  } 
}


void swap(int[] arr, int i, int j) {
  int temp = arr[j];
  arr[j] = arr[i];
  arr[i] = temp;
}
