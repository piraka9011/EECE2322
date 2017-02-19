.data
name:	.space 100
nameprompt: .asciiz "Enter your name: "
hello: .asciiz   "Hello, "
newline: .asciiz "\n"

.text
	la $a0, nameprompt  #store the prompt in the a0 register to print it out
	li $v0, 4	#Print string option 
	syscall		#Print string
	
	la $a0,name	#Store name in register a0 for cin purposes 
	la $a1,name	#Store name in register a1 for later print out purpose
	li $v0, 8	#Read string paramater
	syscall		#read the string from the user
	
	la $a0, hello	#Store the prompt in the a0 register to print it out
	li $v0, 4	#Print string paramter 
	syscall		#print out the string Hello
	
	la $a0, name	#Load name from register a1 to register a0
	li $v0, 4	#Print string paramter 
	syscall		#Print string
	
	la $a0, newline
	li $v0, 4
	syscall
	
	li $v0, 10	#exit parameter
	syscall 	#Terminate the program
	
