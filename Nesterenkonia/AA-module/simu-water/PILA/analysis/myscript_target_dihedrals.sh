### Dihedrals
DIR="CG_dihedrals"
mkdir $DIR
filendx=PI_16_A15_index_dihedrals.ndx

NDIHEDRALS=$(grep "\[" $filendx | wc -l)

IDIH=0
while [ $IDIH -lt $NDIHEDRALS ]; do
    echo $IDIH | gmx_mpi angle -type dihedral -f traj_AA2CG.xtc -n $filendx -ov $DIR/target_dih_$IDIH.xvg -od $DIR/temp.xvg &> $DIR/temp_dihedrals.txt
    echo "---- dih"$IDIH" ----" >> $DIR/AA-data_dihedrals.txt
    awk '/< angle >/ {print $5} /Std. Dev./ {print $4}' $DIR/temp_dihedrals.txt >> $DIR/AA-data_dihedrals.txt
    gmx_mpi analyze -f $DIR/target_dih_$IDIH.xvg -dist $DIR/target_histdih_$IDIH.xvg -xvg none -bw 2.0

    let IDIH=$IDIH+1
done
rm $DIR/\#temp*
