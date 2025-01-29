$fn=48;
fuse_d=6.5;
fuse_h=31.75;
banana_d=4;

body_front_d=9; // Measured
body_front_h=6; // Measured

// Under body front
rot_stop_w=1.5; // Measured
rot_stop_depth=2; // Measured
rot_offset=-45; //eyballed

body_mid_d=8; // Measured
body_mid_h=12; // Measured
body_mid_raise=10; // Measured

lock_horz=6; //Kinda measuerd
lock_vert=5; //Kinda measuerd
lock_channel=1.5; //Kinda measuerd

jack_d=6.5; //measured
jack_h=15;
jack_depth=20; // Unknown

split_w=1.5; // Measured
split_depth=1.5; // Measured


total_h=28.2; // Measured

metal_fuse_d=7;
metal_fuse_inner=6.66;
metal_fuse_h=body_mid_raise; // Measured
metal_fuse_depth=8.75; // Measured
metal_jack_inset=5.2; // Measured


module fuse()
{
    cylinder(fuse_h,fuse_d/2,fuse_d/2);
}

module jack()
{
    cylinder(jack_h,jack_d/2,jack_d/2);
}
module plastic()
{
    difference()
    {   
        union(){
        //Body Front
        translate([0,0,body_mid_raise+body_mid_h])cylinder(body_front_h,body_front_d/2,body_front_d/2);
        
        //Rotation stop tab    
            rotate([0,0,rot_offset])
            translate([-body_front_d/2,-rot_stop_w/2,+body_mid_raise+body_mid_h-rot_stop_depth+0.01])
                cube([body_front_d,rot_stop_w,rot_stop_depth]);
        union(){
        // Body mid with lock
            difference(){
        translate([0,0,body_mid_raise])cylinder(body_mid_h,body_mid_d/2,body_mid_d/2);

        union(){
            translate([-lock_channel/2,-500,body_mid_raise])
                cube([lock_channel,1000,lock_vert]);
            translate([-lock_channel/2-lock_horz,0,body_mid_raise+lock_vert-lock_channel])
                cube([lock_horz,1000,lock_channel]);
            rotate([0,0,180])
            translate([-lock_channel/2-lock_horz,0,body_mid_raise+lock_vert-lock_channel])
                cube([lock_horz,1000,lock_channel]);
        }
            }
            
        // Body mid with lock
        translate([0,0,body_mid_raise])cylinder(body_mid_h,(body_mid_d-1)/2,(body_mid_d-1)/2);
        }
        }
        union()
        {
            translate([0,0,body_front_h+body_mid_raise+body_mid_h+jack_h-jack_depth]) jack();
            
            translate([-500,-split_w/2,body_front_h+body_mid_raise+body_mid_h-split_depth+0.01])
                cube([1000,split_w,split_depth]);
            fuse();
        }
    }
}


module metal()
{
difference()
{   
    union()
    {
    cylinder(metal_fuse_h,metal_fuse_d/2,metal_fuse_d/2);
    cylinder(total_h-metal_jack_inset,jack_d/2,jack_d/2);
    }
    cylinder(metal_fuse_h,metal_fuse_inner/2,metal_fuse_inner/2);
    cylinder(1000,banana_d/2,banana_d/2);
}
}
metal();
plastic();