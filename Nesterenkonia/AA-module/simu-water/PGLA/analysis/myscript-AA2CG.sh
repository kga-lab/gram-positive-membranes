#!/bin/bash
#####################CG
EXE=gmx_mpi
NATOM=13  #number of beads

seq 0 $NATOM | $EXE traj -s ../AA_massfix.tpr -f ../system_prod.xtc -n mapping_PG_16_A15.ndx -com -ng $NATOM -oxt traj_AA2CG.xtc -pbc yes

seq 0 $NATOM | $EXE traj -s ../AA_massfix.tpr -f ../system_prod.gro -n mapping_PG_16_A15.ndx -com -ng $NATOM -oxt PGLA_cg.gro -pbc yes


#########compute Reference/Target Bonded-Distrinbutions
#source myscript_target_bonds.sh
#source myscript_target_angles.sh
#source myscript_target_dihedrals.sh
#############################HARI BOL####################
