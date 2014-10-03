class LineSegment {
  public PVector center;
  public int width;

  LineSegment() {
    center = new PVector(width/4, height/2);
    this.width = 100;
  }

  PVector getCenter() {
    return center;
  }

  PVector getTop() {
    return new PVector(center.x, center.y - this.width / 2);
  }

  PVector getBottom() {
    return new PVector(center.x, center.y + this.width / 2);
  }
  
  boolean isHit(PVector p) {
    if (PVector.dist(p, center) < 20.0f) {
      return true;
    }
    if (PVector.dist(p, getTop()) < 20.0f) {
      return true;
    }
    if (PVector.dist(p, getBottom()) < 20.0f) {
      return true;
    }
    return false;
  }

  void draw() {
    stroke(0, 255, 0);
    fill(0, 255, 0);
    ellipse(center.x, center.y, 10, 10);
    
    PVector top = getTop();
    PVector bottom = getBottom();

    ellipse(top.x, top.y, 10, 10);
    ellipse(bottom.x, bottom.y, 10, 10);

    line(top.x, top.y, bottom.x, bottom.y);
  }  
}
