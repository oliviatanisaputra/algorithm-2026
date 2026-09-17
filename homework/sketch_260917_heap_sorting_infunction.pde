int[] arr;


void setup() {
  intArr(16);
  printArr();
  heapSorting();
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


void heapSorting() {
  int n = arr.length;
  int i;
  
  // Phase 1: build a max-heap out of the whole array
  // start from the last parent node, work backward to the root
  for (i = n/2 - 1; i >= 0; i--) {
    heapify(n, i);
  }
  
  // Phase 2: repeatedly pull the max out and shrink the heap
  for (i = n-1; i > 0; i--) {
    swap(0, i);          // move current max to the end (its final sorted spot)
    heapify(i, 0);        // re-fix the heap, but now only considering arr[0..i-1]
  }
}


// makes sure the subtree rooted at index i (within a heap of size "size") satisfies the max-heap property
void heapify(int size, int i) {
  int largest = i;
  int left = 2*i + 1;
  int right = 2*i + 2;
  
  // check if left child is bigger than current largest
  if (left < size && arr[left] > arr[largest]) {
    largest = left;
  }
  // check if right child is bigger than current largest
  if (right < size && arr[right] > arr[largest]) {
    largest = right;
  }
  // if the biggest value isn't already at i, swap it up and keep fixing downward
  if (largest != i) {
    swap(i, largest);
    heapify(size, largest);   // recursively fix the subtree we just disturbed
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
