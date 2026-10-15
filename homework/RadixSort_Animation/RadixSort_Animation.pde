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
  text("Radix Sort", width/2, 30);
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
  
  radixSort();
  
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


void radixSort() {
  int maxValue = 100;
  
  // Sort by ones digit, then tens digit
  for (int place=1; maxValue/place>0; place*=10) {
    countingSort(place);
  }
}


// Stable Counting Sort for each digit
void countingSort(int place) {
  int i;
  int[] source = new int[len];
  int[] output = new int[len];
  int[] count = new int[10];
  
  // Copy the current array
  for (i=0; i<len; i++) {
    source[i] = list.arr[i];
  }
  
  // Count how many numbers have each digit
  for (i=0; i<len; i++) {
    int digit = (source[i] / place) % 10;
    count[digit]++;
  }
  
  // Calculate cumulative counts
  for (i=1; i<10; i++) {
    count[i] += count[i-1];
  }
  
  // Place numbers into output in stable order
  for (i=len-1; i>=0; i--) {
    int digit = (source[i] / place) % 10;
    int pos = --count[digit];
    
    output[pos] = source[i];
    
    // Update the animation array
    list.arr[pos] = source[i];
    
    // Save the frame highlighting the destination
    saveFrame(-1, pos);
  }
}
