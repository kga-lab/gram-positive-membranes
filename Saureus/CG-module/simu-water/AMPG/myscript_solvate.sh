#!/bin/bash

EXE=gmx
###########SOLVATE
copy system_prod.gro from take3 folder of AMPG-lipid/mapping-2/simu-water/take3
vi system_prod.gro; this has 8711 water. I copied 8711th water three times and manually changed the coordinates to make total 8714 water. Because in other systems (Nesterenkonia and Sepidermidis) I have used 8714 water beads.


$EXE make_ndx -f system.gro -o index.ndx
