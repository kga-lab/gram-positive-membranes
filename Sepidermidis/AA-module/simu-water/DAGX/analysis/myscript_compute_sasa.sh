#!/bin/bash
EXE=gmx
$EXE sasa -s ../system_prod.tpr -f ../system_prod.xtc -n ../index.ndx -o sasa-DAGX_AA.xvg -probe 0.191 -ndots 4800 -b 200000

