include <config.scad>;

module armPaddle(armLength) {
  difference() {
    hull()
      for (x = [0, 1])
        translate([x*armLength, 0, 0])
          cylinder(d = 7, h = armatureThickness, center = true, $fn = 24);

    for (x = [0, 1])
      translate([x*armLength, 0, 0])
        cylinder(d = 3, h = armatureThickness + e, center = true, $fn = 24);
  }
}

!armPaddle(22.5);
