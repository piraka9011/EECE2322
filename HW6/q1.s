.data
	s1: .space 100
	s2: .space 100
	str_s1: .asciiz "Enter string 1: "
	str_s2: .asciiz "Enter string 2: "
	s1gts2: .asciiz "s1 > s2\n"
	s1lts2: .asciiz "s1 < s2\n"
	s1eqs2: .asciiz "The strings are equal\n"
	
.text
	# Print "Enter string 1: "
	la $a0, str_s1
	li $v0, 4
	syscall
	
	# Read in input
	la $a0, s1
	li $a1, 100
	li $v0, 8
	syscall
	
	move $s0, $a0	# Move input into saved temp0
	
	# Print "Enter string 2:
	la $a0, str_s2
	li $v0, 4
	syscall
	
	# Read in input
	la $a0, s2
	li $a1, 100
	li $v0, 8
	syscall
	
	move $s1, $a0	# Move input into saved temp1
	li $t0, 0	# Set temp0 as our index(int)
# while (1)
loop:	
	la $s1, s1	# c1 = s1
	add $s1, $s1, $t0
	lb $t1, 0($s1)	# c1 = s1[index]
	la $s2, s2	# c2 = s2
	add $s2, $s2, $t0
	lb $t2, 0($s2)	# c2 = s2[index]
# if c1 > c2
cond1:	
	ble $t1, $t2, cond2	
	la $a0, s1gts2		# Print s1 > s2
	li $v0, 4
	syscall
# if c1 < c2
cond2:	
	bge $t1, $t2, cond3	
	la $a0, s1lts2		# Print s1 < s2
	syscall
# if c1 == 0	 
cond3:	
	beq $t1, $zero, endloop	
	
# index++
	addi $t0, $t0, 1	# i = i + 1
	j loop
# return 0
endloop:
	la $a0, s1eqs2		# Print str =
	syscall
	li $v0, 10		# exit
	syscall
	  
	
