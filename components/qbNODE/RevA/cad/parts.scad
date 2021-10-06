$PCB_THICKNESS = 1.2;
$PCB_COLOUR = "white";
$FRAME_COLOUR = "lightgreen";
$CONTACTS = 5;

// All measurements in mm 
$BOLT_DIA = 3;
$BOLT_TAP_DRILL_DIA = 2.5;
$BOLT_HOLE_PRINT_TOLERANCE_DIA = 0.3;
$BOLT_COUNTERSINK_DIA = 6;
$BOLT_COUNTERSINK_DEPTH = 3;

module pcbSubtraction($pcb_thickness,$thickness_padding,$y_padding) {
    translate([-$thickness_padding/2,-25-$y_padding,-25]) color($FRAME_COLOUR) cube([$pcb_thickness+$thickness_padding,50+($y_padding*2),50]);
}

module pcb($pcb_thickness) {
   translate([0,-25,-25]) color($PCB_COLOUR) cube([$pcb_thickness,50,50]);
}


module cubeCap() {
    difference() {
        translate([0,0,0]) color($FRAME_COLOUR) linear_extrude(height=10, twist=0)
        polygon(points=[[-30,32.5],[30,32.5],[32.5,30],[32.5,20],[32.5,-20],[32.5,-30],[30,-32.5],[-30,-32.5],[-32.5,-30],[-32.5,-20],[-32.5,20],[-32.5,30]]);
        
        union() {
            translate([0,0,-1]) color($FRAME_COLOUR) linear_extrude(height=12, twist=0)
            polygon(points=[[-20,25],[20,25],[25,20],[25,-20],[20,-25],[-20,-25],[-25,-20],[-25,20]]);
            for (i=[0, 90, 180, 270]) rotate(i) {
                translate([30,0,30]) pcbSubtraction($PCB_THICKNESS,0.5,1);
                translate([-26,26,-1]) color($FRAME_COLOUR) cylinder(d=$BOLT_DIA+$BOLT_HOLE_PRINT_TOLERANCE_DIA,h=12,$fn=36);
                translate([-26,26,-1]) color($FRAME_COLOUR) cylinder(d=$BOLT_COUNTERSINK_DIA,h=$BOLT_COUNTERSINK_DEPTH,$fn=36);
            }      
        }    
    }
}

module qbNODE() {
    translate([0,0,60]) rotate([0,180,0]) cubeCap(); // top
    cubeStandoffs();
    cubeHardware();
    cubeCap(); // bottom   
}

module cubeStandoffs() {
    difference() {
        for (i=[0, 90, 180, 270]) rotate(i) {
            translate([-26.5,-26.5,10]) color($FRAME_COLOUR) cylinder(d=10,h=40,$fn=36);       
        }
        for (i=[0, 90, 180, 270]) rotate(i) {
            translate([30,0,30]) pcbSubtraction($PCB_THICKNESS,0.5,0.5);
            translate([-26,26,9]) color($FRAME_COLOUR) cylinder(d=$BOLT_TAP_DRILL_DIA+$BOLT_HOLE_PRINT_TOLERANCE_DIA,h=42,$fn=36);
        }
    }
}

module cubeHardware() {
    for (i=[0, 90, 180, 270]) rotate(i) {
        translate([30,0,30]) pcb($PCB_THICKNESS);
        translate([31.2,-12.5,30]) mountingContacts($CONTACTS);
        translate([31.2,12.5,30]) mountingPads($CONTACTS);
    }
}

module mountingPads($pins) {
    // All measurements are approximate. Consider this an analog, not a realistic model
    translate([0,-(($pins*2.5)/2)+.25,-3.5]) union() {
        for (i=[0:$pins-1])  {
            color("gold") translate([0.02,i*(0.5+2),0]) cube([0.1,2,7]);
        }
        color("white") translate([0.01,-.25,0]) cube([0.1,$pins*2.5,7]);
    }
}

module mountingContacts($pins) {
    // All measurements are approximate. Consider this an analog, not a realistic model
    translate([0,0,3.5]) union() {
        translate([2.54,-0.5+((($pins-1)/2)*2.54),0])
        for (i=[0:$pins-1])  {
            translate([0,-(i*(2.54)),0]) rotate([0,-90,-90]) color("gold") linear_extrude(height=1, twist=0) polygon(points=[[0,0],[-3.5,0],[-1,1.27],[0,1.27]]);
        }
        color("black") translate([0,-($pins*2.77)/2,-6.5]) cube([2.54,$pins*2.77,7]);
    }
}

qbNODE();
//translate([0,-66,0]) qbNODE();
//translate([66,0,0]) qbNODE();
//translate([0,66,0]) qbNODE();
//translate([-66,0,0]) qbNODE();

