include <config.scad>;

module armConnector() {
  armLength = (totesPerRow-2)*toteTopWidth;

  difference() {
    hull()
      for (x = [0, 1])
        translate([x*armLength, 0, 0])
          cylinder(d = 7, h = 5, $fn = 24);

    for (x = [0, 1])
      translate([x*armLength, 0, -e/2])
        cylinder(d = 4, h = 5 + e, $fn = 24);
  }
}

armConnector();
