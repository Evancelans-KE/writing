
add xii, x6,-2   beqxn,xii,     exit 
add i x12,      x10,1 lw        x12
lix10,x10,0     lwx8,q(x12)     x10
lix10,0         lwx7,1(x10)     x10
lix10,0         add:x12,x10,1   x10
lwx7,1(x10)     add x9,x7,x8    x7
lwx8,a(x12)     add x9,x7,x8    x8
lix10,0         lw,x9,a(x10)    x10

--The Rows are load-use. This means that the registers are 
first loaded and the used in next instuction
