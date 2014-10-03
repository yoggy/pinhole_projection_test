class Projection {
  LineSegment src;

  boolean src_clicked;
  boolean focus_clicked;

  PVector focus;

  Line dst;

  PVector dst_top;
  PVector dst_center;
  PVector dst_bottom;

  Projection(float src_x, float src_y, float focus_x, float focus_y, Line dst) {
    src = new LineSegment();
    src.center.x = src_x;
    src.center.y = src_y;
    src.width = 100;

    focus = new PVector(focus_x, focus_y);    

    this.dst = dst;
  }

  void updateProjection() {
    Line line_top = new Line(src.getTop(), focus);
    Line line_center = new Line(src.getCenter(), focus);
    Line line_bottom = new Line(src.getBottom(), focus);

    if (focus.x <= src.center.x) {
      dst_top = null;
      dst_center = null;
      dst_bottom = null;
    } else {
      dst_top = dst.crosspoint(line_top);
      dst_center = dst.crosspoint(line_center);
      dst_bottom = dst.crosspoint(line_bottom);
    }
  }

  void draw() {
    // projection point
    if (dst_top != null) {
      noFill();
      stroke(0, 0, 255);
      line(src.getTop().x, src.getTop().y, dst_top.x, dst_top.y);

      noStroke();
      fill(255, 0, 0);
      ellipse(dst_top.x, dst_top.y, 10, 10);
    }
    if (dst_center != null) {
      noFill();
      stroke(0, 0, 255);
      line(src.getCenter().x, src.getCenter().y, dst_center.x, dst_center.y);

      noStroke();
      fill(255, 0, 0);
      ellipse(dst_center.x, dst_center.y, 10, 10);
    }
    if (dst_bottom != null) {
      noFill();
      stroke(0, 0, 255);
      line(src.getBottom().x, src.getBottom().y, dst_bottom.x, dst_bottom.y);

      noStroke();
      fill(255, 0, 0);
      ellipse(dst_bottom.x, dst_bottom.y, 10, 10);
    }

    // focus point
    fill(255, 255, 255);
    noStroke();
    ellipse(focus.x, focus.y, 10, 10);

    // 
    src.draw();
  }

  boolean mousePressed(PVector p) {
    if (src.isHit(p) == true) {
      src_clicked = true;
      return true;
    }    
    if (PVector.dist(p, focus) < 10) {
      focus_clicked = true;
      return true;
    }
    return false;
  }

  void mouseReleased() {
    src_clicked = false;
    focus_clicked = false;
  }

  void processDrag(PVector diff) {
    if (src_clicked == true) {
      src.center = PVector.add(src.center, diff);
    } else if (focus_clicked) {
      focus.y += diff.y;
    }
  }
}

