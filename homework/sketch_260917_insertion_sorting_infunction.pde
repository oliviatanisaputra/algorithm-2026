int[] arr;

void setup() {
  intArr(16);
  printArr();
  insertionSorting();
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


void insertionSorting() {
  int i, j;
  
  // controls which element we're currently inserting (start at index 1, since a single element is already "sorted")
  for (i=1; i<arr.length;++i) {
    j = i;
    
    // keep swapping arr[j] backward as long as it's smaller than its left neighbor
    while (j>0 && arr[j-1] > arr[j]) {
      swap(j-1, j);
      j--;
    }
  }
}

 //<>//
void swap(int k, int l) {
  int temp;
  
  temp = arr[k];
  arr[k] = arr[l];
  arr[l] = temp;
}


void draw() {
}
