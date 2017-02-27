.data 
string: .space 100
prompt: .asciiz "Enter string: " 
result: .asciiz "New string: "
newline: .asciiz "\n"
char: .space 10

.text 
	#print out the prompt
	la $a0,prompt
	li $v0,4
	syscall
	
	#read the input with length restrictions in a1
	la $a0,string
	la $a1,string
	li $v0,8
	syscall
	
	la $t4,string #load the string into the register
	lb $s0,0($t4) #save the first char into s0
	
	la $t4,char #load the string into the register
	lb $s1,0($t4) #save the first char into s0
	
	
	move $t0,$zero #assign the value of zero to register t (old index)
	move $t1,$zero #assign the value of zero to register t (new index)
	li $t2,32
	li $t3,0
loop:
	lb $s1,string($t0) #Load the first byte of string into the character
	
	addi $t0,$t0,1 #inc old index
	
cond:   
	beq $s1,$t2,endofloop
	
otherwise:
	sb $s1,string($t1) #store the contents of s1 into the array of the string
	addi $t1,$t1,1
endofloop:
	beq $s1,$t3,printstring
	j loop
	
printstring:
	la $a0,result
	li $v0,4
	syscall

	la $a0,string
	li $v0,4
	syscall
	
	la $a0,newline
	li $v0,4
	syscall
	
	li $v0,10
	syscall
	
	
	
	
	