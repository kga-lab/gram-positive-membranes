#!/bin/bash

EXE=gmx
###########SOLVATE
copy system_prod.gro from take2 folder of ACDL-lipid/simu-water/take2
vi system_prod.gro; this has 8706 water. I copied 8706th water 8 times and manually changed the coordinates to make total 8714 water. Because in other systems (Nesterenkonia and Sepidermidis) I have used 8714 water beads.


$EXE make_ndx -f system.gro -o index.ndx
