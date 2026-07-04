#!/bin/bash
#####################CG
EXE=gmx
NATOM=17  #beads

seq 0 $NATOM | $EXE traj -s ../AA_massfix.tpr -f ../system_prod.xtc -n mapping_ALPG.ndx -com -ng $NATOM -oxt traj_AA2CG.xtc -pbc yes



#########compute Reference/Target Bonded-Distrinbutions
#source myscript_target_bonds.sh
#source myscript_target_angles.sh
#source myscript_target_dihedrals.sh
#############################HARI BOL####################
