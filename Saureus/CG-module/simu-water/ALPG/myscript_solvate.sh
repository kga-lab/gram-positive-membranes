#!/bin/bash

EXE=gmx
###########SOLVATE
copy system_prod.gro from take2 folder of ALPG-lipid/simu-water/take1
vi system_prod.gro; this has 8712 water. I copied 8712th water 2 times and manually changed the coordinates to make total 8714 water. Also I copied CL twice and made one atom as K. So total 8714 water, 1 K and 2 CL. Because in other systems (Nesterenkonia and Sepidermidis) I have used 8714 water beads.

$EXE make_ndx -f system.gro -o index.ndx
