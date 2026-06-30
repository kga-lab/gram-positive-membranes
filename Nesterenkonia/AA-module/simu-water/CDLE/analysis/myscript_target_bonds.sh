#!/bin/bash

### Bonds and constraints 
DIR="CG_bonds"
mkdir $DIR

filendx=CDL_A17_A15_18_A15_index_bonds.ndx
NBONDS=$(grep "\[" $filendx | wc -l)

IBOND=0
while [ $IBOND -lt $NBONDS ]; do
   echo $IBOND | gmx_mpi distance -f traj_AA2CG.xtc -n $filendx -oall $DIR/target_bond_$IBOND.xvg  &> $DIR/temp_bonds.txt -len 0.6 -binw 0.010 -oh $DIR/target_histbond_$IBOND.xvg


    echo "---- bond"$IBOND" ----" >> $DIR/AA-data_bonds.txt
    awk '/Average distance/ {print $3} /Standard deviation/ {print $3}' $DIR/temp_bonds.txt >> $DIR/AA-data_bonds.txt
    ##gmx_mpi analyze -f $DIR/target_bond_$IBOND.xvg -dist $DIR/target_histbond_$IBOND.xvg -xvg none -bw 0.010
      ########NORMALIZE DISTRIBUTION
    sum1=$(awk '{s+=$2}END{print s}' $DIR/target_histbond_$IBOND.xvg)
    awk -v r2="$sum1" '{print $1, $2/r2}' $DIR/target_histbond_$IBOND.xvg > $DIR/normaltarget_histbond_$IBOND.xvg
    let IBOND=$IBOND+1
done
rm $DIR/\#temp*
#######################HARI BOL###############
