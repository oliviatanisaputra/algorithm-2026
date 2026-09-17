int[] arr;

void setup() {
  intArr(16);
  printArr();
  mergeSorting();
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


void mergeSorting() {
  mergeSort(0, arr.length-1); // p = 0, r = last index
}


void mergeSort(int p, int r) {
  if (p < r) {
    int q = (p + r) / 2;
    mergeSort(p, q);              // sort left half
    mergeSort(q+1, r);            // sort right half
    merge(p, q, r);               // combine
  }
}


void merge(int p, int q, int r){
  int[] temp = new int[r-p+1];    // temporary space to hold the merged result
  int i = p;                      // pointer into left half [p..q]
  int j = q+1;                    // pointer into right half [q+1..r]
  int k = 0;                      // pointer into temp[]

  // compare front of left half vs front of right half,  take the smaller
  while (i <= q && j <= r) {
    if (arr[i] <= arr[j]) {
      temp[k] = arr[i];
      i++;
    } else {
      temp[k] = arr [j];
      j++;
    }
    k++;
  }
  
  // if left half has leftovers, copy them in
  while (i <= q) {
    temp[k] = arr[i];
    i++;
    k++;
  }
  
  // if right half has leftovers, copy them in
  while (j <= r) {
    temp[k] = arr[j];
    j++;
    k++;
  }
  
  // copy the merged, sorted temp[] back into the real array
  for (int x=0; x<temp.length; x++) {
    arr[p+x] = temp[x];
  }
}

void draw() {
}
