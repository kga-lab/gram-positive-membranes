#!/bin/bash

###### Angles
DIR="CG_angles"
mkdir $DIR
EXE=gmx
filendx=CDL_20_A15_20_A15_index_angles.ndx
NANGLES=$(grep "\[" $filendx | wc -l)

IANG=0
while [ $IANG -lt $NANGLES ]; do
    echo $IANG | $EXE angle -f traj_AA2CG.xtc -n $filendx -ov $DIR/target_angle_$IANG.xvg -od $DIR/temp.xvg &> $DIR/temp_angles.txt
    echo "---- angle"$IANG" ----" >> $DIR/AA-data_angles.txt
  ##  awk '/< angle >/ {print $5} /Std. Dev./ {print $4}' $DIR/temp_angles.txt >> $DIR/AA-data_angles.txt
    $EXE analyze -f $DIR/target_angle_$IANG.xvg -dist $DIR/target_histangle_$IANG.xvg -xvg none -bw 5.0 &> $DIR/temp2_angles.txt

     awk '/SS1/ {print $2} /SS1/ {print $3}' $DIR/temp2_angles.txt >> $DIR/AA-data_angles.txt

    ########NORMALIZE DISTRIBUTION
    sum1=$(awk '{s+=$2}END{print s}' $DIR/target_histangle_$IANG.xvg)
    awk -v r2="$sum1" '{print $1, $2/r2}' $DIR/target_histangle_$IANG.xvg > $DIR/normaltarget_histangle_$IANG.xvg
    let IANG=$IANG+1
done
rm $DIR/\#temp*
##################HARI BOL!##################
