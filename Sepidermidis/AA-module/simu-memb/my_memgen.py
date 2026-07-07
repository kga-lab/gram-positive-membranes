from memgen import memgen

ratio=[116,84,56]
memgen(["DAGX_prod.pdb","PGLD_prod.pdb","CDLX.pdb"], "membrane.pdb", png="membrane.png", ratio=ratio, lipids_per_monolayer=256, water_per_lipid=35, area_per_lipid=65, added_salt=0, topology="topology.top")

