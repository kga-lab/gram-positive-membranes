#!/bin/bash
#####################CG
EXE=gmx_mpi
NATOM=26  #number of beads
mfile=mapping_CDL_A17_A15_18_A15.ndx 

seq 0 $NATOM | $EXE traj -s ../AA_massfix.tpr -f ../system_prod.xtc -n $mfile -com -ng $NATOM -oxt traj_AA2CG.xtc -pbc yes

seq 0 $NATOM | $EXE traj -s ../AA_massfix.tpr -f ../system_prod.gro -n $mfile -com -ng $NATOM -oxt CDLE_cg.gro -pbc yes


#########compute Reference/Target Bonded-Distrinbutions
#source myscript_target_bonds.sh
#source myscript_target_angles.sh
#source myscript_target_dihedrals.sh
#############################HARI BOL####################
