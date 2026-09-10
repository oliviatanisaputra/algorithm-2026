int[] arr;

void setup() {
  int i, j, temp;
  
  arr = new int[16];
  for(i=0; i<arr.length; i++) {
    arr[i] = (int) random(100);
  }
  
  for(i=0; i<arr.length; i++) {
    print(arr[i], "");
  }
  println();

  // controls how many times we go through the array
  for(i=0; i<arr.length; i++) {
    
    // compares neighboring elements
    for (j=0; j<arr.length-i-1; j++) {
      
      // 
      if (arr[j] > arr[j+1]) {
        temp = arr[j];
        arr[j] = arr[j+1];
        arr[j+1] = temp;
      } 
    }
  }
  
  for (i=0; i<arr.length; i++) {
    print(arr[i], "");
  }
}

void draw() {
}
