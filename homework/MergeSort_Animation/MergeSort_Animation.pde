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
  text("Merge Sort", width/2, 30);
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
  
  mergeSort(0, len-1);
  
  list = lists.get(loop);
  list.printArray();
}


void mergeSort(int left, int right) {
  // Stop when there is only one element
  if(left >= right) return;
  
  // Find the middle
  int mid = (left + right) / 2;
  
  // Sort the left half
  mergeSort(left, mid);
  
  // Sort the right half
  mergeSort(mid+1, right);
  
  // Merge the two sorted halves
  merge(left, mid, right);
}


// Merge two sorted parts
void merge(int left, int mid, int right) {
  int[] temp = new int[right-left+1];
  
  int i = left;
  int j = mid+1;
  int k = 0;
  
  // Compare elements from both halves
  while (i <= mid && j <= right) {
    // Create an animation frame
    plist = lists.get(loop);
    
    lists.add(new Array(len, plist.arr, i, j));
    
    loop++;
    list = lists.get(loop);
    
    // Take the smaller value 
    if (list.arr[i] <= list.arr[j]) {
      temp[k] = list.arr[i];
      i++;
    } else {
      temp[k] = list.arr[j];
      j++;
    }
    
    k++;
  }
  
  // Copy remaining elements from left half
  while (i <= mid) {
    temp[k] = list.arr[i];
    i++;
    k++;
  }
  
  // Copy remaining elements from right half
  while (j <= right) {
    temp[k] = list.arr[j];
    j++;
    k++;
  }
  
  // Put the merrged values back into the array
  for (k=0; k<temp.length; k++) {
    
    // Create an animation frame
    plist = lists.get(loop);
    
    lists.add(new Array(len, plist.arr, left+k, -1));
    
    loop++;
    list = lists.get(loop);
    
    // Copy sorted value back
    list.arr[left+k] = temp[k];
  }
}
  
