.data
	tablica: .space 400
	tekst1: .asciiz "\nPodaj n: "
	tekst2: .asciiz "Podaj liczbe: "
	tekst3: .asciiz "\nPosortowana tablica: "
	tekst4: .asciiz ", "
.text			
main:
li $v0, 4
la $a0, tekst1
syscall

li $v0, 5
syscall

blez $v0, main
bgt $v0, 100, main
	
li $t1, 0 #licznik dla n
li $t2, 0 #indeks tablicy
move $t0, $v0
wprowadzanie:
	
li $v0, 4
la $a0, tekst2
syscall
	
li $v0, 5
syscall
	
sw $v0, tablica($t2)
addi $t1, $t1, 1
addi $t2, $t2, 4
	
blt $t1, $t0, wprowadzanie #t0 to jest n

	
subi $t0 ,$t0, 1 #licznik
li $t1, 0 # x
petla1:
	bge $t1, $t0, koniec
	li $t2, 0 # i do drugje petli
	sub $t3, $t0, $t1
	li $t4, 0 #adres 1
	li $t5, 4 # adres 2
	petla2:
			
		lw $t8, tablica($t4)
		lw $t9, tablica($t5)
			
		bgt $t9, $t8, bezzmiany
		move $t7, $t8

		sw $t9, tablica($t4)
		sw $t8, tablica($t5)
			
		bezzmiany:
			addi $t4, $t4, 4
			addi $t5, $t5, 4
			addi $t2, $t2, 1 
			 
		blt $t2, $t3, petla2
			
			
	addi $t1, $t1, 1	
	j petla1 
	
koniec:	
li $v0, 4
la $a0, tekst3
syscall

addi $t0, $t0, 1
li $t1, 0 
li $t2, 0
petlawyswietl:
	
	lw $a0, tablica($t2)
	li $v0, 1
	syscall
	addi $t2, $t2, 4
	addi $t1, $t1 ,1
	beq $t1, $t0,wyjscie
	
	la $a0, tekst4
	li $v0, 4
	syscall
	j petlawyswietl
wyjscie:
	
	
	
	
	




