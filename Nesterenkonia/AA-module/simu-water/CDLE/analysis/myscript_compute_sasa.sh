#!/bin/bash

gmx sasa -s ../system_prod.tpr -f ../system_prod.xtc -n ../index.ndx -o sasa-CDLE_AA.xvg -probe 0.191 -ndots 4800 -b 200000 << EOF
1
EOF
# NOTE: 1 here means CDLE
