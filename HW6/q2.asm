.data
	s: .space 100
	enter_string: .asciiz "Enter string: "
	result: .asciiz "New string: "
	newline: .asciiz "\n"
.text 
	# Print "Enter string: "
	la $a0, enter_string
	li $v0, 4
	syscall
	
	# Get user input
	la $a0, s
	la $a1, 100
	li $v0, 8
	syscall
	
	move $s0, $a0	# Move user input to s0 = s
	
	li $t0, 0	# t0 = old_index = 0
	li $t1, 0	# t1 = new_index 	= 0
# do
do:
	add $t3, $s0, $t0	# Let t3 point to position of old_index ( s[old_index] )
	lb $t2, 0($t3)		# t2 = c = s[old_index]
	addi $t0, $t0, 1	# old_index++
	
# if c == ' '
cond:	
	beq $t2, ' ', do
	
	add $s0, $s0, $t1	# Let t4 point to postion of new_index ( s[new_index] )
	sb $s0, 0($t2)		# s[new_index] = c
	addi $t1, $t1, 1	# new_index++
# while (c)
while:
	bnez $t2, do
	
	# Print "New sring: "
	la $a0, result
	li $v0, 4
	syscall
	
	# Print new string 
	la $a0, s
	syscall
	
	# Print new line
	la $a0, newline
	syscall
	
# return 0
	li $v0, 10
	syscall
	 