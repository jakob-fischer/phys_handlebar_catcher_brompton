// author: Jakob Fischer (jakob@automorph.info)
// date: 3/26/2014
// description: 3d-model for replacement of the handlebar catcher 
// on brompton bicycles. 
// 
// Print with ABS (20% infill) the size was fitting well. But after
// some days it broke. The second attempt with PLA (100% infill) is a 
// little bit to tight. Maybe the value of 'y_dist' has to be increased
// slightly. Write me your experiences.

// Precission of round parts
$fn =50;

// Data of the arm structures
arm_d = 13.6;          // outer diameter of cylinder
arm_inner_d = 6;       // inner diameter
arm_hole_d = 4.2;      // diameter of arm inner "hole"
arm_width = 5;         // width of arm (cube structure)
arm_length = 17;       // distance of center of arm's cylinder to surface of central cylinder 

// Data for the central ("head") part
center_d = 19;              // Diameter of central part ("head")
screw_d = 8;                // Diameter of screw
screw_head_d = 14.2;        // Diameter of screw head
screw_head_depth = 10;      


// Parameters that affect the "nose" + entire structure
height = 24;                  // height of entire structure
nose_width = 5;               // width of "nose" structure           
nose_length = 4.7;            // length of the nose measured from outer surface of central cylinder

central_cutout_d = 12.5;    // diameter of the cylindrical cutout (where the part mounted to the handlebars go
y_dist = 22;              // distance between center part of the two heads

// rotation of arms from x-axis
alpha = atan((y_dist/2)/(center_d+arm_length));


//
//

module arm() {
    difference() {
       union() {
           cylinder(h=height, r=arm_d/2, center=true);
           translate([-arm_length/2-0.3,0,0])
           cube([arm_length+0.3, arm_width, height], center=true);
       }

       translate([0,(arm_inner_d/2-arm_hole_d/2),0])
       cylinder(h=height+1, r=arm_hole_d/2, center=true);
       translate([0,0,height/2-screw_head_depth])
       cylinder(h=height, r=arm_inner_d/2, center=false);

       mirror([0,0,1])
       translate([0,0,height/2-screw_head_depth])
       cylinder(h=height, r=arm_inner_d/2, center=false);
    }
}


//
//

module head() {
    difference() {
        union() {
            // main cylinder
            cylinder(h=height, r=center_d/2, center=true);
            // "nose"
            translate([0,-nose_width/2,-height/2])
            cube([center_d/2+nose_length,nose_width,height]);
        }
         
        cylinder(h=height+1, r=screw_d/2, center=true);
        translate([0,0,height/2-screw_head_depth])
        cylinder(h=height, r=screw_head_d/2, center=false);

        mirror([0,0,1])
        translate([0,0,height/2-screw_head_depth])
        cylinder(h=height, r=screw_head_d/2, center=false);
    }
}


//
// Main part
//

difference() {
union() {
        head();
        rotate(26, [0,0,1])
        translate([arm_length+center_d/2,0,0])
            arm();
    
        mirror([0,1,0])
        rotate(26, [0,0,1])
        translate([arm_length+center_d/2,0,0])
            arm();
    }

    translate([center_d/2+nose_length+central_cutout_d/2,0,0])
        cylinder(r=central_cutout_d/2, h=height+1, center=true);
}
    
