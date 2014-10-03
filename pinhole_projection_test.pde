
Line center;
Line dst;
PVector mouse_old;

Projection proj0;
Projection proj1;

PFont pfont;

void setup() {
  size(600, 300); 

  float center_x = width / 2;
  center = new Line(center_x, 0, center_x, height);

  dst = new Line(width / 4 * 3, 0, width / 4 * 3, height);

  proj0 = new Projection(width / 4, height / 4 * 1, center_x, height / 2, dst);
  proj1 = new Projection(width / 4, height / 4 * 3, center_x, height / 2, dst);

  pfont = createFont("Impact",32);
}

void update() {
  PVector diff = new PVector(0, 0);
  if (mouse_old != null) {
    diff = PVector.sub(new PVector(mouseX, mouseY), mouse_old);
  }
  mouse_old = new PVector(mouseX, mouseY);

  proj0.processDrag(diff);
  proj1.processDrag(diff);

  proj0.updateProjection();
  proj1.updateProjection();
}

void draw() {
  update();

  background(0);

  fill(255, 255, 255);
  textFont(pfont);
  text("pinhole projection test", 10, 30);

  noFill();
  stroke(255, 255, 255);
  center.draw();

  noFill();
  stroke(255, 255, 255);
  dst.draw();

  proj0.draw();
  proj1.draw();
}

void mousePressed() {
  PVector p = new PVector(mouseX, mouseY);
  if (proj0.mousePressed(p) == true) return;
  if (proj1.mousePressed(p) == true) return;
}

void mouseReleased() {
  proj0.mouseReleased();
  proj1.mouseReleased();
}

