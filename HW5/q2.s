.data
	s: .space 20
	stringPrompt: .asciiz "Enter a string: "
	isLC: .asciiz "The first character is a lower-case letter\n"
	isNotLC: .asciiz "The first character is not a lower-case letter\n"
	char: .byte 'a', 'z'
.text
	la $a0, stringPrompt	# Load ao to print prompt
	li $v0, 4		# Print string
	syscall

	la $a0, s	# Set read_string buffer for syscall
	la $a1, s	# Set read_string length for syscall
	li $v0, 8	# Read string
	syscall
	
	la $t0, s		# Load string into temp addr
	lb $t0, ($t0)		# Load s[0] into saved temp (c)
	
	la $s0, char		# Load char[0]/a into register
	lb $s1, ($s0)		# Load 'a' in s1
	addi $s0, $s0, 1	# Load char[1]/z into register
	lb $s2, ($s0)		# Load 'z' in s2
	
cond:	
	bge $t0, $s2, else	# Branch if s[0] >= 'z'
	ble $t0, $s1, else 	# Branch if s[0] <= 'a'
	
	la $a0, isLC		# Load print lowercase into syscall addr
	li $v0, 4		# Print string
	syscall
	
	j exit

else: 	
	la $a0, isNotLC		# Load print Not Lowercase into syscall addr
	syscall			# Print string
	
exit:	
	li $v0, 10		# Exit
	syscall
	