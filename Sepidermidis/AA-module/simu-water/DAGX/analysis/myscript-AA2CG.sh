#!/bin/bash
#####################CG
EXE=gmx
NATOM=13  #number of beads

seq 0 $NATOM | $EXE traj -s ../AA_massfix.tpr -f ../system_prod.xtc -n mapping_DAG_20_A15.ndx -com -ng $NATOM -oxt traj_AA2CG.xtc -pbc yes

seq 0 $NATOM | $EXE traj -s ../AA_massfix.tpr -f ../system_eq4.gro -n mapping_DAG_20_A15.ndx -com -ng $NATOM -oxt DAGX_cg.gro -pbc yes


#########compute Reference/Target Bonded-Distrinbutions
#source myscript_target_bonds.sh
#source myscript_target_angles.sh
#source myscript_target_dihedrals.sh
#############################HARI BOL####################
