
int Value[][] = new int[4][101];
int DP[][] = new int[4][101];
int i, j;
int cnt = 5;
int m[][] = new int[cnt+1][cnt+1];

int matrixPath(int i, int j) {
  if (i == 1 && j == 1) {
    return m[i][j];
  }
  else if (i == 1) {
    return (matrixPath(1, j-1) + m[i][j]);
  }
  else if (j == 1) {
    return (matrixPath(i-1, 1) + m[i][j]);
  }
  else {
    return min(matrixPath(i-1, j), matrixPath(i, j-1)) + m[i][j];
  }
}

void setup() {
  for (i = 0; i < 3; i++) {
    for (j = 0; j < cnt; j++) {
      m[i+1][j+1] = (int) random(10);
      print(nfp(m[i+1][j+1], 2)+" ");
    }
    println();
  }
  
  println("matrixPath: " + matrixPath(cnt, cnt));
  
  //for (i = 0; i < cnt; i++) {
  //  Value[3][i] = Value[0][i] + Value[2][i];
  //}
  
  //// Case 1. -> Case2,3
  //// Case 2. -> Case1,3,4
  //// Case 3. -> Case1,2
  //// Case 4. -> Case2
  
  //// Initialize DP
  //DP[0][0] = Value[0][0];
  //DP[1][0] = Value[1][0];
  //DP[2][0] = Value[2][0];
  //DP[3][0] = Value[3][0];
  
  //// Dynamic Programming
  //for (i = 1; i < cnt; i++) {
  //  DP[0][i] = max(DP[1][i - 1], DP[2][i - 1]) + Value[0][i];
  //  DP[1][i] = max(max(DP[0][i - 1], DP[2][i - 1]), DP[3][i - 1]) + Value[1][i];
  //  DP[2][i] = max(DP[0][i - 1], DP[1][i - 1]) + Value[2][i];
  //  DP[3][i] = DP[1][i - 1] + Value[3][i];
  //}
  
  //// Display DP table
  //println("\nDP Table");
  
  //for (i = 0; i < 4; i++) {
  //  for (j = 0; j < cnt; j++) {
  //    print(nfp(DP[i][j], 4) + " ");
  //  }
  //  println();
  //}
  
  //// Find maximum sum
  //int answer = max(
  //  max(DP[0][cnt-1], DP[1][cnt-1]),
  //  max(DP[2][cnt-1], DP[3][cnt-1])
  //);

  //println("\nMaximum Sum: " + answer);
  
  
  //println(max(max(max(DP[0][cnt - 1], DP[1][cnt - 1]), DP[2][cnt - 1]), DP[3][cnt - 1]));
}
