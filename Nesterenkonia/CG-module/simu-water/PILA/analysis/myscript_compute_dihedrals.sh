### Dihedrals
DIR="CG_dihedrals"
mkdir $DIR
filendx=PI_16_A15_index_dihedrals.ndx

NDIHEDRALS=$(grep "\[" $filendx | wc -l)

IDIH=0
while [ $IDIH -lt $NDIHEDRALS ]; do
    echo $IDIH | gmx_mpi angle -type dihedral -f ../system_prod.xtc -n $filendx -ov $DIR/dih_$IDIH.xvg -od $DIR/temp.xvg &> $DIR/temp_dihedrals.txt
    echo "---- dih"$IDIH" ----" >> $DIR/CG-data_dihedrals.txt
    awk '/< angle >/ {print $5} /Std. Dev./ {print $4}' $DIR/temp_dihedrals.txt >> $DIR/CG-data_dihedrals.txt
    gmx_mpi analyze -f $DIR/dih_$IDIH.xvg -dist $DIR/histdih_$IDIH.xvg -xvg none -bw 2.0

    let IDIH=$IDIH+1
done
rm $DIR/\#temp*
