.data
s: .space 20
prompt: .asciiz "Enter a string: "
lowercase: .asciiz "The first character is a lower-case letter"
notlower: .asciiz "The first character is not a lower-case letter"
char: .byte 'a', 'z'
newline: .asciiz "\n"
.text
	la $a0, prompt  #store the prompt in the a0 register to print it out
	li $v0, 4	#Print string option 
	syscall		#Print string
	
	la $a0,s	#Store string in register a0 for cin purposes 
	la $a1,s	#Store string in register a1 for later print out purpose
	li $v0, 8	#Read string paramater
	syscall		#read the string from the user
	
	la $s0, char #Loads the char[0] into the register (a)
	lb $s1, ($s0) #loads a
	addi $s0,$s0,1 #loads char[1] into the register (z)
	lb $s2,($s0) #loads z
	
	la $t0, s #load the string s[0] into the register
	lb $t0, ($t0) #load the value into the register
	
	
cond:	bgt  $t0,$s2,else 
	blt  $t0,$s1,else

	la $a0, lowercase
	li $v0, 4
	syscall
	
	la $a0, newline
	li $v0, 4
	syscall
	
	j exit
else:

	la $a0, notlower
	li $v0, 4
	syscall
	
	la $a0, newline
	li $v0, 4
	syscall
	
exit:
	li $v0,10
	syscall