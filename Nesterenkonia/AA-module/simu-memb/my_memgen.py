from memgen import memgen

ratio=[54,30,24,12,8]
memgen(["cdla_prod.pdb","cdld_prod.pdb","cdle_prod.pdb","pgla_prod.pdb","pila_prod.pdb"], "membrane.pdb", png="membrane.png", ratio=ratio, lipids_per_monolayer=128, water_per_lipid=35, area_per_lipid=65, added_salt=0, topology="topology.top")
