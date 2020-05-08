	.data
welcome: .asciiz "Welcome to LAB03!" 

printMenu: .asciiz "\nMAIN MENU\n============================================\n1. Function 1\n--------------------------------------------\n2. Function 2\n--------------------------------------------\n3. Function 3\n--------------------------------------------\n4. Exit\n============================================\nPlease Select Action: "
selectedFunction1: .asciiz "\nYou have selected function 1"
selectedFunction2: .asciiz "\nYou have selected function 2"
selectedFunction3: .asciiz "\nYou have selected function 3"
selectedExit: .asciiz "Thank you for using our program! Exiting. . ."
actionNotFound: .asciiz "Action not found!"

action: .word 0




	.text
.globl __start
__start:
	
	li	$v0, 4
	la	$a0, welcome
	syscall	
	
	
	lw $t0,action
	li $t1,4
	
	while_label:
		beq $t0,$t1,after_loop
		
		#"DISPLAY MENU"
		li	$v0, 4
		la	$a0, printMenu
		syscall	

		li	$v0, 5 #"READ INTEGER FROM USER"
		syscall
		sw	$v0, action
		
		
		move $t0,$v0
		li $t2,1
		li $t3,2
		li $t4,3
		
		bne $t0,$t2,else_label_1 #"FIRST IF"
		
		li	$v0, 4
		la	$a0, selectedFunction1
		syscall	
		
		j after_cond
		else_label_1: #"FIRST ELSE"
			bne $t0,$t3,else_label_2 #"SECOND IF"
			
			li	$v0, 4
			la	$a0, selectedFunction2
			syscall	
			
			j after_cond
			else_label_2: #"SECOND ELSE"
			
				bne $t0,$t4,else_label_3 #"THIRD IF"
			
				li	$v0, 4
				la	$a0, selectedFunction3
				syscall	
			
				j after_cond
				else_label_3: #"THIRD ELSE"
					bne $t0,$t1,else_label_4 #"FOURTH IF"
			
					li	$v0, 4
					la	$a0, selectedExit
					syscall	
					li	$v0, 10
					syscall
			
					j after_cond
					else_label_4: #"FOURTH ELSE"
						li	$v0, 4
						la	$a0, actionNotFound
						syscall	
						after_cond:
		j while_label
	after_loop:
		li	$v0, 10
		syscall