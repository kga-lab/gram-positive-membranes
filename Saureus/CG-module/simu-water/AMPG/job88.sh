source /home/user/Downloads/plumed-2.9.1/sourceme.sh
source /usr/local/gromacs/bin/GMXRC

#gmx grompp -f step_mini.mdp -c system.gro -p topol.top -n index.ndx -o system_mini.tpr
#gmx mdrun  -deffnm system_mini -ntmpi 1 -ntomp 32

#gmx grompp -f step_eq1.mdp -c system_mini.gro -p topol.top -n index.ndx -o system_eq1.tpr -r system_mini.gro -maxwarn 1

#gmx mdrun  -deffnm system_eq1 -ntmpi 1 -ntomp 32

#gmx grompp -f step_eq2.mdp -c system_eq1.gro -p topol.top -t system_eq1.cpt -n index.ndx -o system_eq2.tpr -maxwarn 2 -r system_eq1.gro

#gmx mdrun  -deffnm system_eq2 -ntmpi 1 -ntomp 32

#gmx grompp -f step_eq3.mdp -c system_eq2.gro -p topol.top -t system_eq2.cpt -n index.ndx -o system_eq3.tpr -maxwarn 2 -r system_eq2.gro

#gmx mdrun  -deffnm system_eq3 -ntmpi 1 -ntomp 32


#gmx grompp -f step_eq4.mdp -c system_eq3.gro -p topol.top -t system_eq3.cpt -n index.ndx -o system_eq4.tpr 

#gmx mdrun  -deffnm system_eq4 -ntmpi 1 -ntomp 32

gmx grompp -f step_prod.mdp -c system_eq4.gro -p topol.top -t system_eq4.cpt -n index.ndx -o system_prod.tpr

gmx mdrun -s system_prod.tpr -deffnm system_prod -ntmpi 1 -ntomp 32
