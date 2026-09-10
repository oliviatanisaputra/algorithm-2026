int[] arr;

void setup() {
  int i, j, max, index, temp;
  
  arr = new int[16];
  for(i=0; i<arr.length; i++) {
    arr[i] = (int) random(100);
  }
  
  for(i=0; i<arr.length; i++) {
    print(arr[i], "");
  }
  println();

  for(i=0; i<arr.length; i++) {
    max = index = -1;
    
    for (j=0; j<arr.length-i; j++) {
      if (max<arr[j]) {
        index = j;
        max = arr[j];
      }
    }
    
    temp = arr[arr.length-i-1];
    arr[arr.length-i-1] = max;
    arr[index] = temp;
  }
  
  for (i=0; i<arr.length; i++) {
    print(arr[i], "");
  }
}

void draw() {
}
