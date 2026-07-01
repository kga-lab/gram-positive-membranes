#!/bin/bash
source /usr/local/gromacs_mpi/bin/GMXRC

##export OMP_NUM_THREADS=2
#########################
gmx_mpi grompp -f step_mini.mdp -c system_fix.gro -p topol.top -n index.ndx -o system_mini.tpr -maxwarn 1
gmx_mpi mdrun -v -deffnm system_mini 

gmx_mpi grompp -f step_eq1.mdp -c system_mini.gro -p topol.top -n index.ndx -o system_eq1.tpr

gmx_mpi mdrun -v -deffnm system_eq1

gmx_mpi grompp -f step_eq2.mdp -c system_eq1.gro -p topol.top -t system_eq1.cpt -n index.ndx -o system_eq2.tpr -maxwarn 1

gmx_mpi mdrun -v -deffnm system_eq2

gmx_mpi grompp -f step_eq3.mdp -c system_eq2.gro -p topol.top -t system_eq2.cpt -n index.ndx -o system_eq3.tpr -maxwarn 1
gmx_mpi mdrun  -deffnm system_eq3


gmx_mpi grompp -f step_eq4.mdp -c system_eq3.gro -p topol.top -t system_eq3.cpt -n index.ndx -o system_eq4.tpr -maxwarn 1

gmx_mpi mdrun  -deffnm system_eq4

gmx_mpi grompp -f step_prod.mdp -c system_eq4.gro -p topol.top -t system_eq4.cpt -n index.ndx -o system_prod.tpr

gmx_mpi mdrun -s system_prod.tpr -deffnm system_prod -ntomp 32
