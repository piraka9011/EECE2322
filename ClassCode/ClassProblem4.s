.data 

#declare all of the strings 
str: .asciiz "Enter first operand: "
op_str: .asciiz "Enter operation (+, -, *, /): "
bstr: .asciiz "Enter second operand: "
error_str: .asciiz "Invalid operation\n"
result_str: .asciiz "The result is "
newline: .asciiz "\n"
op: .space 10

.text 

la $a0, str #load the string
li $v0, 4
syscall #print the string

li $v0,5
syscall

move $s0, $v0 #$s0 stores the variable 

la $a0, op_str #enter operation
li $v0, 4
syscall


 #la $a0,op #where to store the returned value
 #la $a1,op #The limits of the buffer
 
 #alternatively
li $v0, 8
la $a0, op
li $a1, 10
syscall

li $v0, 4
la $a0, bstr
syscall

li $v0, 5
syscall 
move $s1, $v0 #$s1 =b

#load 1st char of string op

la $t0, op
lb $t0, 0($t0) #$t0= char[0] op

#switch statement


cond1:
	li $t1,43
	bne $t0, $t1, cond2
	add $s2, $s0, $s1 #result is equal to a + b
	j endswitch
cond2: 
	li $t1,45
	bne $t0, $t1, cond3
	sub $s2, $s0, $s1  #result is equal to a - b
	j endswitch 
cond3:
	li $t1,42
	bne $t0, $t1, cond4
	mult $s0, $s1  #result is equal to a * b
	mflo $s2 #save the result in the s2
	j endswitch
	
cond4:
	li $t1,47
	bne $t0, $t1, default
	div $s0, $s1
	mflo $s2
	j endswitch
default: 
	la $a0,error_str
	li $v0, 4
	syscall 
	li $v0,10 
	syscall

 endswitch: 
 	la $a0,result_str
 	li $v0, 4
 	syscall 
 	
 	li $v0,1
 	move $a0,$s2
 	syscall
 	
 	la $a0,newline
 	li $v0,4
 	syscall
 	 
 	li $v0,10 
 	syscall 
	


