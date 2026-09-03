println("Hello World");

//int [] list = {2, 5, 7, 0};
int [] list = new int[100];
for (int i=0; i<list.length; i++) {
  list[i] = (int)random(1000);
};

println(list);

// i: where we want to put the biggest number
// j: used to look through the array
// max: the biggest number we've found so far
// index: where that biggest number is located
// tmp: temporary storage when swapping
int i, j, index, tmp, max;

// OUTER LOOP: based on the index (i, the location for the biggest)
for (i=0; i<list.length-1; i++) {
  // resets the variables ("I haven't found the maximum yet")
  // *it's -1 because the indexes starts at 0 
  max = index = -1;
  
  // INNER LOOP: also based on the index, the start of j following current i
  //for (j=0; j<list.length-1-i; j++) {
   for (j=i; j<list.length; j++) {
     
    // ("Is the number I'm currently looking at bigger than my current max?")
    if (max < list[j]) {
      max = list[j];
      index = j;
    }
  };
  
  // SWAPPING
  if (index != -1) {
    //tmp = list[j];
    //list[j] = max;
    //list[index] = tmp;
    tmp = list[i];
    list[i] = max;
    list[index] = tmp;
  };
};

for (i=0; i<list.length; i++) {
  print(list[i], " ");
};

//println(list);


line(0,0,100,100);
