// FILENAME : Bulgin_BX0013_extension.scad
// $Revision: 5 $
// $Date: 2022-10-18 15:21:14 +0100 (Tue, 18 Oct 2022) $
// This part will convert a Bulgin BX0013/1 3*AA battery holder so that it can hold 4 * AA batteries.
// It is effectively a copy of the rear section that carries the -ve electrical connection.
// Dimentions in 1/1000" (PRUSA scale = 2.54%)

$fn = 300;

narrowID   = 600;
narrowOD   = 725;
narrowH    = 1990;

wideID     = narrowOD + 5;
wideOD     = 855;
wideH      = 315;

Zofset     = wideH - 60;

cutZ       = 700;
cutX       = 285;
cutY       = 2 * wideOD;
cutZoffset = 1415;

tabfX      = 100;
tabfY      = (narrowOD - narrowID) / 2 ;
tabfZ      = 60;

tabmX      = tabfX - 5;
tabmY      = tabfY;
tabmZ      = tabfZ - 5;

module Bulgin_BX0013_Extension()
{
    difference()
    {
        union()
        {
            difference()
            {
                // Narrow part of tube
                translate([0, 0, Zofset])
                {
                    cylinder(h=narrowH, r=narrowOD / 2, center=false);
                }
                
                // The location tab (female)
                translate([-tabfX / 2, (narrowOD / 2) - tabfY * 1.5, (Zofset + narrowH) - tabfZ])
                {
                    cube([tabfX, tabfY * 2, tabfZ + 10], center = false);
                }
            }
            
            // Wide part of tube
            difference()
            {
                cylinder(h=wideH, r=wideOD / 2, center=false);
                translate([-0,0,-1])
                {
                    cylinder(h=Zofset, r=wideID / 2, center=false);
                }
            }
            
            // The location tab (male)
            translate([-tabmX / 2, (narrowOD / 2) - (tabmY * 1.5), Zofset - tabmZ])
            {
                cube([tabmX, tabmY * 2, tabmZ], center = false);
            }
        }
    
        // Cut out for the -ve connection and spring etc.
        translate([-cutX / 2, -wideOD, cutZoffset])
        {
            cube([cutX, cutY, cutZ], center = false);
        }
        
        // The inner tube cutout
        translate([-0,0,-25])
        {
            cylinder(h=narrowH + wideH, r=narrowID / 2, center=false);
        }
    }
}

echo(version=version());

Bulgin_BX0013_Extension();