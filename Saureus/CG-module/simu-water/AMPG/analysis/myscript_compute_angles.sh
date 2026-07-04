#!/bin/bash

EXE=gmx
###### Angles
DIR="CG_angles"
mkdir $DIR
filendx=AMPG_index_angles.ndx

NANGLES=$(grep "\[" $filendx | wc -l)
IANG=0
while [ $IANG -lt $NANGLES ]; do
    echo $IANG | $EXE angle -f ../system_prod.xtc -n $filendx -ov $DIR/angle_$IANG.xvg -od $DIR/temp.xvg &> $DIR/temp_angles.txt
    echo "---- angle"$IANG" ----" >> $DIR/CG-data_angles.txt
   ## awk '/< angle >/ {print $5} /Std. Dev./ {print $4}' $DIR/temp_angles.txt >> $DIR/CG-data_angles.txt
    $EXE analyze -f $DIR/angle_$IANG.xvg -dist $DIR/histangle_$IANG.xvg -xvg none -bw 5.0 &> $DIR/temp2_angles.txt

     awk '/SS1/ {print $2} /SS1/ {print $3}' $DIR/temp2_angles.txt >> $DIR/CG-data_angles.txt

    ########NORMALIZE DISTRIBUTION
    sum1=$(awk '{s+=$2}END{print s}' $DIR/histangle_$IANG.xvg)
    awk -v r2="$sum1" '{print $1, $2/r2}' $DIR/histangle_$IANG.xvg > $DIR/normal_histangle_$IANG.xvg
    let IANG=$IANG+1
done
rm $DIR/\#temp*
##################HARI BOL!##################
