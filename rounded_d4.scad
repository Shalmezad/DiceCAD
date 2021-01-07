//______________________________________________
// DIMENSIONS TO UNITS:
//______________________________________________
function inches(x=1) = x * 10;
function centimeters(x=1) = inches(0.393701 * x);
function millimeters(x=1) = centimeters(x) * 0.1;

// Settings for roundedness
$fa = 6;
$fs = 0.02;


module basic_d4(radius=inches(0.5), spacer=inches(0.25)){
    
    translate([-spacer/2, 0, 0])
    difference(){
        cylinder(h = radius*2, r1 = radius, r2 = radius, center = true);
        translate([radius/2, 0,0])
            cube([radius, radius*2, radius*2], center=true);
    }
    
    
    translate([spacer/2, 0, 0])
    rotate([90,180,0])
    difference(){
        cylinder(h = radius*2, r1 = radius, r2 = radius, center = true);
        translate([radius/2, 0,0])
            cube([radius, radius*2, radius*2], center=true);
    }
    
    cube([spacer, radius*2, radius*2], center=true);
    
}

module fancy_quarter(number="1",
                     full_radius=inches(0.5), 
                     full_spacer=inches(0.25),
                     rounding_radius=inches(0.05))
{
    difference(){
        // DICE BODY:
        union()
        {
            //  FRONT:
            difference()
            {
                //Rounded cylinder
                hull(){
                    // Top edge donut
                    translate([0,0,rounding_radius])
                    rotate_extrude() translate([full_radius - rounding_radius,0,0]) circle(rounding_radius);
                    // Botto edge cylinder
                    translate([0,0,full_radius/2*1.5])
                    cylinder(h = full_radius/2, r1 = full_radius, r2 = full_radius, center = true);
                }
                //Remove the back half (+ a bit on height to make sure it cuts it all
                translate([full_radius/2, 0,full_radius/2])
                    cube([full_radius, full_radius*2, full_radius*1.1], center=true);
            }
            // BACK:
            hull(){
                // Top center left cylinder
                translate([0,full_radius-rounding_radius,rounding_radius])
                rotate([0,90,0])
                cylinder(h = full_spacer / 2, r1 = rounding_radius, r2=rounding_radius);
                // Top center right cylinder
                translate([0,-full_radius+rounding_radius,rounding_radius])
                rotate([0,90,0])
                cylinder(h = full_spacer / 2, r1 = rounding_radius, r2=rounding_radius);
                // Bototm center box
                translate([0,-full_radius,full_radius/2*1.5])
                cube([full_spacer/2, full_radius*2, full_radius / 4]);
            }
        }
    
        // Text
        translate([-inches(0.1),0,-inches(0.0)])
        linear_extrude(inches(0.1), center=true)
        rotate([180,0,-90])
        text(number, size=4, halign="center", valign="center");
    }
}

module fancy_half(numberA="1", numberB="4"){
    fancy_quarter(numberA);
    translate([0,0,inches(0.5)*2])
    rotate([180,0,0])
    fancy_quarter(numberB);
}

module fancy_d4(){
    fancy_half("1", "4");
    translate([inches(0.5)/2,inches(0.5),inches(0.5)])
    rotate([90,180,0])
    fancy_half("2", "3");
}

//basic_d4();
//fancy_half();
fancy_d4();
//fancy_quarter();