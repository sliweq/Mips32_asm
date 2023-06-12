.data
	wektor1p: .space 400
	wektor1w: .space 400
	wektor2p: .space 400
	wektor2w: .space 400
	podajdlugosc: .asciiz "Podaj dlugosc wektorow:\n"
	podajwektor1: .asciiz "Podaj wektor1:\n"
	podajwektor2: .asciiz "Podaj wektor2:\n"
	wynikmsg: .asciiz "Iloczyn wektorow: "
	ta: .asciiz "petla"
.text
j main

zapiszdopamieciw1:
	sw $v0, wektor1w($t2)
	addi $t4, $t3, 1
	sw $t4, wektor1p($t1)
	addi $t2, $t2, 4
	addi $t1, $t1, 4
	jr $ra

zapiszdopamieciw2:
	sw $v0, wektor2w($t2)
	addi $t4, $t3, 1
	sw $t4, wektor2p($t1)
	addi $t2, $t2, 4
	addi $t1, $t1, 4
	jr $ra

iloczyn:
	#w t1 mam aktualny imdeks ktorego poszukuje 
	#w t0 jest liczba iteracji
	#w t2 bedzie wynik mnozenia 
	#w t3 bedzie wynik iloczynu
	#w t4 laduje liczbe z wektorap offset t5
	#t5 offset dla wektora 1
	#w t6 bedzie licznik petli
	li $t6, 0
	li $t5, 0
	li $t4, 0 
	petla1:
		lw $t4, wektor1p($t5)
		beqz $t4, powrot
		blt $t1, $t4, powrot
		beq $t1, $t4 znalezionyindeks1
		
		addi $t5, $t5, 4
		addi $t6, $t6, 1
		
		bge $t6, $t0, powrot

		j petla1
	znalezionyindeks1:
		lw $t9, wektor1w($t5)
		# w t9 znajduje sie teraz wartosc pod danym indeksem
		
		li $t4, 0 
		li $t5, 0
		li $t6, 0
	petla2:
		lw $t4, wektor2p($t5)
		beqz $t4, powrot
		blt $t1, $t4, powrot
		beq $t1, $t4 znalezionyindeks2
		
		addi $t5, $t5, 4
		
		addi $t6, $t6, 1
		bge $t6, $t0, powrot
		
		j petla2
	
	znalezionyindeks2:
		lw $t2, wektor2w($t5)
		mul $t2, $t2, $t9
		add $t3, $t3, $t2
	
powrot:
	jr $ra

main:
	la $a0, podajdlugosc
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall
	move $t0, $v0 #t0 dlugosc wektorow
	
	blez $t0, main
	bgt $t0, 99, main

	li $v0, 4
	la $a0, podajwektor1	
	syscall
	
	li $t1, 0 #offset zapisu porzadku
	li $t2, 0 #offset zapisu wartosci
	li $t3, 0 #licznik ile zapisano
	
podaj_wektor1:
	li $v0, 5
	syscall
	
	beqz $v0, pominiecie
	jal zapiszdopamieciw1
	
	pominiecie:
	
	addi $t3, $t3, 1
	
	bgt $t0, $t3, podaj_wektor1
	
komunikat_wektor2:
	li $v0, 4
	la $a0, podajwektor2
	syscall
	
	li $t1, 0 #offset zapisu porzadku
	li $t2, 0 #offset zapisu wartosci
	li $t3, 0 #licznik ile zapisano
	
podaj_wektor2:
	li $v0, 5
	syscall
	
	beqz $v0, pominieciew2
	jal zapiszdopamieciw2
	
	pominieciew2:
	addi $t3, $t3, 1
	
	bgt $t0, $t3, podaj_wektor2

#koniec zapisu
	li $t1, 1  #licznik indeks
	li $t2, 0  
	li $t3, 0   
	li $t6, 0
wylicziloczyn:
	
	jal iloczyn

	addi $t1, $t1, 1

	ble $t1, $t0, wylicziloczyn
	
printujwynik:

	li $v0,4
	la $a0, wynikmsg
	syscall
	li $v0, 1
	move $a0, $t3
	syscall
