
// only once (*printed only once in terminal)
void setup() {
  size(600, 400);
  println("in setup");
}

// printed again and again
void draw() {
  stroke(random(255),random(255),random(255));
  line(random(600),random(400),random(600),random(400));
  println("in draw");
}
