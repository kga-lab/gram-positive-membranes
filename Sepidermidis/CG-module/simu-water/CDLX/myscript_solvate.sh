#!/bin/bash

EXE=gmx
###########SOLVATE
copy CDLX_cg.gro from AA-module/simu-water/CDLX/analysis/

$EXE editconf -f CDLX_cg.gro -box 10.01 10.01 10.01 -center 5.005 5.005 5.005 -o CDLX_cg_fix.gro 

$EXE grompp -f step_mini.mdp -c CDLX_cg_fix.gro -p topol.top -o CDLX_cg_fix_mini.tpr -maxwarn 1
$EXE mdrun -v -deffnm CDLX_cg_fix_mini

$EXE solvate -cp CDLX_cg_fix_mini.gro -cs water.gro -p topol.top -o system.gro -maxsol 8716  2>&1 |tee  out1.txt

#Note we are keeping same number of water molecules as in other lipid systems have

#wn=$(awk '/Generated solvent/ {print $4}' out1.txt)
#echo "W    $wn" >> topol.top

##########ADD ions
$EXE grompp -f step_mini.mdp -c system.gro -p topol.top -o system_mini.tpr -r system.gro -maxwarn 1

echo "W" | $EXE genion -s system_mini.tpr -p topol.top -o system_fix.gro -pname K -pq 1 -nname CL -nq -1 -neutral

$EXE make_ndx -f system_fix.gro -o index.ndx
