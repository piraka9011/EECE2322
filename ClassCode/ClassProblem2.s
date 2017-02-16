.data 
dst:	.space 100
src:	.asciiz "Hello world"

.text 
	la $s0, src #load the string into the register (src_ptr) 
	la $s1, dst #Load the bytes intro a register  (dst_putr)
body:

cond:
	beq , ,endloop
	j body
endloop:
