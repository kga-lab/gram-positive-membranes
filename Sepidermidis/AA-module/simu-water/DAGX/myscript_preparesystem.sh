#!/bin/bash

EXE=gmx_mpi
molecule='DAGX'
############

$EXE editconf -f ${molecule}.gro -box 8 8 8 -center 4.0 4.0 4.0 -o ${molecule}.gro
$EXE grompp -f step_mini.mdp -c ${molecule}.gro -p topol.top -o system_mini.tpr -maxwarn 2

$EXE mdrun -v -deffnm system_mini

$EXE solvate -cp system_mini.gro -cs spc216.gro -p topol.top -o system_sol.gro -maxsol 16902

$EXE  grompp -f step_mini.mdp -c system_sol.gro -p topol.top -o system_mini.tpr -r system_sol.gro -maxwarn 1

$EXE genion -s system_mini.tpr -p topol.top -pname K -pq 1 -nname CL -nq -1 -neutral -o system.gro
$EXE make_ndx -f system.gro -o index.ndx  
