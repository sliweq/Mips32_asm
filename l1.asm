.data 
	msg1: .asciiz "a:"
	msg2: .asciiz "b:"
	msg3: .asciiz "c:"
	msg4: .asciiz "d:"
	msg5: .asciiz "x:"
	msg6: .asciiz "Wynik :"
.text
main:

	li $v0 4
	la $a0, msg5
	syscall
	
	li $v0, 5
	syscall
	move $t0, $v0


	li $v0 4
	la $a0, msg4
	syscall
	
	li $v0, 5
	syscall
	move $t1 $v0	
	

	li $v0 4
	la $a0, msg3
	syscall
	
	li $v0, 5
	syscall
	move $t2, $v0
	

	mul $t2, $t2, $t0
	add $t1, $t1, $t2

	
	li $v0 4
	la $a0, msg2
	syscall
	
	li $v0, 5
	syscall
	move $t2, $v0
	
	mul $t2, $t2, $t0
	mul $t2, $t2, $t0
	add $t1, $t1, $t2

	
	li $v0 4
	la $a0, msg1
	syscall
	
	li $v0, 5
	syscall
	add $t2, $zero, $v0
	
	mul $t2, $t2, $t0	
	mul $t2, $t2, $t0	
	mul $t2, $t2, $t0
	add $t1, $t2, $t1
	
	li $v0, 4
	la $a0, msg6
	syscall
	
	li $v0, 1
	move $a0, $t1
	syscall
			
