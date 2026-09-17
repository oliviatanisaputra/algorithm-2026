int[] arr;


void setup() {
  intArr(16);
  printArr();
  quickSorting();
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


void quickSorting() {
  quickSort(0, arr.length-1);  // p = 0, r = last index
}


void quickSort(int p, int r) {
  if (p < r) {
    int q = partition(p, r);   // rearrange, get pivot's final resting index
    quickSort(p, q-1);         // recursively sort left side
    quickSort(q+1, r);         // recursively sort right side
  }
}


int partition(int p, int r) {
  int pivot = arr[r];          // pick the last element as pivot
  int i = p - 1;               // marks the boundary of "elements smaller than pivot"
  int j;
  
  for (j = p; j < r; j++) {
    if (arr[j] < pivot) {
      i++;
      swap(i, j);
    }
  }
  swap(i+1, r);              // move pivot into its final position, right after all smaller elements
  return i+1;                // return pivot's final index
}


void swap(int k, int l) {
  int temp;
  
  temp = arr[k];
  arr[k] = arr[l];
  arr[l] = temp;
}


void draw() {
}
