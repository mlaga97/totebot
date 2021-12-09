include <config.scad>;

module tote() {
  hull() {
    translate([0, 0, toteHeight/2])
      cube([toteBottomWidth, toteBottomLength, toteHeight], center = true);
    translate([0, 0, toteHeight -e/2])
      cube([toteTopWidth, toteTopLength, e], center = true);
  }
}

module totes() {
  for (x = [0:(totesPerRow-1)])
    translate([-x*toteTopWidth, 0, 0])
      scale(0.99)
        tote();
}

tote();
