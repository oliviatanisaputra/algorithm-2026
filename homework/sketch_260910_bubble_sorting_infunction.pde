int[] arr;

void setup() {
  intArr(16);
  printArr();
  bubbleSorting();
  printArr();
}


void intArr(int n) {
  int i;
  
  arr = new int[16];
  for(i=0; i<arr.length; i++) {
    arr[i] = (int) random(100);
  }
}


void printArr() {
  int i;
  
  for(i=0; i<arr.length; i++) {
    print(arr[i], "");
  }
  println();
}


void bubbleSorting() {
  int i, j;

  // controls how many times we go through the array
  for(i=0; i<arr.length; i++) {
    // compares neighboring elements
    for (j=0; j<arr.length-i-1; j++) {
      // if the current number is bigger than the number next to it, swap them
      if (arr[j] > arr[j+1]) {
        swap(j, j+1);
      } 
    }
  }
}


void swap(int k, int l) {
  int temp;
  
  temp = arr[k];
  arr[k] = arr[l];
  arr[l] = temp;
}


void draw() {
}
