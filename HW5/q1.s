.data
name: .space 100
namePrompt: .asciiz "Enter your name: "
hello: .asciiz "Hello, "
newLine: .asciiz "\n"

.text
	la $a0, namePrompt	# Store namePrompt in syscall f-n arg 0
	li $v0, 4		# Print string
	syscall	
	
	la $a0, name		# Store name in a0 for syscall (buffer)
	la $a1, name		# Set length of string to read for syscall
	li $v0, 8		# Read string
	syscall
	
	la $a0, hello		# Load a0 to print "hello"
	li $v0, 4		# Print string
	syscall
	
	la $a0, name		# Load ao to print 'name'
	syscall
	
	la $a0, newLine		# Load a0 for a new line
	syscall
	
	li $v0, 10		# Exit
	syscall		