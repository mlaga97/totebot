include <config.scad>;

// Components
use <tote.scad>;
use <pickup.scad>;
use <rest.scad>;
use <arm.scad>;
use <leg.scad>;

module assembly(x, xx, z) {
  x_travel = toteTopWidth;
  z_travel = fingerHeight + fingerClearance/2;

  translate([x * x_travel, 0, (z-0.5) * z_travel * 2]) {
    pickup();
  }

  /*
  if (z > 0.5) {
    translate([xx * x_travel, 0, (z-0.5)*2 * z_travel])
      totes();
  } else {
    translate([xx * x_travel, 0, 0])
      totes();
  }
  */

  for (m = [0, 1])
    mirror([0, m, 0])
      rest();

  // TODO: For loop
  translate([0, 0, -7.5])
    armAssembly(z);
  translate([-(totesPerRow-2) * toteTopWidth, 0, -7.5])
    armAssembly(z);

  translate([toteTopWidth/2, 0, 0])
    leg();
  translate([-(totesPerRow-0.5)*toteTopWidth, 0, 0])
    leg();
}

/*******************************************************************************
********************************************************************************
*******************************************************************************/
// Animation

module animation() {
  t = $t * 6;

  if (t < 0.5) { // 0.5
    x = 0;
    z = t*2;

    assembly(x, x, z);
  } else if (t < 1.5) { // 1
    x = t-0.5;
    z = 1;

    assembly(x, x, z);
  } else if (t < 2) { // 0.5
    x = 1;
    z = 1-(t-1.5)*2;

    assembly(x, x, z);
  } else if (t < 3) { // 1
    x = 1-(t-2);
    z = 0;

    assembly(x, 1, z);
  } else if (t < 4) { // 1
    x = t - 3;
    z = 0;

    assembly(x, 1, z);
  } else if (t < 4.5) { // 0.5
    x = 1;
    z = (t - 4) * 2;

    assembly(x, 1, z);
  } else if (t < 5.5) { // 1
    x = 1-(t-4.5);
    z = 1;

    assembly(x, x, z);
  } else if (t < 6) { // 0.5
    x = 0;
    z = 1-(t-5.5)*2;

    assembly(x, x, z);
  }
}

animation();
