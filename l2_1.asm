.data 
	msg1: .asciiz "Podaj N: "
	msg2: .asciiz "Wynik:"
	msg3: .asciiz "Przepelnienie!\n"

.text
main:
	li $v0 4
	la $a0, msg1
	syscall
	
wczytywanie:
	li $v0, 5
	syscall
	bgtz $v0, przeniesienie
	j main
	
przeniesienie:
	li $t1, 0 
	li $t2, 1 
	move $t0, $v0
	
# do while

obliczanie:
	addi $t1, $t1, 1
	mul $t2, $t2, $t1
	
	mfhi $t9
	bnez $t9, przepelnienie
		
	beq $t1, $t0, wynik
	j obliczanie
	
wynik:
	li $v0, 4
	la $a0, msg2
	syscall
	li $v0, 1
	move $a0, $t2
	j koniec
	
przepelnienie:
	li $v0, 4
	la $a0, msg3
koniec:
	syscall