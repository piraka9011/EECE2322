.data
s1: .space 100
s2: .space 100
str1: .asciiz "Enter string 1: " 
str2: .asciiz "Enter string 2: " 
gt: .asciiz  "s1 > s2\n"
lt: .asciiz  "s1 < s2\n"
eq: .asciiz  "the strings are equal\n"

.text
	#prompt and input block
	#bgns
	la $a0,str1
	li $v0,4
	syscall
	
	la $a0,s1
	la $a1,s1
	li $v0,8
	syscall
	
	la $a0,str2
	li $v0,4
	syscall
	
	la $a0,s2
	la $a1,s2
	li $v0,8
	syscall
	#ends
	
	#inits
	li $t0,0 #index
	
	#c1, and c2 block
	la $t1,s1
	lb $s0,0($t1)
	
	la $t1,s2
	lb $s1,0($t1)
	
loop:
	lb $s0,s1($t0)
	
	lb $s1,s2($t0)
	
grt:	blt $s0,$s1,less	
	la $a0,gt
	li $v0,4
	syscall 
	j exit
	
less: 
	bgt $s0,$s1,equal
	la $a0,lt
	li $v0,4
	syscall 
	j exit
equal: 
	bne $s0,$s1,inc
	la $a0,eq
	li $v0,4
	syscall 
	j exit
inc:
	addi $t0, $t0, 1
	j loop

exit: 
	li $v0,10
	syscall