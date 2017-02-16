.data
v:	.half 5, 7, 1, 4, 3 
#increament by two to acces the data because it is a .half (16-bit)

newline: .asciiz "\n" #2bytes are allocated one for the \n and the other for the null
.text 

main:
ini:	li $s0, 0	#This is i
	
cond:	li $t0, 5	#This is the condition
	bge $s0,$t0,endloop #Cheacking the condition
body:
	sll $t0, $s0,1 #t0 contains i*2
	la $t1, v	#The address of v $t1 = &v[0]
	add $t1, $t1, $t0	#$t1 = &v[i]
	lh $t1, 0($t1) 		#$t1 = v[i]
#Print out the v[i]
	move $a0, $t1
	li $v0, 1 
	syscall 
	
	la $a0, newline
	li $v0,4
	syscall 
	
	#increament i
	addi $s0, $s0,1
	
	j cond
	
endloop:
	li $v0,10
	syscall 



	

