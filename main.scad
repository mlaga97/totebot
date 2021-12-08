e = 0.01;

// Real Sterilite Tote Size
//toteHeight = 125;
//toteTopWidth = 200;
//toteBottomWidth = 155;
//toteTopLength = 355;
//toteBottomLength = 300;

// Scaled Size
toteHeight = 30;
toteTopWidth = 60;
toteBottomWidth = 45;
toteTopLength = 105;
toteBottomLength = 90;

// Parameters
fingerHeight = 5;
fingerClearance = 5;

armatureHeight = 10;
armatureThickness = 20;

baseHeight = 20;
baseThickness = 10;

boltDiameter = 3;
pinDiameter = 4;

base2Height = 20;

module tote() {
  hull() {
    translate([0, 0, toteHeight/2])
      cube([toteBottomWidth, toteBottomLength, toteHeight], center = true);
    translate([0, 0, toteHeight -e/2])
      cube([toteTopWidth, toteTopLength, e], center = true);
  }
}

module armature() {
  difference() {
    translate([0, 0, (fingerHeight + armatureHeight)/2 - armatureHeight])
      cube([toteTopWidth + boltDiameter*3, armatureThickness, fingerHeight + armatureHeight], center = true);
    tote();
    for (x = [-1, 0, 1])
      translate([x*toteTopWidth/2, 0, -armatureHeight/2]) {
        cylinder(d = boltDiameter, h = armatureThickness + fingerHeight + 1, center = true);
        rotate([90, 0, 0])
          cylinder(d = boltDiameter, h = armatureThickness + 1, center = true);
      }
  }
}

module base() {
  difference() {
    translate([0, 0, (fingerHeight + baseHeight)/2 - baseHeight])
      cube([toteTopWidth + boltDiameter*3, baseThickness, fingerHeight + baseHeight], center = true);
    tote();
    for (x = [-1, 0, 1])
      translate([x*toteTopWidth/2, 0, -baseHeight/2]) {
        cylinder(d = boltDiameter, h = baseHeight + fingerHeight*2 + 1, center = true);
        rotate([90, 0, 0])
          cylinder(d = boltDiameter, h = baseThickness + 1, center = true);
      }
  }
}

module base2() {
  difference() {
    translate([0, 0, -baseHeight/2 - base2Height/2 - fingerHeight/2])
      cube([10, toteBottomLength, base2Height], center = true);

    for (y = [-1, 1])
      translate([0, y*(toteBottomWidth - baseThickness/2), -baseHeight/2 - base2Height/2 - fingerHeight/2])
        cylinder(d = pinDiameter, h = base2Height + 1, center = true);
  }
}

module arm(armLength) {
  difference() {
    hull()
      for (x = [0, 1])
        translate([x*armLength, 0, 0])
          cylinder(d = 7, h = 5, center = true, $fn = 24);

    for (x = [0, 1])
      translate([x*armLength, 0, 0])
        cylinder(d = 3.5, h = 5 + e, center = true, $fn = 24);
  }
}
//!arm(22.5);

module armSpacer1() {
  difference() {
    cylinder(d = 7, h = 19, center = true);
    cylinder(d = 4, h = 19 + e, center = true);
  }
}

module armSpacer2() {
  difference() {
    cylinder(d = 7, h = 22, center = true);
    cylinder(d = 3, h = 22 + e, center = true);
  }
}

module shelf_part() {
  difference() {
    cylinder(d = 7, h = 22, center = true);
    cylinder(d = 3, h = 22 + e, center = true);
  }
}

module shelf() {
  translate([0, 0, 2])
    rotate([90, 0, 0])
      difference() {
        hull()
          for (x = [-6:3])
            translate([x*15, 0, 0])
              cylinder(d = 6.5, h = 22, center = true);
        for (x = [-6:3])
          translate([x*15, 0, 0])
            cylinder(d = 3, h = 22 + e, center = true);
      }
}

module armMount() {
  difference() {
    union() {
      cylinder(d = 10, h = baseThickness, center = true);
      translate([0, 8/2, 0])
        cube([10, 8, baseThickness], center = true);
      translate([0, -4/2 + 8, 0])
        cube([40, 4, baseThickness], center = true);
    }

    cylinder(d = 4, h = baseThickness + e, center = true);
    for (x = [-1, 1])
      translate([x*15, 6, 0])
        rotate([90, 0, 0])
          cylinder(d = 3.5, h = 4 + e, center = true);
  }
}

module armAssembly(z_a) {
  armLength = 22.5;
  th = asin((z_a*(armLength - 7.5) + 7.5)/22.5);

  translate([-toteTopWidth/4, 0, -armLength + 2]) {
    rotate([90, 0, 0])
      for (y = [-1, 1]) {
        armSpacer2();
        translate([0, 0, y*(19/2 + 16)])
          armSpacer1();
        translate([0, 0, y*(toteBottomLength - baseThickness)/2])
          armMount();
        rotate([0, 0, th])
          translate([0, 0, y*(16 - 5/2)]) {
            arm(armLength);
          }
      }
  }
}

/*******************************************************************************
********************************************************************************
*******************************************************************************/
// Assemblies

for (x = [-1, 1])
  translate([x * toteTopWidth * 1.5, 0, 0])
    base2();

module base_assembly() {
  for (y = [-1, 1])
    translate([0, y*(toteBottomLength/2 - baseThickness/2), fingerHeight + fingerClearance/2])
      base();
}

module armature_assembly(x_a, z_a) {
  x_travel = toteTopWidth;
  z_travel = fingerHeight*2 + fingerClearance;

  translate([x_a * x_travel, 0, z_a * z_travel])
    armature();

  armAssembly(z_a);
}

module tote_assembly(x_a, z_a) {
  x_travel = toteTopWidth;
  z_travel = fingerHeight + fingerClearance/2;

  if (z_a < 0.5) {
    translate([x_a * x_travel, 0, fingerHeight + fingerClearance/2])
      scale([0.99, 0.99, 0.99])
        tote(); 
  } else {
    translate([x_a * x_travel, 0, fingerHeight+fingerClearance/2 + (z_a-0.5)*2*(fingerHeight + fingerClearance/2)])
      scale([0.99, 0.99, 0.99])
        tote(); 
  }
}

/*******************************************************************************
********************************************************************************
*******************************************************************************/
// Animation

module animation() {
  t = $t * 3;

  stage1_t = 0.5;
  stage2_t = 1.0;
  stage3_t = 0.5;
  stage4_t = 1.0;

  base_assembly();
  if (t < 0.5) {
    armature_assembly(0, t*2);
    tote_assembly(0, t*2);
  } else if (t < 1.5) {
    armature_assembly(t-0.5, 1);
    tote_assembly(t-0.5, 1);
  } else if (t < 2) {
    armature_assembly(1, 1-(t-1.5)*2);
    tote_assembly(1, 1-(t-1.5)*2);
  } else if (t < 3) {
    armature_assembly(1-(t-2), 0);
    tote_assembly(1, 0);
  }
}

for (x = [-1:1])
  translate([x*toteTopWidth, 0, 0])
    animation();
