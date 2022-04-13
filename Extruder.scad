//Direct granules extruder
//https://homofaciens.de/technics-machines-3D-printer-Granule-Extruder_ge.htm

thread_d = 4.2;
nail_d = 3.2;
M4_hole = 4.2;
M4_head = 8;
M4_nut_e = 7.66+1.0;
M5_nut_e = 8.79+1.0;
M6_nut_e = 11.05+1.5;
M8_nut_e = 14.38+1.5;
M3_hole = 3.3;
M3_nut_e = 6.3;
$fn=200;
alu_edge = 16.2;
motor_e = 42;
motor_l = 40;
motor_m = 31;

motor_shaft = 5.5;
motor_shaft_shift = 4.9;


bowl_d = 70;
bowl_h = 65;
bowl_wall = 3;

//Motor mount
//mm_r = 22;
mm_d1 = motor_e + 15;
mm_d2 = motor_l - 5;
motor_m = 31;

//Ball bearing
bb_do = 22;
bb_di = 8;
bb_w = 7;

extuder_m_x = 60;

Assembled = 0;
Part = 1;



if(Assembled){
  translate([0, 0, 0])rotate([90, 0, 0]){
    hopper();
  }
  translate([0, -70, 72])rotate([0,0,270]){
    motor_mount_2(type=1);
  }
  translate([0, 45, 47])rotate([0,0,270]){
    motor_mount_2(type=2);
  }
  translate([-25, -45, 75])rotate([0,180,0]){
    translate([-25, 0, 5]){
      gear(teeth=89,h=10, shaft=bb_do+0.3);  
      translate([0, 0, 10]){
        rotate([0, 0, 0])motor_coupler_2();
      }
    }
  }
  translate([0, -100, 60])rotate([0,0,-5]){
    gear(teeth=20,h=10, shaft=-1);
  }
}
else{
  if (Part == 1) {
      motor_mount_2(type = 1);
  } else if (Part == 2) {
      motor_mount_2(type=2);
  } else if (Part == 3) {
      gear(teeth=20,h=10, shaft=-1);
  } else if (Part == 4) {
      gear(teeth=89,h=10, shaft=bb_do+0.3);  
  } else if (Part == 5) {
    hopper(mode = 2);
  } else if (Part == 6) {
      hopper(mode = 1);
  }else {

 stirrer_20();
 stirrer();

  }
  

}



translate([30, 35, -15]){
//  rotate([0, 0, -9]) gear(teeth=30,h=10, shaft=-1);
}


/*
rotate([0*180, 0, 0]){
  translate([-25, 0, 5]){
    gear(teeth=89,h=10, shaft=bb_do+0.3);  
    translate([0, 0, 10]){
      rotate([0, 0, 0])motor_coupler_2();
    }
  }
}
*/
//motor_coupler_2(insert=1);



translate([14.5+31/2, 15.5-31/2, 15]){
//  rotate([0, 180, 12]) gear_out(teeth=52,h=10);
}

//strainer();

module strainer(){
  s_d = 100;
  s_h = 100;
  s_wall = 5;
  
  translate([0, 0, s_h/2]){
    difference(){
      cylinder(d=s_d, h=s_h, center=true);
      cylinder(d=s_d-2*s_wall, h=s_h*1.1, center=true);
    }
  }
  
}

module gear(teeth = 10,h = 5, shaft=M3_hole){
  mod = 3;
  alpha = 180/teeth;
  r1 = mod*teeth/(2*3.14159);
  r=(mod/2)/tan(alpha);
  
  difference(){
    linear_extrude(height=h){
      for(i=[0:1:teeth]){
        rotate([0, 0, i*360/teeth]){
          x1=r;
          y1=mod/2;
          x2=r+mod;
          y2=0;
          x3=r;
          y3=-mod/2;
          x4=0;
          y4=0;
          polygon(points=[[x1,y1],[x2,y2],[x3,y3],[x4,y4]]);
        }
      }
    }
    translate([0, 0, h/2]){
      cylinder(d=shaft, h=h*1.1, center=true);
    }
    if(shaft==-1){
      translate([0, 0, h/2]){
        difference(){
          cylinder(d=motor_shaft, h=h*1.1, center=true);
          translate([0, motor_shaft_shift, 0]){
            cube(size=[motor_shaft, motor_shaft, 16], center=true);
          }
        }
      }
    }
  }
  
}

module gear_out(teeth = 10,h = 5){
  mod = 3.5;
  alpha = 180/teeth;
  r1 = mod*teeth/(2*3.14159);
  r = (mod/2)/tan(alpha);
  top = 3;
  support = 0.4;
  
  difference(){
    union(){
      translate([0, 0, (h+top)/2+0.05]){
        cylinder(r=r+7, h=h+top, center=true);
      }
      translate([0, 0, h+top+5]){
        cylinder(d=25, h=10, center=true);
      }
      difference(){
        translate([0, 0, h+top+5]){
          cylinder(r=r+7, h=10, center=true);
        }
        translate([0, 0, h+top+5]){
          cylinder(r=r+7-support, h=11, center=true);
        }
      }


    }
    translate([0, 0, h+top+5+0.05]){
      cylinder(d=M8_nut_e, h=10, center=true, $fn=6);
    }
    translate([0, 0, h/2]){
      cylinder(d=5.1, h=h+top, center=true);
    }
    
    linear_extrude(height=h){
      for(i=[0:1:teeth]){
        rotate([0, 0, i*360/teeth]){
          x1=r;
          y1=mod/2;
          x2=r+mod;
          y2=0;
          x3=r;
          y3=-mod/2;
          x4=0;
          y4=0;
          polygon(points=[[x1,y1],[x2,y2],[x3,y3],[x4,y4]]);
        }
      }
    }
  }
  
}

module part_fan(){
  //Fan dimensions
  pf_d = 40;
  pf_edge = 43;
  pf_holes = 32.5;
  pf_shift = 15;
  pf_shift2 = 1.5;
  pf_shift3 = 5;
  pf_wall = 1.5;
  pf_m_dis = 40;
  pf_m_l = 30;
  pf_m_wall = 3.4;
  pf_m_shift = 26;
  pf_tip_angle = 20;
  pf_b_wall = 15;
  pf_gap = 2;
  pf_h = pf_b_wall + 16;
  pf_r = 5;

  pf_m_h = pf_b_wall + pf_wall+10;


  //Fan body
  difference(){
    union(){
      difference(){
        a=10;
        b=(pf_edge-a)/pf_edge;
        roundedRect(size=[pf_edge, pf_edge, pf_b_wall+pf_wall], radius=pf_r, edges=[1, 1, 0, 0], vscale=[1,b], shift=a);
        translate([0, 19, 10]){
//          cube(size=[pf_edge*1.1, 10, pf_b_wall], center=true);
        }        
      }
      //Mount flaps
      translate([(pf_edge-pf_m_wall)/2, pf_m_shift, pf_m_h/2]){
        hull(){
          translate([0, pf_m_l/2, pf_m_h/2]){
            cube(size=[pf_m_wall, 0.1, 0.1], center=true);
          }
          translate([0, -pf_m_l/2, pf_m_h/2-10]){
            cube(size=[pf_m_wall, 0.1, 0.1], center=true);
          }
          translate([0, -pf_m_l/2+10, pf_m_h/2]){
            cube(size=[pf_m_wall, 0.1, 0.1], center=true);
          }
          translate([0, -pf_m_l/2, -pf_m_h/2]){
            cube(size=[pf_m_wall, 0.1, 0.1], center=true);
          }
          translate([0, pf_m_l/2, -pf_m_h/2]){
            cube(size=[pf_m_wall, 0.1, 0.1], center=true);
          }
        }
//        cube(size=[pf_m_wall, pf_m_l, pf_m_h], center=true);
      }
      translate([-(pf_edge-pf_m_wall)/2, pf_m_shift, pf_m_h/2]){
        hull(){
          translate([0, pf_m_l/2, pf_m_h/2]){
            cube(size=[pf_m_wall, 0.1, 0.1], center=true);
          }
          translate([0, -pf_m_l/2, pf_m_h/2-10]){
            cube(size=[pf_m_wall, 0.1, 0.1], center=true);
          }
          translate([0, -pf_m_l/2+10, pf_m_h/2]){
            cube(size=[pf_m_wall, 0.1, 0.1], center=true);
          }
          translate([0, -pf_m_l/2, -pf_m_h/2]){
            cube(size=[pf_m_wall, 0.1, 0.1], center=true);
          }
          translate([0, pf_m_l/2, -pf_m_h/2]){
            cube(size=[pf_m_wall, 0.1, 0.1], center=true);
          }
        }
//        cube(size=[pf_m_wall, pf_m_l, pf_m_h], center=true);
      }
    }
    translate([0, 0, pf_b_wall/2]){
      difference(){
        difference(){
          cylinder(d=pf_d, h=pf_b_wall*1.5, center=true);
          translate([0, 17, 0]){
            rotate([46.5, 0, 0]){
              cube(size=[pf_edge*1.1, 10, pf_b_wall*3], center=true);
            }
          }
        }
        translate([0, pf_edge/2, pf_b_wall/2+pf_wall/2]){
          cube(size=[pf_edge*1.1, pf_shift*2+8, pf_wall], center=true);
        }
      }
    }
    translate([pf_holes/2, pf_holes/2, pf_b_wall/2]){
      cylinder(d=3, h=pf_b_wall*1.1, center=true);
    }
    translate([-pf_holes/2, pf_holes/2, pf_b_wall/2]){
      cylinder(d=3, h=pf_b_wall*1.1, center=true);
    }
    translate([-pf_holes/2, -pf_holes/2, pf_b_wall/2]){
      cylinder(d=3, h=pf_b_wall*1.1, center=true);
    }
    translate([pf_holes/2, -pf_holes/2, pf_b_wall/2]){
      cylinder(d=3, h=pf_b_wall*1.1, center=true);
    }
    
    //Cut part fan mount long hole
    pf_m_y = 30;
    pf_m_z = 22;
    pf_m_l2 = 10;
    translate([0, pf_m_y+pf_m_l2/2, pf_m_z]){
      rotate([0, 90, 0]){
        cylinder(d=M3_hole, h=pf_edge*1.1, center=true);
      }
    }
    translate([0, pf_m_y-pf_m_l2/2, pf_m_z]){
      rotate([0, 90, 0]){
        cylinder(d=M3_hole, h=pf_edge*1.1, center=true);
      }
    }
    translate([0, pf_m_y, pf_m_z]){
      cube(size=[pf_edge*1.1, pf_m_l2, M3_hole], center=true);
    }
  }
  
  //Nozzle
  difference(){
    shiftX=(pf_edge-pf_shift)-pf_gap/2-pf_wall*2+pf_shift2;
    translate([0, -shiftX+0.5, pf_b_wall]){
      scaleY = (pf_gap+2*pf_wall)/(pf_edge-pf_shift);
      linear_extrude(height=pf_h-pf_b_wall, scale=[1,scaleY]){
        translate([0, shiftX, 0]){
          hull(){
            translate([pf_edge/2-pf_r, pf_r-pf_edge/2, 0]){
              circle(r=pf_r, center=true);
            }
            translate([-pf_edge/2+pf_r, pf_r-pf_edge/2, 0]){
              circle(r=pf_r, center=true);
            }
            translate([0, pf_edge/2-pf_r-pf_shift, 0]){
              square(size=[pf_edge, pf_r*2], center=true);
            }
          }
        }
      }
    }
    shiftX2=(pf_edge-pf_shift)-pf_gap/2+pf_shift2-pf_shift3;
    translate([0, -shiftX2, pf_b_wall-0.1]){
      scaleY = (pf_gap)/(pf_edge-pf_shift);
      linear_extrude(height=pf_h-pf_b_wall+0.2, scale=[1,scaleY]){
        translate([0, shiftX2, 0]){
          hull(){
            translate([pf_edge/2-pf_r-pf_wall, pf_r-pf_edge/2+pf_wall*2, 0]){
              circle(r=pf_r, center=true);
            }
            translate([-pf_edge/2+pf_r+pf_wall, pf_r-pf_edge/2+pf_wall*2, 0]){
              circle(r=pf_r, center=true);
            }
            translate([0, pf_edge/2-pf_r-pf_shift-pf_wall*2, 0]){
              square(size=[pf_edge-2*pf_wall, pf_r*2-pf_wall*2], center=true);
            }
          }
        }
      }
    }

    //Cut nozzle tip angle
    translate([0, -pf_edge/2-5, 39]){
      rotate([pf_tip_angle, 0, 0]){
//        cube(size=[pf_edge*1.1, 20, 20], center=true);
      }
    }

  }

  
}


module cold_end(){
  
  translate([0, 0, alu_edge/2]){
    difference(){
      translate([alu_edge/4, 0, 0]){
        cube(size=[alu_edge/2, 70, alu_edge], center=true);
      }
      cylinder(d1=10, d2=6, h=alu_edge*1.1, center=true);
    }
  }
  
  
}


module hot_end(){  
  translate([0, -43, 45]){
    rotate([90, 0, 0]){
      cube(size=[35, alu_edge, alu_edge], center=true);
      translate([0, 0, alu_edge/2+3]){
        cylinder(d1=8, d2=1, h=6, center=true);
      }
    }
  }
}

module stirrer(){
  s_d = 23;
  s_di = 9;
  s_w = 11;
  s_h = 10;
  s_h2 = 25;
  s_wall = 2;
  s_flaps = 2;
  s_flaps_gap = 10;
  s_angle = 17;
  mirror([1, 0, 0]){
    translate([0, 0, s_h2/2]){
      difference(){
        intersection(){
          cylinder(d=s_d, h=s_h2, center=true);
          cube(size=[s_d, s_w, s_h2], center=true);
        }
        translate([0, 0, s_h]){
          cube(size=[s_di, s_d, s_h2], center=true);
        }
        cylinder(d=8.2, h=s_h2*1.1, center=true);        
        translate([7, 0, -s_h2/2]){
          cube(size=[3.5,5.6,20], center=true);
        }
        translate([-7, 0, -s_h2/2]){
          cube(size=[3.5,5.6,20], center=true);
        }
        translate([0, 0, 5-s_h2/2]){
          rotate([0, 90, 0]){
            cylinder(d=M3_hole, h=s_d*1.1, center=true);
          }
        }
        difference(){
          union(){
            translate([s_d/2-2, 0, s_h2+1]){
              rotate([-s_angle, -20, 0]){
                cube(size=[s_d, s_d, s_h2], center=true);
              }
            }
            translate([-s_d/2+2, 0, s_h2+1]){
              rotate([s_angle, 20, 0]){
                cube(size=[s_d, s_d, s_h2], center=true);
              }
            }
          }
          cylinder(d=s_di, h=s_h*2, center=true);
        }

      }
    }
  }
}

module stirrer_20(){
  s_d = 20;
  s_di = 10;
  s_h = 20;
  s_wall = 4;
  s_flaps = 3;
  s_flaps_gap = 7;
  s_angle = 17;
  mirror([1, 0, 0]){
    translate([0, 0, s_h/2]){
      difference(){
        cylinder(d=s_d, h=s_h, center=true);
        cylinder(d=M3_hole, h=s_h*1.1, center=true);
        translate([0, 0, s_wall]){
          cylinder(d=s_di, h=s_h, center=true);
        }
        for(i=[0:1:s_flaps-1]){
          rotate([0, 0, i*360/s_flaps]){
            translate([s_d/2, 0, s_wall]){
              rotate([0, 0, s_angle]){
                cube(size=[28, s_flaps_gap, s_h], center=true);
                translate([s_d/2, 0, -s_h/2-s_wall-0.1]){
                  linear_extrude(height=s_wall*1.1, scale=[1.3,1]){
                    square(size=[24, s_flaps_gap], center=true);
                  }
                }
              }
            }
          }
        }
      }
    }
  }
}

module stirrer_25(){
  s_d = 25;
  s_di = 17;
  s_h = 20;
  s_wall = 4;
  s_flaps = 3;
  s_flaps_gap = 10;
  s_angle = 17;
  mirror([1, 0, 0]){
    translate([0, 0, s_h/2]){
      difference(){
        cylinder(d=s_d, h=s_h, center=true);
        cylinder(d=M3_hole, h=s_h*1.1, center=true);
        translate([0, 0, s_wall]){
          cylinder(d=s_di, h=s_h, center=true);
        }
        for(i=[0:1:s_flaps-1]){
          rotate([0, 0, i*360/s_flaps]){
            translate([s_d/2, 0, s_wall]){
              rotate([0, 0, s_angle]){
                cube(size=[40, s_flaps_gap, s_h], center=true);
                translate([s_d/2, 0, -s_h/2-s_wall-0.1]){
                  linear_extrude(height=s_wall*1.1, scale=[1.3,1]){
                    square(size=[30, s_flaps_gap], center=true);
                  }
                }
              }
            }
          }
        }
      }
    }
  }
}

module motor_coupler_2(nut=M8_nut_e, insert=0){
  mc_d = 26;
  extra_h = 5*0;
  mc_h = 27+extra_h;
  mc_shaft_h = 15;
  mc_wall = 2;
  mc_shaft = motor_shaft;
  mc_shaft_shift = motor_shaft_shift;
  
  a = mc_h-mc_shaft_h-mc_wall;
  if(insert==0){  
    difference(){
      translate([0, 0, mc_h/2]){
        cylinder(d=mc_d, h=mc_h, center=true);
      }
      
      //Center nut hole
      translate([0, 0, mc_h-a/2+0.1]){
        cylinder(d=nut, h=a, center=true, $fn=6);
      }

      // Center hole stepper motor shaft
      translate([0, 0, mc_shaft_h-1.1]){
        rotate([90, 0, 0]){
          cylinder(d=2, h=mc_d*2, center=true);
        }
      }
      translate([0, 0, mc_shaft_h/2-0.1]){
        cylinder(d=bb_do+0.3, h=mc_shaft_h, center=true);
      }
    }
  }
  else{
    //Insert M5
    translate([0, 60, a/2]){
      difference(){
        cylinder(d=nut-0.2, h=a, center=true, $fn=6);
        cylinder(d=M5_nut_e, h=a+0.1, center=true, $fn=6);
      }
    }
    //Insert M4
    translate([20, 60, a/2]){
      difference(){
        cylinder(d=nut-0.2, h=a, center=true, $fn=6);
        cylinder(d=M4_nut_e, h=a+0.1, center=true, $fn=6);
      }
    }
  }
  
  

}


module motor_coupler(nut=M4_nut_e){
  mc_d = 25;
  extra_h = 5*0;
  mc_h = 22+extra_h;
  mc_shaft_h = 10;
  mc_wall = 2;
  mc_shaft = motor_shaft;
  mc_shaft_shift = motor_shaft_shift;
  
  difference(){
    translate([0, 0, mc_h/2]){
      cylinder(d=mc_d, h=mc_h, center=true);
    }
    
    //Center nut hole
    a = mc_h-mc_shaft_h-mc_wall;
    translate([0, 0, mc_h-a/2+0.1]){
      cylinder(d=nut, h=a, center=true, $fn=6);
    }

    // Center hole stepper motor shaft
    translate([0, 0, mc_shaft_h-1.1]){
      rotate([90, 0, 0]){
        cylinder(d=2, h=mc_d*2, center=true);
      }
    }
    translate([0, 0, mc_shaft_h/2-0.1]){
      difference(){
        cylinder(d=mc_shaft, h=mc_shaft_h, center=true);
        translate([0, mc_shaft_shift, 0]){
          cube(size=[mc_shaft, mc_shaft, 16], center=true);
        }
      }
    }


  }

}

module motor_coupler_old(part=0){
  mci_d = 19.5;
  mci_d2 = 12;
  mci_h = 7;
  mci_cut_l = 11;
  mci_cut_a = -10;
  
  mco_d = 25;
  mco_wall = 2;
  mco_wall2 = 16;
  mco_h = 34;
  mco_shaft = 5.4;
  mco_shaft_shift = 4.8;

  shaft_d = 3;
  shaft_d2 = 3.5;
  
  if(part==0 || part==1){
    //Inner part
    translate([0, 0, mci_h/2]){
      difference(){
        cylinder(d=mci_d, h=mci_h, center=true);
        cylinder(d=3.2, h=mci_h*1.1, center=true);
          for(i=[0:90:90]){
            rotate([0, 0, i]){
              rotate([90, 0, 0]){
                cylinder(d=shaft_d, h=mco_d*1.1, center=true);
              }
            }
          }
      }
    }
  }

  if(part==0 || part==2){
    //Outer part  
    translate([(mci_d + mco_d)/2+3, 0, mco_h/2]){
      difference(){
        cylinder(d=mco_d, h=mco_h, center=true);

/*        
        // Retract slits
        translate([0, 0, 12]){
          for(i=[0:180:270]){
            rotate([0, 0, i]){
              // +-mci_d/2 to mirror pitch
              translate([-mci_d/2, 0, 0]){
                rotate([mci_cut_a, 0, 0]){
                  cube(size=[mci_d, mci_cut_l, shaft_d2], center=true);
                  translate([0, mci_cut_l/2]){
                    rotate([0, 90, 0]){
                      cylinder(d=shaft_d2, h=mci_d, center=true);
                    }
                  }
                  translate([0, -mci_cut_l/2]){
                    rotate([0, 90, 0]){
                      cylinder(d=shaft_d2, h=mci_d, center=true);
                    }
                  }
                }
              }
            }
          }
        }
*/
        // Vertical retract hole2
        translate([0, 0, 12]){
          rotate([0, 90, 0]){
            hull(){
              translate([1, 0, 0]){
                cylinder(d=shaft_d2, h=mco_d*10, center=true);
              }
              translate([-1, 0, 0]){
                cylinder(d=shaft_d2, h=mco_d*10, center=true);
              }
            }
          }
        }
        // No retract hole
        translate([0, 0, 12]){
          rotate([0, 90, 90]){
            cylinder(d=shaft_d2, h=mco_d*10, center=true);
          }
        }
        // Center hole stepper motor shaft
        translate([0, 0, mco_wall2]){
          cylinder(d=mco_d-2*mco_wall, h=mco_h, center=true);
        }
        translate([0, 0, -(mco_h-mco_wall2)/2-2]){
          difference(){
            cylinder(d=mco_shaft, h=mco_wall2, center=true);
            translate([0, mco_shaft_shift, 0]){
              cube(size=[mco_shaft, mco_shaft, mco_wall2], center=true);
            }
          }
        }
      }
    }
  }
  
}

module motor_coupler_x(){
  mci_d = 16;
  mci_d2 = 12;
  mci_h = 7;
  mci_cut_l = 6.5;
  mci_cut_a = -10;
  
  mco_d = 30;
  mco_wall = 5;
  mco_wall2 = 7;
  mco_h = 20;
  mco_shaft = 5;
  mco_shaft_shift = 4.5;

  shaft_d = 3;
  shaft_d2 = 3.3;
  
  //Inner part
  translate([0, 0, mci_h/2]){
    difference(){
      cylinder(d=mci_d, h=mci_h, center=true);
      cylinder(d=M3_hole, h=mci_h*1.1, center=true);
      difference(){
        union(){
          for(i=[0:90:270]){
            rotate([0, 0, i]){
              translate([mci_d/2, 0, 0]){
                rotate([mci_cut_a, 0, 0]){
                  cube(size=[mci_d, mci_cut_l, shaft_d2], center=true);
                  translate([0, mci_cut_l/2]){
                    rotate([0, 90, 0]){
                      cylinder(d=shaft_d2, h=mci_d, center=true);
                    }
                  }
                  translate([0, -mci_cut_l/2]){
                    rotate([0, 90, 0]){
                      cylinder(d=shaft_d2, h=mci_d, center=true);
                    }
                  }
                }
              }
            }
          }
        }
        cylinder(d=mci_d2, h=mci_h*1.1, center=true);
      }
    }
  }

  //Outer part  
  translate([(mci_d + mco_d)/2+3, 0, mco_h/2]){
    difference(){
      cylinder(d=mco_d, h=mco_h, center=true);
      translate([0, 0, 6]){
        for(i=[0:90:90]){
          rotate([0, 0, i]){
            rotate([90, 0, 0]){
              cylinder(d=shaft_d, h=mco_d*1.1, center=true);
            }
          }
        }
      }
      translate([0, 0, mco_wall2]){
        cylinder(d=mco_d-2*mco_wall, h=mco_h, center=true);
      }
      difference(){
        cylinder(d=mco_shaft, h=mco_h*1.1, center=true);
        translate([0, mco_shaft_shift, 0]){
          cube(size=[mco_shaft, mco_shaft, mco_h], center=true);
        }
      }
    }
    
  }
  
}

module motor_mount_2(type = 0){
  mm_distance = 55;
  mm_distance2 = 95;
  mm_wall = 3;
  mm_l1 = 110;
  mm_l2 = 60;
  mm_l3 = mm_l1 - mm_l2;
  mm_l4 = 45;
  mm_w1 = 50;
  mm_w2 = mm_distance2+20;
  mm_center_1 = 23;
  mm_center_2 = 30;
  motor_shift = 35;
  mount_shift = 25;
  
  mm_h1 = 10;
  mm_h2 = 20;
  
  //Mount plate on motor side
  if(type == 0 || type == 1){
    translate([0, 0, 0]){
      difference(){
        union(){
          //Base plate
          translate([mm_l2/2, 0, 0]){
            roundedRect(size=[mm_l2, mm_w1, mm_wall], radius=5, edges=[0,1,0,1]);
          }
          translate([-mm_l3/2, 0, mm_wall/2]){
            cube(size=[mm_l3, mm_w2, mm_wall], center=true);
          }
          //walls
          translate([-mm_l3/2, (mm_w2-mm_wall)/2, mm_h2/2]){
            cube(size=[mm_l3, mm_wall, mm_h2], center=true);
          }
          translate([-mm_l3/2, -(mm_w2-mm_wall)/2, mm_h2/2]){
            cube(size=[mm_l3, mm_wall, mm_h2], center=true);
          }
          translate([0, 0, mm_h2/2]){
            cube(size=[mm_wall, mm_w2, mm_h2], center=true);
          }
          translate([-mm_l3, 0, mm_h2/2]){
            cube(size=[mm_wall, mm_w2, mm_h2], center=true);
          }

          translate([mm_l2/2-4, mm_w1/2, mm_h2/2]){
            rotate([0, 90, 90]){
              roundedRect(size=[mm_h2, mm_l2-5, mm_wall], radius=5, edges=[1,0,0,0]);
            }
          }
          translate([mm_l2/2-4, -mm_wall-mm_w1/2, mm_h2/2]){
            rotate([0, 90, 90]){
              roundedRect(size=[mm_h2, mm_l2-5, mm_wall], radius=5, edges=[1,0,0,0]);
            }
          }
          // Enforecements main gear shaft
          translate([-mount_shift, 0, mm_h2/2]){
            cylinder(d=25, h=mm_h2, center=true);
          }

          translate([-mount_shift, 0, mm_h2/2]){
            cube(size=[mm_wall, mm_w2, mm_h2], center=true);
          }
          translate([-mount_shift, 0, mm_h2/2]){
            cube(size=[mm_l3, mm_wall, mm_h2], center=true);
          }

        }
        
        //Motor center hole
        hull(){
          translate([motor_shift, 0, mm_wall/2]){
            cylinder(d=mm_center_1, h=mm_wall*1.1, center=true);
          }
          translate([motor_shift-15, 0, mm_wall/2]){
            cylinder(d=mm_center_1, h=mm_wall*1.1, center=true);
          }
        }

       
        //Motor mount plate holes
        translate([-mount_shift, 0, 0]){
          translate([motor_m/2, mm_distance2/2, mm_wall/2]){
            cylinder(d=M3_hole, h=mm_wall*1.1, center=true);
          }
          translate([-motor_m/2, mm_distance2/2, mm_wall/2]){
            cylinder(d=M3_hole, h=mm_wall*1.1, center=true);
          }
          translate([-motor_m/2, -mm_distance2/2, mm_wall/2]){
            cylinder(d=M3_hole, h=mm_wall*1.1, center=true);
          }
          translate([motor_m/2, -mm_distance2/2, mm_wall/2]){
            cylinder(d=M3_hole, h=mm_wall*1.1, center=true);
          }
          translate([0, 0, mm_h2/2]){
            cylinder(d=8.2, h=mm_h2*1.1, center=true);
          }
        }


        //Motor mount holes
        translate([motor_shift, 0, 0]){
          for(i=[0:1:1])mirror([0,i,0]){
            hull(){
              translate([motor_m/2, motor_m/2, mm_wall/2]){
                cylinder(d=M3_hole, h=mm_wall*1.1, center=true);
              }
              translate([motor_m/2-15, motor_m/2, mm_wall/2]){
                cylinder(d=M3_hole, h=mm_wall*1.1, center=true);
              }
            }
            hull(){
              translate([-motor_m/2, motor_m/2, mm_wall/2]){
                cylinder(d=M3_hole, h=mm_wall*1.1, center=true);
              }
              translate([-motor_m/2-15, motor_m/2, mm_wall/2]){
                cylinder(d=M3_hole, h=mm_wall*1.1, center=true);
              }
            }
          }

        }
      }
    }
  }
  
  //Mount plate on hopper side
  if(type == 0 || type == 2){
    translate([90, 0, 0]){
        difference(){
          union(){
            roundedRect(size=[mm_l4, mm_w2, mm_wall], radius=5);
            translate([mm_l4/2, 0, mm_h1/2]){
              rotate([0, 90, 0]){
                roundedRect(size=[mm_h1, mm_w2-10, mm_wall], radius=5, edges=[1,0,1,0]);
              }
            }
            translate([-mm_wall-mm_l4/2, 0, mm_h1/2]){
              rotate([0, 90, 0]){
                roundedRect(size=[mm_h1, mm_w2-10, mm_wall], radius=5, edges=[1,0,1,0]);
              }
            }
          }
          //Mounts hopper side
          translate([motor_m/2, mm_distance/2, mm_wall/2]){
            cylinder(d=M3_hole, h=mm_wall*1.1, center=true);
          }
          translate([-motor_m/2, mm_distance/2, mm_wall/2]){
            cylinder(d=M3_hole, h=mm_wall*1.1, center=true);
          }
          translate([-motor_m/2, -mm_distance/2, mm_wall/2]){
            cylinder(d=M3_hole, h=mm_wall*1.1, center=true);
          }
          translate([motor_m/2, -mm_distance/2, mm_wall/2]){
            cylinder(d=M3_hole, h=mm_wall*1.1, center=true);
          }
          translate([0, 0, mm_wall/2]){
            cylinder(d=mm_center_2, h=mm_wall*1.1, center=true);
          }
          //Mounts top side
          translate([motor_m/2, mm_distance2/2, mm_wall/2]){
            cylinder(d=M3_hole, h=mm_wall*1.1, center=true);
          }
          translate([-motor_m/2, mm_distance2/2, mm_wall/2]){
            cylinder(d=M3_hole, h=mm_wall*1.1, center=true);
          }
          translate([-motor_m/2, -mm_distance2/2, mm_wall/2]){
            cylinder(d=M3_hole, h=mm_wall*1.1, center=true);
          }
          translate([motor_m/2, -mm_distance2/2, mm_wall/2]){
            cylinder(d=M3_hole, h=mm_wall*1.1, center=true);
          }
          translate([0, 0, mm_wall/2]){
            cylinder(d=mm_center_1, h=mm_wall*1.1, center=true);
          }
      
      }
      
      
    }
  }
  
}

module piston_mount(){
  pm_wall = 3;
  pm_w = 42;
  pm_l = bowl_d;
  pm_h = 50;
  pm_center_1 = 4.3;
  pm_center_2 = 2;
  pm_center_d1 = 20;
  pm_center_d2 = 6;
  pm_distance = 55;
  mount_shift = 2;
  
  pm_h2 = 10;
  pm_w2 = pm_w + 5;
  
  //Mount plate on motor side
  translate([30, 0, 0]){
    difference(){
      union(){
        roundedRect(size=[pm_w2, pm_l, pm_wall], radius=5);
/*        
        translate([pm_w2/2, 0, pm_h2/2]){
          rotate([0, 90, 0]){
            roundedRect(size=[pm_h2, pm_l-10, pm_wall], radius=5, edges=[1,0,1,0]);
          }
        }
        translate([-pm_wall-pm_w2/2, 0, pm_h2/2]){
          rotate([0, 90, 0]){
            roundedRect(size=[pm_h2, pm_l-10, pm_wall], radius=5, edges=[1,0,1,0]);
          }
        }
*/
        translate([0, 0, pm_h/2]){
          cylinder(d1=pm_center_d1, d2=pm_center_d2, h=pm_h, center=true);
        }
        translate([0, 0, pm_wall+3-1]){
          difference(){
            cube(size=[10, 18, 7], center=true);
            cylinder(d=4.6, h=8, center=true);
          }
        }
      }
      
      // Center hole
      translate([0, 0, pm_h-pm_wall-2.52]){
        cylinder(d1=pm_center_1, d2=pm_center_2, h=5, center=true);
      }
      translate([0, 0, pm_h/2-pm_wall-5]){
        cylinder(d=pm_center_1, h=pm_h, center=true);
      }
      translate([0, 0, pm_h/2]){
        cylinder(d=pm_center_2, h=pm_h*1.1, center=true);
      }
      // Nut cut
      translate([0, 0, pm_wall+3-1]){
        difference(){
          cube(size=[8.2, 30, 6], center=true);
          cylinder(d=4.6, h=8, center=true);
        }
      }

      //Motor mount plate holes
      translate([motor_m/2, pm_distance/2, pm_wall/2]){
        cylinder(d=M3_hole, h=pm_wall*1.1, center=true);
      }
      translate([-motor_m/2, pm_distance/2, pm_wall/2]){
        cylinder(d=M3_hole, h=pm_wall*1.1, center=true);
      }
      translate([-motor_m/2, -pm_distance/2, pm_wall/2]){
        cylinder(d=M3_hole, h=pm_wall*1.1, center=true);
      }
      translate([motor_m/2, -pm_distance/2, pm_wall/2]){
        cylinder(d=M3_hole, h=pm_wall*1.1, center=true);
      }

    }
  }
  
}

module fan_mount(){
  fan_w = 40;
  fan_holes = 32.5;
  
  fm_w = 46;
  fm_h = 46;
  fm_wall = 13;
  fm_shift = 0;
  
  tunnel_shift = 0;
  tunnel_l = 83;
  tunnel_h = 20;
  tunnel_wall = 3;
  tunnel_w = fan_w - (alu_edge+2*bowl_wall)-2*tunnel_wall;
  
  difference(){
    union(){
      roundedRect(size=[fm_w, fm_h, fm_wall], radius=5, edges=[1,1,0,0]);
      translate([-(fm_w-tunnel_h)/2, (fm_w-tunnel_wall)/2, tunnel_l/2]){
        cube(size=[tunnel_h, tunnel_wall, tunnel_l], center=true);
      }
      translate([(tunnel_wall-fm_w)/2, (fm_w-tunnel_w)/2-1.5, tunnel_l/2]){
        cube(size=[tunnel_wall, tunnel_w+bowl_wall, tunnel_l], center=true);
      }
      translate([tunnel_h-(fm_w+tunnel_wall)/2, (fm_w-tunnel_w)/2-fm_shift, tunnel_l/2+15]){
        cube(size=[tunnel_wall, tunnel_w, tunnel_l-30], center=true);
      }
      difference(){
        translate([-3, fm_w/2, fm_wall]){
          rotate([90, 0, 0]){
            linear_extrude(height=tunnel_w){
              x1=-tunnel_wall;
              y1=0;
              x2=fm_w-tunnel_h;
              y2=0;
              x3=-tunnel_wall;
              y3=20;
              polygon(points=[[x1,y1],[x2,y2],[x3,y3]]);
            }
          }
        }
        translate([-5-tunnel_wall, fm_w/2-tunnel_wall, fm_wall]){
          rotate([90, 0, 0]){
            linear_extrude(height=tunnel_w+tunnel_wall){
              x1=-tunnel_wall;
              y1=0;
              x2=fm_w-tunnel_h;
              y2=0;
              x3=-tunnel_wall;
              y3=20;
              polygon(points=[[x1,y1],[x2,y2],[x3,y3]]);
            }
          }
        }
      }
    }
    //Cut left half
    translate([0, -fm_w/2, fm_wall/2]){
      cube(size=[fm_w*1.1, fm_h, fm_wall*1.1], center=true);
    }
    
    //Center hole
    translate([0, -fm_shift, fm_wall/2]){
      cylinder(d=40, h=fm_wall*1.1, center=true);
    }
    //Mount mount holes
    translate([(alu_edge-fm_w)/2, 0, tunnel_shift/2+(tunnel_l-extuder_m_x)/2]){
      rotate([90, 0, 0]){
        cylinder(d=M4_hole, h=fm_w*2.1, center=true);
      }
    }
    translate([(alu_edge-fm_w)/2, 0, tunnel_shift/2+(tunnel_l+extuder_m_x)/2]){
      rotate([90, 0, 0]){
        cylinder(d=M4_hole, h=fm_w*2.1, center=true);
      }
    }
    
    //Fan mount holes
    translate([fan_holes/2, fan_holes/2-fm_shift, fm_wall/2]){
      cylinder(d=3, h=fm_wall*1.1, center=true);
    }
    translate([-fan_holes/2, fan_holes/2-fm_shift, fm_wall/2]){
      cylinder(d=3, h=fm_wall*1.1, center=true);
    }
    translate([-fan_holes/2, -fan_holes/2-fm_shift, fm_wall/2]){
      cylinder(d=3, h=fm_wall*1.1, center=true);
    }
    translate([fan_holes/2, -fan_holes/2-fm_shift, fm_wall/2]){
      cylinder(d=3, h=fm_wall*1.1, center=true);
    }
  }
  
  
  
  
}

module mount_plate(){
  mp_w = 70;
  mp_w1 = 40;
  mp_h = 87;
  mp_h1 = 50;
  mp_wall = 5;
  mp_shift = 10;
  lb_d = 15;
  lb_l = 30*2;
  lb_distance = 45;
  
  //Position mount holes Zonestar P802
  mp_x1 = 36;
  mp_y1 = 7;
  mp_x2 = 0;
  mp_y2 = 46+mp_y1;
  
  //Position mount holes aluminum square extruder
  mp_x3 = extuder_m_x;
  mp_y3 = 15 + mp_y1;

  //Position mount hole bowl
  mp_x4 = 0;
  mp_y4 = mp_y3 + 68 - alu_edge/2;
  
  translate([0, 0, 0]){
    difference(){
      union(){
        translate([0, 0, 0]){
          roundedRect(size=[mp_w, mp_h, mp_wall], radius=5);
        }
        translate([0, lb_distance/2, (lb_d+2*mp_wall)/2+2]){
          rotate([0, 90, 0]){
            cylinder(d=lb_d+2*mp_wall, h=lb_l, center=true);
          }
        }
        translate([0, -lb_distance/2, (lb_d+2*mp_wall)/2+2]){
          rotate([0, 90, 0]){
            cylinder(d=lb_d+2*mp_wall, h=lb_l, center=true);
          }
        }
      }
      translate([0, lb_distance/2, (lb_d+2*mp_wall)/2+2]){
        rotate([0, 90, 0]){
          cylinder(d=lb_d, h=lb_l*1.1, center=true);
        }
      }
      translate([0, -lb_distance/2, (lb_d+2*mp_wall)/2+2]){
        rotate([0, 90, 0]){
          cylinder(d=lb_d, h=lb_l*1.1, center=true);
        }
      }

    }
  }
  
}

module hopper(mode = 0){
  h_w = 40;
  h_l = 80;
  h_h = 50;
  h_wall = 3;
  h_shift = 10;
  
  //Filler pipe mount
  fp_w = 29.2;
  fp_w2 = fp_w-1;
  fp_d = fp_w+2*h_wall;
  fp_l = 30;
  fp_il = 15;
  fp_h = 32;
  fp_e = 10;
  
  fp_mh1 = 20;
  fp_mh2 = 24;
  fp_m_h = 10;
  fp_m_dis = 20;
  
  //Alu mount screws
  am_dis = 44;
  //Motor mount
  mm_h = 20;
  mm_wall = 24;
  mm_d1 = 30;
  mm_distance = 55;
  
  
//  cone_d1 = 53; 
//  cone_d2 = 8; 
//  cone_h = h_h - alu_edge+0.2;
  
  //Cold end fan dimensions
  fan_d = 40;
  fan_h = 15;
  fan_holes = 32.5;
  fan_shift = 15;
  fan_shift2 = 19;
  
  //Linear bearings
  lb_d = 15.5;
  lb_w = 25;
  lb_dis = 44;
  lb_m_dis = 55;
  lb_shift = 10;
  lb_shift_z = 1.2;
  alu_l = 70;
  
  //Timing belt
  tb_w = 15;
  tb_h = 6;
  tb_dis = 17;
  
  if (mode == 0 || mode ==1) {  
  //Granules pipe mount
  translate([(h_l/2+fp_w)*(1-Assembled), -5.5*Assembled, h_wall/2+65.5*Assembled]){
    difference(){
      union(){
        hull(){
          cube(size=[fp_w2, h_wall, h_wall], center=true);
          translate([0, fp_h-h_wall, 0]){
            cube(size=[fp_w2, h_wall, h_wall], center=true);
          }
          translate([0, fp_h-h_wall, fp_l+fp_il]){
            cube(size=[fp_w2, h_wall, h_wall], center=true);
          }
          translate([0, 0, fp_il]){
            cube(size=[fp_w2, h_wall, h_wall], center=true);
          }
        }
        //Mount point filler tube
        hull(){
          translate([0, fp_h-h_wall, fp_il+2]){
            cube(size=[fp_w2, h_wall, h_wall], center=true);
          }
          translate([0, fp_h-h_wall, fp_il+fp_e+2]){
            cube(size=[fp_w2+2*fp_e, h_wall, h_wall], center=true);
          }
          translate([fp_w/2, fp_h-h_wall, fp_l+fp_il]){
            rotate([90, 0, 0]){
              cylinder(r=fp_e, h=h_wall, center=true);
            }
          }
          translate([-fp_w2/2, fp_h-h_wall, fp_l+fp_il]){
            rotate([90, 0, 0]){
              cylinder(r=fp_e, h=h_wall, center=true);
            }
          }
        }
        
      }
      translate([0, h_wall, -h_wall]){
        //Cut inner part
        difference(){
          hull(){
            cube(size=[fp_w2-2*h_wall-4, h_wall, h_wall], center=true);
            translate([0, fp_h-h_wall, 0]){
              cube(size=[fp_w2-2*h_wall-4, h_wall, h_wall], center=true);
            }
            translate([0, fp_h-h_wall, fp_l+fp_il]){
              cube(size=[fp_w2-2*h_wall-4, h_wall, h_wall], center=true);
            }
            translate([0, 0, 17]){
              cube(size=[fp_w2-2*h_wall-4, h_wall, h_wall], center=true);
            }
          }
        }
        //Cut filler pipe mount holes
        translate([0, h_wall, fp_il-(fp_m_h/2)]){
          translate([0, (h_h-fp_h-fp_m_dis)/2-0.5, 0]){
            rotate([0, 90, 0]){
              cylinder(d=M3_hole, h=fp_w*1.5, center=true);
              cylinder(d=M3_nut_e, h=fp_w-2*h_wall+2, center=true, $fn=6);
            }
          }
          translate([0, (h_h-fp_h+fp_m_dis)/2-0.5, 0]){
            rotate([0, 90, 0]){
              cylinder(d=M3_hole, h=fp_w*1.5, center=true);
              cylinder(d=M3_nut_e, h=fp_w-2*h_wall+2, center=true, $fn=6);
            }
          }
        }

        translate([0, fp_h, fp_l+fp_il+fp_e/2+h_wall]){
          translate([0, 0, 0]){
            rotate([90, 0, 0]){
              cylinder(d=M3_hole, h=h_wall*100.1, center=true);
            }
          }
          translate([(fp_w+fp_e)/2, 0, -fp_mh1]){
            rotate([90, 0, 0]){
              cylinder(d=M3_hole, h=h_wall*100.1, center=true);
            }
          }
          translate([-(fp_w+fp_e)/2, 0, -fp_mh1]){
            rotate([90, 0, 0]){
              cylinder(d=M3_hole, h=h_wall*100.1, center=true);
            }
          }
        }
      }
    }
  }
 } 
 
  if (mode == 0 || mode == 2) {
  difference(){
    union(){
      translate([0, 0, (h_w+lb_w+h_wall)/2]){
        cube(size=[h_l, h_h, h_w+lb_w+h_wall], center=true);
      }
      //Filler pipe mount
      translate([0, (h_h-h_wall)/2-fp_h, h_w+lb_w+fp_m_h/2+h_wall]){
        cube(size=[fp_w+h_wall*2, h_wall, fp_m_h], center=true);
      }
      translate([(fp_w+h_wall)/2, (h_h-fp_h)/2, h_w+lb_w+fp_m_h/2+h_wall]){
        cube(size=[h_wall, fp_h, fp_m_h], center=true);
      }
      translate([-(fp_w+h_wall)/2, (h_h-fp_h)/2, h_w+lb_w+fp_m_h/2+h_wall]){
        cube(size=[h_wall, fp_h, fp_m_h], center=true);
      }
      
      //Motor mount
      translate([h_l/2-h_wall, (h_h+mm_h)/2, (h_w+lb_w+h_wall)/2]){
        cube(size=[h_wall*2, mm_h, h_w+lb_w+h_wall], center=true);
      }
      translate([h_wall-h_l/2, (h_h+mm_h)/2, (h_w+lb_w+h_wall)/2]){
        cube(size=[h_wall*2, mm_h, h_w+lb_w+h_wall], center=true);
      }
      translate([0, (h_h+mm_h)/2, (mm_wall)/2]){
        cube(size=[h_l, mm_h, mm_wall], center=true);
      }
      translate([0, (h_h+h_wall)/2+mm_h, (h_w+lb_w+h_wall)/2]){
        cube(size=[h_l, h_wall,h_w+lb_w+h_wall], center=true);
      }
    }

    //Cut filler pipe mount holes
    translate([0, 0, h_w+lb_w+fp_m_h/2+h_wall]){
      translate([0, (h_h-fp_h-fp_m_dis)/2, 0]){
        rotate([0, 90, 0]){
          cylinder(d=M3_hole, h=fp_w*1.5, center=true);
        }
      }
      translate([0, (h_h-fp_h+fp_m_dis)/2, 0]){
        rotate([0, 90, 0]){
          cylinder(d=M3_hole, h=fp_w*1.5, center=true);
        }
      }
    }

    //Cut filler pipe mount
    translate([0, h_h/2-16+0.1, h_w+lb_w-16]){
      intersection(){
        hull(){
          translate([0, 0, 20]){
            cube(size=[fp_w, 32, 40], center=true);
          }
          translate([0, 0, 9-fp_w/2]){
            rotate([90, 0, 0]){
              cylinder(d=fp_w, h=32, center=true);
            }
          }
        }
      }
    }
    
    //Cut filler pipe mount holes
      translate([fp_mh1, (h_h-h_wall)/2, h_w+lb_w+fp_l-5]){
        rotate([90, 0, 0]){
          cylinder(d=M3_hole, h=h_wall*1.1, center=true);
        }
      }
      translate([-fp_mh1, (h_h-h_wall)/2, h_w+lb_w+fp_l-5]){
        rotate([90, 0, 0]){
          cylinder(d=M3_hole, h=h_wall*1.1, center=true);
        }
      }
      translate([0, (h_h-h_wall)/2, h_w+lb_w+fp_l+fp_mh2]){
        rotate([90, 0, 0]){
          cylinder(d=M3_hole, h=h_wall*1.1, center=true);
        }
      }


    //Cut Alu mount holes
    translate([am_dis/2, h_shift, h_w/2+lb_w]){
      rotate([90, 0, 0]){
        cylinder(d=M4_hole, h=h_h+0.1, center=true);
      }
    }
    translate([am_dis/2, -h_h/2+alu_edge, h_w/2+lb_w]){
      rotate([90, 0, 0]){
        cylinder(d=M4_hole*2.5, h=20, center=true);
      }
    }
    translate([-am_dis/2, h_shift, h_w/2+lb_w]){
      rotate([90, 0, 0]){
        cylinder(d=M4_hole, h=h_h+0.1, center=true);
      }
    }
    translate([-am_dis/2, -h_h/2+alu_edge, h_w/2+lb_w]){
      rotate([90, 0, 0]){
        cylinder(d=M4_hole*2.5, h=20, center=true);
      }
    }
    
    //Cut hotend nuts holes
    hm_dis = 20;
    translate([hm_dis/2, -h_h/2+alu_edge, h_w/2+lb_w]){
      rotate([90, 0, 0]){
        rotate([0, 0, 30]){
          cylinder(d=M4_hole*2.5, h=20, center=true, $fn=6);
        }
      }
    }
    translate([-hm_dis/2, -h_h/2+alu_edge, h_w/2+lb_w]){
      rotate([90, 0, 0]){
        rotate([0, 0, 30]){
          cylinder(d=M4_hole*2.5, h=20, center=true, $fn=6);
        }
      }
    }
    translate([0, -h_h/2+alu_edge, h_w/2+lb_w]){
      cube(size=[hm_dis, 20, M4_hole*2.5], center=true);
    }

    //Cut alu
    translate([(h_l-alu_l)/2+0.1, (alu_edge-h_h)/2, h_w/2+lb_w]){
      cube(size=[alu_l, alu_edge+0.1, alu_edge], center=true);
    }
    //Cut fan tunnel
    translate([(h_l-alu_l)/2+0.1, alu_edge-h_h/2, h_w/2+lb_w]){
      rotate([90, 0, 0]){
        linear_extrude(height=alu_edge+0.1, scale=[1, 2.0]){
          translate([0, 0, 0]){
            square(size=[alu_l+6, alu_edge*1.3], center=true);
          }
        }
      }
    }
    //Cut fan cone
    difference(){
      translate([-h_l/2-0.1, (alu_edge-h_h)/2+fan_shift-fan_shift2, h_w/2+lb_w]){
        rotate([0, 90, 0]){
          linear_extrude(height=fan_h, scale=0.35){
            translate([0, fan_shift2, 0]){
              circle(d=fan_d, center=true);
            }
          }
        }
      }
      translate([-am_dis/2, h_shift, h_w/2+lb_w]){
        rotate([90, 0, 0]){
          cylinder(d=M4_hole*3.5, h=h_h+0.1, center=true);
        }
      }
    }
    //Cut fan mount holes
    translate([-h_l/2-0.1, (alu_edge-h_h)/2+fan_shift, h_w/2+lb_w]){
      rotate([0, 90, 0]){
        translate([fan_holes/2, fan_holes/2, 0]){
          cylinder(d=3, h=40, center=true);
        }
        translate([fan_holes/2, -fan_holes/2, 0]){
          cylinder(d=3, h=40, center=true);
        }
        translate([-fan_holes/2, -fan_holes/2, 0]){
          cylinder(d=3, h=40, center=true);
        }
        translate([-fan_holes/2, fan_holes/2, 0]){
          cylinder(d=3, h=40, center=true);
        }
      }
    }
    
    //Cut part fan mount holes
    translate([-25, -h_h/2+25, h_w+lb_w+h_wall]){
      cylinder(d=3, h=20, center=true);
    }
    translate([25, -h_h/2+25, h_w+lb_w+h_wall]){
      cylinder(d=3, h=20, center=true);
    }

    //Cut linear bearings
    translate([0, 0, lb_shift_z]){
      translate([0, lb_shift+lb_dis/2, lb_w/2]){
        rotate([0, 90, 0]){
          cylinder(d=lb_d, h=h_l+0.1, center=true);
        }
      }
      translate([0, lb_shift-lb_dis/2, lb_w/2]){
        rotate([0, 90, 0]){
          cylinder(d=lb_d, h=h_l+0.1, center=true);
        }
      }
      //Cut linear bearings mount holes
      translate([lb_m_dis/2, lb_shift+lb_dis/2, 0]){
        cylinder(d=3, h=15, center=true);
        translate([0, 0, 8]){
          cylinder(d=M3_nut_e, h=15, center=true, $fn=6);
        }
      }
      translate([-lb_m_dis/2, lb_shift+lb_dis/2, 0]){
        cylinder(d=3, h=15, center=true);
        translate([0, 0, 8]){
          cylinder(d=M3_nut_e, h=15, center=true, $fn=6);
        }
      }
      translate([-lb_m_dis/2, lb_shift-lb_dis/2, 0]){
        cylinder(d=3, h=15, center=true);
        translate([0, 0, 8]){
          cylinder(d=M3_nut_e, h=15, center=true, $fn=6);
        }
      }
      translate([lb_m_dis/2, lb_shift-lb_dis/2, 0]){
        cylinder(d=3, h=15, center=true);
        translate([0, 0, 8]){
          cylinder(d=M3_nut_e, h=15, center=true, $fn=6);
        }
      }
      
      
      //Cut timing belt
      translate([0, lb_shift-tb_dis/2, lb_w/2]){
        cube(size=[h_l+0.1, tb_h, tb_w], center=true);
      }
      //Cut timing belt mounts
      mount_shift = 10;
      translate([h_l/2-mount_shift/2, lb_shift+tb_dis/2, lb_w/2]){
        cylinder(d=mount_shift, h=tb_w, center=true);
      }
      translate([h_l/2-mount_shift/2, lb_shift+tb_dis/2, lb_w/2]){
        cylinder(d=3, h=tb_w*3, center=true);
      }
      translate([h_l/2-mount_shift/2, lb_shift+tb_dis/2, (lb_w+tb_w)/2]){
        sphere(d=mount_shift, center=true);
      }
      translate([h_l/2, lb_shift+tb_dis/2, lb_w/2]){
        cube(size=[mount_shift, mount_shift, tb_w], center=true);
      }

      translate([mount_shift/2-h_l/2, lb_shift+tb_dis/2, lb_w/2]){
        cylinder(d=mount_shift, h=tb_w, center=true);
      }
      translate([mount_shift/2-h_l/2, lb_shift+tb_dis/2, (lb_w+tb_w)/2]){
        sphere(d=mount_shift, center=true);
      }
      translate([mount_shift/2-h_l/2, lb_shift+tb_dis/2, lb_w/2]){
        cylinder(d=3, h=tb_w*3, center=true);
      }
      translate([-h_l/2, lb_shift+tb_dis/2, lb_w/2]){
        cube(size=[mount_shift, mount_shift, tb_w], center=true);
      }
      
    }
    
    //Cut central hole motor mount
    translate([0, (h_h+h_wall)/2+mm_h, h_w/2+lb_w]){
      rotate([90, 0, 0]){
        cylinder(d=mm_d1, h=h_wall*1.1, center=true);
      }
    }
    translate([mm_d1/2-2, (h_h+h_wall)/2+mm_h, h_w/2+lb_w]){
      rotate([90, 0, 0]){
        cylinder(d=12, h=h_wall*1.1, center=true);
      }
    }
    translate([2-mm_d1/2, (h_h+h_wall)/2+mm_h, h_w/2+lb_w]){
      rotate([90, 0, 0]){
        cylinder(d=12, h=h_wall*1.1, center=true);
      }
    }
    //Cut motor mount holes
    translate([mm_distance/2, (h_h+h_wall)/2+mm_h, h_w/2+lb_w-motor_m/2]){
      rotate([90, 0, 0]){
        cylinder(d=M3_hole, h=h_wall*1.1, center=true);
      }
    }
    translate([-mm_distance/2, (h_h+h_wall)/2+mm_h, h_w/2+lb_w-motor_m/2]){
      rotate([90, 0, 0]){
        cylinder(d=M3_hole, h=h_wall*1.1, center=true);
      }
    }
    translate([-mm_distance/2, (h_h+h_wall)/2+mm_h, h_w/2+lb_w+motor_m/2]){
      rotate([90, 0, 0]){
        cylinder(d=M3_hole, h=h_wall*1.1, center=true);
      }
    }
    translate([mm_distance/2, (h_h+h_wall)/2+mm_h, h_w/2+lb_w+motor_m/2]){
      rotate([90, 0, 0]){
        cylinder(d=M3_hole, h=h_wall*1.1, center=true);
      }
    }
    
    
  }
  }

/*
  //Support structure
  translate([-5, -h_h/2-6, 0]){
    rotate([0, 0, 180]){
      bridge_post(height=53.4, width=9, brim_w=20, brim_l=16, link=0);
    }
  }
  translate([22, -h_h/2-6, 0]){
    rotate([0, 0, 180]){
      bridge_post(height=53.4, width=9, brim_w=20, brim_l=16, link=0);
    }
  }
*/  
}


module hopper_old(){
  h_w = 40;
  h_l = 80;
  h_h = 50;
  h_wall = 3;
  h_shift = 10;
  
  //Filler pipe mount
  fp_w = 29.2;
  fp_w2 = fp_w-1;
  fp_d = fp_w+2*h_wall;
  fp_l = 30;
  fp_il = 15;
  fp_h = 32;
  fp_e = 10;
  
  fp_mh1 = 20;
  fp_mh2 = 24;
  fp_m_h = 10;
  fp_m_dis = 20;
  
  //Alu mount screws
  am_dis = 44;
  //Motor mount
  mm_h = 20;
  mm_wall = 24;
  mm_d1 = 30;
  mm_distance = 55;
  
  
//  cone_d1 = 53; 
//  cone_d2 = 8; 
//  cone_h = h_h - alu_edge+0.2;
  
  //Cold end fan dimensions
  fan_d = 40;
  fan_h = 15;
  fan_holes = 32.5;
  fan_shift = 15;
  fan_shift2 = 19;
  
  //Linear bearings
  lb_d = 15.5;
  lb_w = 25;
  lb_dis = 44;
  lb_m_dis = 55;
  lb_shift = 10;
  lb_shift_z = 1.2;
  alu_l = 70;
  
  //Timing belt
  tb_w = 15;
  tb_h = 6;
  tb_dis = 17;
  
  
  //Granules pipe mount
  translate([(h_l/2+fp_w), 0-5.5*0, h_wall/2+55.5*0]){
    difference(){
      union(){
        hull(){
          cube(size=[fp_w2, h_wall, h_wall], center=true);
          translate([0, fp_h-h_wall, 0]){
            cube(size=[fp_w2, h_wall, h_wall], center=true);
          }
          translate([0, fp_h-h_wall, fp_l+fp_il]){
            cube(size=[fp_w2, h_wall, h_wall], center=true);
          }
          translate([0, 0, fp_il]){
            cube(size=[fp_w2, h_wall, h_wall], center=true);
          }
        }
        //Mount point filler tube
        hull(){
          translate([0, fp_h-h_wall, fp_il+2]){
            cube(size=[fp_w2, h_wall, h_wall], center=true);
          }
          translate([0, fp_h-h_wall, fp_il+fp_e+2]){
            cube(size=[fp_w2+2*fp_e, h_wall, h_wall], center=true);
          }
          translate([fp_w/2, fp_h-h_wall, fp_l+fp_il]){
            rotate([90, 0, 0]){
              cylinder(r=fp_e, h=h_wall, center=true);
            }
          }
          translate([-fp_w2/2, fp_h-h_wall, fp_l+fp_il]){
            rotate([90, 0, 0]){
              cylinder(r=fp_e, h=h_wall, center=true);
            }
          }
        }
        
      }
      translate([0, h_wall, -h_wall]){
        //Cut inner part
        difference(){
          hull(){
            cube(size=[fp_w2-2*h_wall-4, h_wall, h_wall], center=true);
            translate([0, fp_h-h_wall, 0]){
              cube(size=[fp_w2-2*h_wall-4, h_wall, h_wall], center=true);
            }
            translate([0, fp_h-h_wall, fp_l+fp_il]){
              cube(size=[fp_w2-2*h_wall-4, h_wall, h_wall], center=true);
            }
            translate([0, 0, 17]){
              cube(size=[fp_w2-2*h_wall-4, h_wall, h_wall], center=true);
            }
          }
/*          
          //Nut holes
          translate([0, h_wall, fp_il-(fp_m_h/2)]){
            translate([0, (h_h-fp_h-fp_m_dis)/2-0.5, 0]){
              rotate([0, 90, 0]){
                difference(){
                  cylinder(d=M3_nut_e+3, h=fp_w*1.5, center=true);
                  cylinder(d=M3_nut_e+5, h=fp_w-2*h_wall-6, center=true);
                }
              }
            }
            translate([0, (h_h-fp_h+fp_m_dis)/2-0.5, 0]){
              rotate([0, 90, 0]){
                difference(){
                  cylinder(d=M3_nut_e+3, h=fp_w*1.5, center=true);
                  cylinder(d=M3_nut_e+5, h=fp_w-2*h_wall-6, center=true);
                }
              }
            }          
          }
*/          
        }
        //Cut filler pipe mount holes
        translate([0, h_wall, fp_il-(fp_m_h/2)]){
//          translate([0, -2*h_wall, 0]){
//            rotate([90, 0, 0]){
//              cylinder(d=M3_hole, h=h_wall*1.1, center=true);
//            }
//          }
          translate([0, (h_h-fp_h-fp_m_dis)/2-0.5, 0]){
            rotate([0, 90, 0]){
              cylinder(d=M3_hole, h=fp_w*1.5, center=true);
              cylinder(d=M3_nut_e, h=fp_w-2*h_wall+2, center=true, $fn=6);
            }
          }
          translate([0, (h_h-fp_h+fp_m_dis)/2-0.5, 0]){
            rotate([0, 90, 0]){
              cylinder(d=M3_hole, h=fp_w*1.5, center=true);
              cylinder(d=M3_nut_e, h=fp_w-2*h_wall+2, center=true, $fn=6);
            }
          }
        }

        translate([0, fp_h, fp_l+fp_il+fp_e/2+h_wall]){
          translate([0, 0, 0]){
            rotate([90, 0, 0]){
              cylinder(d=M3_hole, h=h_wall*100.1, center=true);
            }
          }
          translate([(fp_w+fp_e)/2, 0, -fp_mh1]){
            rotate([90, 0, 0]){
              cylinder(d=M3_hole, h=h_wall*100.1, center=true);
            }
          }
          translate([-(fp_w+fp_e)/2, 0, -fp_mh1]){
            rotate([90, 0, 0]){
              cylinder(d=M3_hole, h=h_wall*100.1, center=true);
            }
          }
        }
      }
    }
  }
  
  
  difference(){
    union(){
      translate([0, 0, (h_w+lb_w+h_wall)/2]){
        cube(size=[h_l, h_h, h_w+lb_w+h_wall], center=true);
      }
      //Support at end of alu cut
      translate([h_l/2-10, -(h_h-h_wall)/2, h_w/2+lb_w]){
        rotate([90, 0, 0]){
          cylinder(d=40, h=h_wall, center=true);
        }
      }
      //Filler pipe mount
      translate([0, (h_h-h_wall)/2-fp_h, h_w+lb_w+fp_m_h/2+h_wall]){
        cube(size=[fp_w+h_wall*2, h_wall, fp_m_h], center=true);
      }
      translate([(fp_w+h_wall)/2, (h_h-fp_h)/2, h_w+lb_w+fp_m_h/2+h_wall]){
        cube(size=[h_wall, fp_h, fp_m_h], center=true);
      }
      translate([-(fp_w+h_wall)/2, (h_h-fp_h)/2, h_w+lb_w+fp_m_h/2+h_wall]){
        cube(size=[h_wall, fp_h, fp_m_h], center=true);
      }
      
      //Motor mount
      translate([h_l/2-h_wall, (h_h+mm_h)/2, (h_w+lb_w+h_wall)/2]){
        cube(size=[h_wall*2, mm_h, h_w+lb_w+h_wall], center=true);
      }
      translate([h_wall-h_l/2, (h_h+mm_h)/2, (h_w+lb_w+h_wall)/2]){
        cube(size=[h_wall*2, mm_h, h_w+lb_w+h_wall], center=true);
      }
      translate([0, (h_h+mm_h)/2, (mm_wall)/2]){
        cube(size=[h_l, mm_h, mm_wall], center=true);
      }
      translate([0, (h_h+h_wall)/2+mm_h, (h_w+lb_w+h_wall)/2]){
        cube(size=[h_l, h_wall,h_w+lb_w+h_wall], center=true);
      }
    }

    //Cut filler pipe mount holes
    translate([0, 0, h_w+lb_w+fp_m_h/2+h_wall]){
//      translate([0, (h_h-h_wall)/2-fp_h, ]){
//        rotate([90, 0, 0]){
//          cylinder(d=M3_hole, h=h_wall*1.1, center=true);
//        }
//      }
      translate([0, (h_h-fp_h-fp_m_dis)/2, 0]){
        rotate([0, 90, 0]){
          cylinder(d=M3_hole, h=fp_w*1.5, center=true);
        }
      }
      translate([0, (h_h-fp_h+fp_m_dis)/2, 0]){
        rotate([0, 90, 0]){
          cylinder(d=M3_hole, h=fp_w*1.5, center=true);
        }
      }
    }

    //Cut filler pipe mount
    translate([0, h_h/2-16+0.1, h_w+lb_w-16]){
      intersection(){
        hull(){
          translate([0, 0, 20]){
            cube(size=[fp_w, 32, 40], center=true);
          }
          translate([0, 0, 9-fp_w/2]){
            rotate([90, 0, 0]){
              cylinder(d=fp_w, h=32, center=true);
            }
          }
        }
      }
    }
    
    //Cut filler pipe mount holes
      translate([fp_mh1, (h_h-h_wall)/2, h_w+lb_w+fp_l-5]){
        rotate([90, 0, 0]){
          cylinder(d=M3_hole, h=h_wall*1.1, center=true);
        }
      }
      translate([-fp_mh1, (h_h-h_wall)/2, h_w+lb_w+fp_l-5]){
        rotate([90, 0, 0]){
          cylinder(d=M3_hole, h=h_wall*1.1, center=true);
        }
      }
      translate([0, (h_h-h_wall)/2, h_w+lb_w+fp_l+fp_mh2]){
        rotate([90, 0, 0]){
          cylinder(d=M3_hole, h=h_wall*1.1, center=true);
        }
      }


/*
    //Cut cone
    translate([0, (h_h-cone_h)/2+0.1, h_w/2+lb_w]){
      rotate([90, 0, 0]){
        difference(){
          cylinder(d1=cone_d1, d2=cone_d2, h=cone_h, center=true);
          translate([am_dis/2, 0, 0]){
            cube(size=[10, cone_d1, h_h*1.1], center=true);
          }
          translate([-am_dis/2, 0, 0]){
            cube(size=[10, cone_d1, h_h*1.1], center=true);
          }
          translate([0, -am_dis/2, 0]){
            cube(size=[cone_d1, 10, h_h*1.1], center=true);
          }
          translate([0, am_dis/2, 0]){
            cube(size=[cone_d1, 36, h_h*1.1], center=true);
          }
        }
      }
    }
*/    
    //Cut Alu mount holes
    translate([am_dis/2, h_shift, h_w/2+lb_w]){
      rotate([90, 0, 0]){
        cylinder(d=M4_hole, h=h_h+0.1, center=true);
      }
    }
    translate([am_dis/2, -h_h/2+alu_edge, h_w/2+lb_w]){
      rotate([90, 0, 0]){
        cylinder(d=M4_hole*2.5, h=20, center=true);
      }
    }
    translate([-am_dis/2, h_shift, h_w/2+lb_w]){
      rotate([90, 0, 0]){
        cylinder(d=M4_hole, h=h_h+0.1, center=true);
      }
    }
    translate([-am_dis/2, -h_h/2+alu_edge, h_w/2+lb_w]){
      rotate([90, 0, 0]){
        cylinder(d=M4_hole*2.5, h=20, center=true);
      }
    }
    
    //Cut hotend nuts holes
    hm_dis = 20;
    translate([hm_dis/2, -h_h/2+alu_edge, h_w/2+lb_w]){
      rotate([90, 0, 0]){
        rotate([0, 0, 30]){
          cylinder(d=M4_hole*2.5, h=20, center=true, $fn=6);
        }
      }
    }
    translate([-hm_dis/2, -h_h/2+alu_edge, h_w/2+lb_w]){
      rotate([90, 0, 0]){
        rotate([0, 0, 30]){
          cylinder(d=M4_hole*2.5, h=20, center=true, $fn=6);
        }
      }
    }
    translate([0, -h_h/2+alu_edge, h_w/2+lb_w]){
      cube(size=[hm_dis, 20, M4_hole*2.5], center=true);
    }

    //Cut alu
    translate([(h_l-alu_l)/2+0.1, (alu_edge-h_h)/2, h_w/2+lb_w]){
      cube(size=[alu_l, alu_edge+0.1, alu_edge], center=true);
    }
    //Cut fan square tube
    translate([(h_l-alu_l)/2+0.1, (alu_edge+h_wall-h_h)/2, h_w/2+lb_w]){
      cube(size=[alu_l+6, alu_edge-h_wall, alu_edge*1.7], center=true);
    }
    //Cut fan cone
    difference(){
      translate([-h_l/2-0.1, (alu_edge-h_h)/2+fan_shift-fan_shift2, h_w/2+lb_w]){
        rotate([0, 90, 0]){
          linear_extrude(height=fan_h, scale=0.35){
            translate([0, fan_shift2, 0]){
              circle(d=fan_d, center=true);
            }
          }
        }
      }
      translate([-am_dis/2, h_shift, h_w/2+lb_w]){
        rotate([90, 0, 0]){
          cylinder(d=M4_hole*3.5, h=h_h+0.1, center=true);
        }
      }
    }
    //Cut fan mount holes
    translate([-h_l/2-0.1, (alu_edge-h_h)/2+fan_shift, h_w/2+lb_w]){
      rotate([0, 90, 0]){
        translate([fan_holes/2, fan_holes/2, 0]){
          cylinder(d=3, h=40, center=true);
        }
        translate([fan_holes/2, -fan_holes/2, 0]){
          cylinder(d=3, h=40, center=true);
        }
        translate([-fan_holes/2, -fan_holes/2, 0]){
          cylinder(d=3, h=40, center=true);
        }
        translate([-fan_holes/2, fan_holes/2, 0]){
          cylinder(d=3, h=40, center=true);
        }
      }
    }
    
    //Cut part fan mount holes
    translate([-25, -h_h/2+25, h_w+lb_w+h_wall]){
      cylinder(d=3, h=20, center=true);
    }
    translate([25, -h_h/2+25, h_w+lb_w+h_wall]){
      cylinder(d=3, h=20, center=true);
    }

    //Cut linear bearings
    translate([0, 0, lb_shift_z]){
      translate([0, lb_shift+lb_dis/2, lb_w/2]){
        rotate([0, 90, 0]){
          cylinder(d=lb_d, h=h_l+0.1, center=true);
        }
      }
      translate([0, lb_shift-lb_dis/2, lb_w/2]){
        rotate([0, 90, 0]){
          cylinder(d=lb_d, h=h_l+0.1, center=true);
        }
      }
      //Cut linear bearings mount holes
      translate([lb_m_dis/2, lb_shift+lb_dis/2, 0]){
        cylinder(d=3, h=15, center=true);
        translate([0, 0, 8]){
          cylinder(d=M3_nut_e, h=15, center=true, $fn=6);
        }
      }
      translate([-lb_m_dis/2, lb_shift+lb_dis/2, 0]){
        cylinder(d=3, h=15, center=true);
        translate([0, 0, 8]){
          cylinder(d=M3_nut_e, h=15, center=true, $fn=6);
        }
      }
      translate([-lb_m_dis/2, lb_shift-lb_dis/2, 0]){
        cylinder(d=3, h=15, center=true);
        translate([0, 0, 8]){
          cylinder(d=M3_nut_e, h=15, center=true, $fn=6);
        }
      }
      translate([lb_m_dis/2, lb_shift-lb_dis/2, 0]){
        cylinder(d=3, h=15, center=true);
        translate([0, 0, 8]){
          cylinder(d=M3_nut_e, h=15, center=true, $fn=6);
        }
      }
      
      
      //Cut timing belt
      translate([0, lb_shift-tb_dis/2, lb_w/2]){
        cube(size=[h_l+0.1, tb_h, tb_w], center=true);
      }
      //Cut timing belt mounts
      mount_shift = 10;
      translate([h_l/2-mount_shift/2, lb_shift+tb_dis/2, lb_w/2]){
        cylinder(d=mount_shift, h=tb_w, center=true);
      }
      translate([h_l/2-mount_shift/2, lb_shift+tb_dis/2, lb_w/2]){
        cylinder(d=3, h=tb_w*3, center=true);
      }
      translate([h_l/2-mount_shift/2, lb_shift+tb_dis/2, (lb_w+tb_w)/2]){
        sphere(d=mount_shift, center=true);
      }
      translate([h_l/2, lb_shift+tb_dis/2, lb_w/2]){
        cube(size=[mount_shift, mount_shift, tb_w], center=true);
      }

      translate([mount_shift/2-h_l/2, lb_shift+tb_dis/2, lb_w/2]){
        cylinder(d=mount_shift, h=tb_w, center=true);
      }
      translate([mount_shift/2-h_l/2, lb_shift+tb_dis/2, (lb_w+tb_w)/2]){
        sphere(d=mount_shift, center=true);
      }
      translate([mount_shift/2-h_l/2, lb_shift+tb_dis/2, lb_w/2]){
        cylinder(d=3, h=tb_w*3, center=true);
      }
      translate([-h_l/2, lb_shift+tb_dis/2, lb_w/2]){
        cube(size=[mount_shift, mount_shift, tb_w], center=true);
      }
      
    }
    
    //Cut central hole motor mount
    translate([0, (h_h+h_wall)/2+mm_h, h_w/2+lb_w]){
      rotate([90, 0, 0]){
        cylinder(d=mm_d1, h=h_wall*1.1, center=true);
      }
    }
    translate([mm_d1/2-2, (h_h+h_wall)/2+mm_h, h_w/2+lb_w]){
      rotate([90, 0, 0]){
        cylinder(d=12, h=h_wall*1.1, center=true);
      }
    }
    translate([2-mm_d1/2, (h_h+h_wall)/2+mm_h, h_w/2+lb_w]){
      rotate([90, 0, 0]){
        cylinder(d=12, h=h_wall*1.1, center=true);
      }
    }
    //Cut motor mount holes
    translate([mm_distance/2, (h_h+h_wall)/2+mm_h, h_w/2+lb_w-motor_m/2]){
      rotate([90, 0, 0]){
        cylinder(d=M3_hole, h=h_wall*1.1, center=true);
      }
    }
    translate([-mm_distance/2, (h_h+h_wall)/2+mm_h, h_w/2+lb_w-motor_m/2]){
      rotate([90, 0, 0]){
        cylinder(d=M3_hole, h=h_wall*1.1, center=true);
      }
    }
    translate([-mm_distance/2, (h_h+h_wall)/2+mm_h, h_w/2+lb_w+motor_m/2]){
      rotate([90, 0, 0]){
        cylinder(d=M3_hole, h=h_wall*1.1, center=true);
      }
    }
    translate([mm_distance/2, (h_h+h_wall)/2+mm_h, h_w/2+lb_w+motor_m/2]){
      rotate([90, 0, 0]){
        cylinder(d=M3_hole, h=h_wall*1.1, center=true);
      }
    }
    
    
  }

  //Support structure
  translate([-5, -h_h/2-6, 0]){
    rotate([0, 0, 180]){
      bridge_post(height=53.4, width=9, brim_w=20, brim_l=16, link=0);
    }
  }
  translate([22, -h_h/2-6, 0]){
    rotate([0, 0, 180]){
      bridge_post(height=53.4, width=9, brim_w=20, brim_l=16, link=0);
    }
  }
}


module bridge_post(height, width=6, brim_w=10, brim_l=6, link=0){
  edge=7;
  tip=edge;
  tip_w = 0.2;
  brim_h = 0.3;
  socket_h = 35;
  
  x1=edge/2;
  y1=0;
  x2=edge/2;
  y2=height-tip;
  x3=-width;
  y3=height-tip;
  x4=-edge/2;
  y4=socket_h;
  x5=-edge/2;
  y5=0;
  
  translate([edge/2, 0, brim_h/2]){
    cube(size=[brim_w, brim_l, brim_h], center=true);
  }
  
  rotate([90, 0, 90]){
    linear_extrude(height=edge){
      polygon(points=[[x1,y1],[x2,y2],[x3,y3],[x4,y4],[x5,y5]]);
    }
  }
  
  if(link>0){
    translate([link/2, 0, height/2]){
      cube(size=[link, edge/2, 2], center=true);
    }
  }
  
  x1t=edge/2;
  y1t=0;
  x2t=0;
  y2t=edge;
  x3t=-edge/2;
  y3t=0;
  
  translate([edge/2, edge/2, height-tip]){
    rotate([90, 0, 0]){
      linear_extrude(height=edge/2+width){
        polygon(points=[[x1t,y1t],[x2t,y2t],[x3t,y3t]]);
      }
    }    
  }

  translate([edge/2, -(width-edge/2)/2, height-tip/2]){
    cube(size=[tip_w, width+edge/2, tip], center=true);    
  }

}


module roundedRect(size, radius, edges=[1, 1, 1, 1], vscale=[1,1], shift=0){
  x = size[0];
  y = size[1];
  z = size[2];

  translate([0, -shift*2, 0]){
    linear_extrude(height=z, scale=[vscale[0], vscale[1]]){
      translate([0, shift*2, 0]){
        hull(){
            // place 4 circles in the corners, with the given radius
            if(edges[0]){
              translate([(-x/2)+(radius), (-y/2)+(radius), 0])
              circle(r=radius);
            }
            else{
              translate([(-x/2)+(radius/2), (-y/2)+(radius/2), 0])
              square(size=[radius, radius], center=true);
            }
            if(edges[1]){
              translate([(x/2)-(radius), (-y/2)+(radius), 0])
              circle(r=radius);
            }
            else{
              translate([(x/2)-(radius/2), (-y/2)+(radius/2), 0])
              square(size=[radius, radius], center=true);
            }

            if(edges[2]){
              translate([(-x/2)+(radius), (y/2)-(radius), 0])
              circle(r=radius);
            }
            else{
              translate([(-x/2)+(radius/2), (y/2)-(radius/2), 0])
              square(size=[radius, radius], center=true);
            }

            if(edges[3]){
              translate([(x/2)-(radius), (y/2)-(radius), 0])
              circle(r=radius);
            }
            else{
              translate([(x/2)-(radius/2), (y/2)-(radius/2), 0])
              square(size=[radius, radius], center=true);
            }
          }
       }
    }
  }
}
