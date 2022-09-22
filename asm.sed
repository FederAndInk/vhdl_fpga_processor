S/\(.*\)/\U\1/
/--/d
s/BEGIN/memory_initialization_radix=16; \n memory_initialization_vector= \n 0000/
S/MOV/00/
S/NOP/0000/
S/ZERO/0/
S/R1/1/
s/R2/2/
s/R3/3/
S/R4/4/
s/R5/5/
S/RLED/A/
s/RSW/7/
s/R7SEG/B/
S/RSRC1/6/
S/RSRC2/8/
S/RDEST/C/
S/RAM/D/
S/RDM/7/
S/CO/E/
S/RI/9/
s/ //g
S/END/;/