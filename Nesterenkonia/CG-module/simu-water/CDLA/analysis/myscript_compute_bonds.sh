#!/bin/bash

### Bonds and constraints 
DIR="CG_bonds"
mkdir $DIR
filendx=CDL_16_A15_16_A15_index_bonds.ndx
NBONDS=$(grep "\[" $filendx | wc -l)

IBOND=0
while [ $IBOND -lt $NBONDS ]; do
   echo $IBOND | gmx_mpi distance -f ../system_prod.xtc -n $filendx -oall $DIR/bond_$IBOND.xvg  &> $DIR/temp_bonds.txt -oh $DIR/histbond_$IBOND.xvg -len 0.6 -binw 0.010


    echo "---- bond"$IBOND" ----" >> $DIR/CG-data_bonds.txt
    awk '/Average distance/ {print $3} /Standard deviation/ {print $3}' $DIR/temp_bonds.txt >> $DIR/CG-data_bonds.txt
    #gmx_mpi analyze -f $DIR/bond_$IBOND.xvg -dist $DIR/histbond_$IBOND.xvg -xvg none -bw 0.002
      ########NORMALIZE DISTRIBUTION
    sum1=$(awk '{s+=$2}END{print s}' $DIR/histbond_$IBOND.xvg)
    awk -v r2="$sum1" '{print $1, $2/r2}' $DIR/histbond_$IBOND.xvg > $DIR/normal_histbond_$IBOND.xvg
    let IBOND=$IBOND+1
done
rm $DIR/\#temp*
#######################HARI BOL###############
