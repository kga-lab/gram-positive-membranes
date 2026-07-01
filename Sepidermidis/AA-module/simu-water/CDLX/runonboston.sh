#!/bin/bash
EXE=gmx_mpi
#############MINIMIZATION
mpiexec -np 1 $EXE grompp -f step_mini.mdp -c system.gro  -p topol.top -n index.ndx -o system_mini.tpr -maxwarn 1

mpiexec -np 28  $EXE mdrun -s system_mini.tpr -deffnm system_mini -ntomp 1  

###############EQ1
mpiexec -np 1  $EXE grompp -f step_eq1.mdp -c system_mini.gro -p topol.top -n index.ndx -o system_eq1.tpr -maxwarn 1

mpiexec -np 28  $EXE mdrun -s system_eq1.tpr -deffnm system_eq1 -ntomp 1 

##############EQ2
mpiexec -np 1  $EXE grompp -f step_eq2.mdp -c system_eq1.gro -p topol.top -t system_eq1.cpt -n index.ndx -o system_eq2.tpr -maxwarn 1

mpiexec -np 28  $EXE mdrun -s system_eq2.tpr -deffnm system_eq2 -ntomp 1 

##############EQ3
mpiexec -np 1  $EXE grompp -f step_eq3.mdp -c system_eq2.gro -p topol.top -t system_eq2.cpt -n index.ndx -o system_eq3.tpr -maxwarn 1

mpiexec -np 28  $EXE mdrun -s system_eq3.tpr -deffnm system_eq3 -ntomp 1 

############EQ4
mpiexec -np 1  $EXE grompp -f step_eq4.mdp -c system_eq3.gro -p topol.top -t system_eq3.cpt -n index.ndx -o system_eq4.tpr -maxwarn 1

mpiexec -np 28  $EXE mdrun -s system_eq4.tpr -deffnm system_eq4 -ntomp 1 

###########PRODUCTION
mpiexec -np 1  $EXE grompp -f step_prod.mdp -c system_eq4.gro -p topol.top -t system_eq4.cpt -n index.ndx -o system_prod.tpr 

mpiexec -np 28  $EXE mdrun -s system_prod.tpr -deffnm system_prod -ntomp 1 
####################HARI BOL############################
