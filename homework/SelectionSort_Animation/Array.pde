class Array {
  int i0, j0, len, max, w;
  int[] arr;
  int margin = 10;
  int maxIndex = -1;
  
  
  // Create random numbers
  void shuffle() {
    for(int i=0; i<len;i++) {
      arr[i] = (int)random(max);
    }
  }
  
  
  // Create a new random array
  Array(int len, int i0, int j0) {
    max = 100;
    this.i0 = i0;
    this.j0 = j0;
    this.len = len;
    
    arr = new int[len];
    w = (int)((width-2*margin)/len + 2);
    shuffle();
  }
  
  
  // Make a copy of an existing array
  Array(int len, int[] arr, int i0, int j0) {
    max = 100;
    this.i0 = i0;
    this.j0 = j0;
    this.len = len;
    
    this.arr = new int[len];
    w = (int)((width-2*margin)/len + 2);
    
    for (int i=0; i<len; i++) {
      this.arr[i] = arr[i];
    }
  }
  
  
  // Draw the array
  void draw() {
    int x, y, h;
    int barWidth = w - 3;
    int totalWidth = len * barWidth;
    int startX = (width - totalWidth)/2;
    
    for (int i=0; i<len; i++) {
      
      // Highlight the current position
      if(i==maxIndex)
        fill(10, 10, 100);
      else if(i == j0)
        fill(255, 205, 215);
      else
        fill(140, 190, 230);
        
      x = startX + i * barWidth;
      h = arr[i];
      y = height - margin - 3 * h;
      
      rect(x, y, barWidth, 3*h);
    }
  }
  
  
  // Print the array in the console
  void printArray() {
    print("("+nf(i0,2)+","+nf(j0,2)+")- ");
    for(int i=0; i<len; i++) {
      print(nf(arr[i],2)+" ");
    }
    println();
  }
}  
