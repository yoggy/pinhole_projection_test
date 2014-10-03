import java.util.*;

public class Line {
  // ax + by + c = 0
  public float a, b, c;

  public Line(Line l) {
    this.a = l.a;
    this.b = l.b;
    this.c = l.c;
  }

  public Line(float x0, float y0, float x1, float y1) {
    // ax + by + c = 0が(x0,y0)(x1,y1)を通る直線
    // (y1-y0)x + (x0-x1)y + (-1 * (y1-y0) * x0 + (x0-x1) * y0))) = 0
    this.a = y1 - y0;
    this.b = x0 - x1;
    this.c = -1 * (this.a * x0 + this.b * y0);
    normalize();
  }

  public Line(PVector p0, PVector p1) {
    this.a = p1.y - p0.y;
    this.b = p0.x - p1.x;
    this.c = -1 * (this.a * p0.x + this.b * p0.y);
    normalize();
  }

  public void normalize() {
    float len = sqrt(a*a + b*b);

    this.a /= len;
    this.b /= len;
    this.c /= len;
  }

  public boolean equals(Line t) {
    if (
    abs(this.a - t.a) < 0.0001
      && abs(this.b - t.b) < 0.0001
      && abs(this.c - t.c) < 0.0001) {
      return true;
    }
    return false;
  }

  public float distance(PVector p) {  
    float tmp_a = (a * p.x + b * p.y + c);
    tmp_a = tmp_a >= 0.0 ? tmp_a : -tmp_a;
    float tmp_b = sqrt(a * a + b * b);
    float d = tmp_a / tmp_b;
    return d;
  }

  public boolean parallel(Line t, float precision) {
    double m = b * t.a - t.b * a;
    if (abs((float)m) <= precision) {
      return true;
    }
    return false;
  }

  public PVector crosspoint(Line t) {
    if (parallel(t, 0.00001)) return null;

    float m = b * t.a - t.b * a; 
    float x = (c * t.b - t.c * b) / m;
    float y = (a * t.c - t.a * c) / m;

    PVector p = new PVector();
    p.x = x;
    p.y = y;
    return p;
  }
  
  public void draw() {
    Line l0 = new Line(0, 0, width, 0);
    Line l1 = new Line(0, height, width, height);
    Line l2 = new Line(0, 0, 0, height);
    Line l3 = new Line(width, 0, width, height);
    
    PVector p0 = this.crosspoint(l0);
    PVector p1 = this.crosspoint(l1);
    PVector p2 = this.crosspoint(l2);
    PVector p3 = this.crosspoint(l3);
    
    Vector v = new Vector();
    if (p0 != null && 0<= p0.x && p0.x < width) {
      v.add(p0);
    }
    if (p1 != null && 0<= p1.x && p1.x < width) {
      v.add(p1);
    }
    if (p2 != null && 0<= p2.y && p2.y < height) {
      v.add(p2);
    }
    if (p3 != null && 0<= p3.y && p3.y < height) {
      v.add(p3);
    }
    
    if (v.size() >= 2) {
      PVector r0 = (PVector)v.get(0);
      PVector r1 = (PVector)v.get(1);
      line(r0.x, r0.y, r1.x, r1.y);
    }
  }

  public String toString() {
    String str = "";
    str += "Line2f(";
    str += a;
    str += ", ";
    str += b;
    str += ", ";
    str += c;
    str += ")";
    return str;
  }
}

