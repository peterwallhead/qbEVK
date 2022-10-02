$PCB_THICKNESS = 1.2;
$PCB_COLOUR = "purple";
$SCREEN_PRINT_COLOUR = "white"; 
$FRAME_COLOUR = "black";
$FRAME_COLOUR_TRANSPARENCY = 1;
$CONTACTS = 5;

// All measurements in mm 
$BOLT_DIA = 3;
$BOLT_HOLE_PRINT_TOLERANCE_DIA = 0.5;
$ENDCAP_PCB_LENGTH_TOLERANCE = 0.25;
$STANDOFF_PCB_CUTOUT_TOLERANCE = 0.5;

module pcbSubtraction($pcb_thickness,$thickness_padding,$y_padding) {
    translate([-$thickness_padding/2,-25-$y_padding,-25]) color($FRAME_COLOUR) cube([$pcb_thickness+$thickness_padding,50+($y_padding*2),50]);
}

module pcb($pcb_thickness) {
   translate([0,-25,-25]) color($PCB_COLOUR) cube([$pcb_thickness,50,50]);
   translate([-30,-30.25,0]) rotate([90,0,0]) color($SCREEN_PRINT_COLOUR) linear_extrude(height=1, twist=0) text("qbEVK", size=1.5, halign="center");
}


module cubeCap() {
    difference() {
        translate([0,0,0]) color($FRAME_COLOUR,$FRAME_COLOUR_TRANSPARENCY) linear_extrude(height=10, twist=0)
        polygon(points=[[-25,32.5],[25,32.5],[32.5,25],[32.5,20],[32.5,-20],[32.5,-25],[25,-32.5],[-25,-32.5],[-32.5,-25],[-32.5,-20],[-32.5,20],[-32.5,25]]);
        
        union() {
            translate([0,0,-1]) color($FRAME_COLOUR) linear_extrude(height=12, twist=0)
            polygon(points=[[-20,25],[20,25],[25,20],[25,-20],[20,-25],[-20,-25],[-25,-20],[-25,20]]);
            for (i=[0, 90, 180, 270]) rotate(i) {
                translate([30,0,30]) pcbSubtraction($PCB_THICKNESS,0.5,$ENDCAP_PCB_LENGTH_TOLERANCE);
                translate([-32,32,5]) rotate([90,0,45]) cylinder(d=$BOLT_DIA+$BOLT_HOLE_PRINT_TOLERANCE_DIA,h=15,$fn=36);
            }      
        }    
    }
}

module qbNODE() {
    cubeHardware();
    cubeCornerCovers();
    translate([0,0,60]) rotate([0,180,0]) cubeCap(); // top
    cubeCap(); // bottom   
}

module cubeCornerCover() {
    difference() {
        translate([-25,32.5,0]) color($FRAME_COLOUR,$FRAME_COLOUR_TRANSPARENCY) linear_extrude(height=60, twist=0)
        polygon(points=[[0,0],[-2.5,0],[-7.5,-5],[-7.5,-7.55]]);
        
        union() {
            translate([-32,32,5]) rotate([90,0,45]) cylinder(d=$BOLT_DIA+$BOLT_HOLE_PRINT_TOLERANCE_DIA,h=15,$fn=36);
            translate([-32,32,55]) rotate([90,0,45]) cylinder(d=$BOLT_DIA+$BOLT_HOLE_PRINT_TOLERANCE_DIA,h=15,$fn=36);
        }
    }
}

module cubeCornerCovers() {
    for (i=[0,90,180,270]) rotate(i) {
        cubeCornerCover();
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
        color($PCB_COLOUR) translate([0.01,-.25,0]) cube([0.1,$pins*2.5,7]);
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

module jigClamp() {
    color("white") difference() {
        union() {
            translate([0,0,0]) linear_extrude(height=8, twist=0)
                polygon(points=[[5,0],[12.5,0],[12.5,-10],[-5,-10],[-10,-5],[-10,12.5],[0,12.5],[0,5]]);

            translate([12.5,-5,0]) cylinder(d=10,h=8,$fn=360);
            translate([-5,12.5,0]) cylinder(d=10,h=8,$fn=360);
            translate([-5,-5,0]) cylinder(d=10,h=8,$fn=360);
        }
        
        union() {
            //Bolt holes
            translate([12.5,-5,-1]) cylinder(d=3.2,h=10,$fn=36);
            translate([-5,12.5,-1]) cylinder(d=3.2,h=10,$fn=36);
            translate([-5,-5,-1]) cylinder(d=3.2,h=10,$fn=36);
            
            //Countersinks
            translate([12.5,-5,5]) cylinder(d=6,h=5,$fn=36);
            translate([-5,12.5,5]) cylinder(d=6,h=5,$fn=36);
            translate([-5,-5,5]) cylinder(d=6,h=5,$fn=36);
            translate([3.75,3.75,-1]) cylinder(d=12,h=10,$fn=360);
            
        }
    }
    
    
}

// Uncomment to render mockup images of complete node
qbNODE();

// Uncomment to generate STL exports
//translate([0,25,-40]) rotate([90,45,0]) cubeCornerCover();
//cubeCap();
//jigClamp();
