#Assembly LAB04 - Giorgos Virirakis, Mixalis Galanis

	.data
#"Menu Related  Strings to be printed "
menuWelcome: .asciiz "Welcome to LAB04!"
menuFunctions: .asciiz "\n\nMAIN MENU\n============================================\n1. Function 1\n--------------------------------------------\n2. Function 2\n--------------------------------------------\n3. Function 3\n--------------------------------------------\n4. Function 4\n--------------------------------------------\n5. Exit\n============================================\nPlease Select Action: "
menuSelectedExit: .asciiz "Thank you for using our program! Exiting . . ."
menuActionNotFound: .asciiz "Action not found!"

#"Input Strings to be printed "
inputInteger: .asciiz "Please Enter an Integer (N): "
inputArrayInteger: .asciiz "Please Enter Integer "
inputArrayChar: .asciiz "Please Enter a String: "

#"Output Strings to be printed"
outputTotalNumbers: .asciiz "Total Numbers printed: "
outputOddNumber: .asciiz " is Odd (Monos)"
outputEvenNumber: .asciiz " is Even (Zigos)"
outputOldArray: .asciiz "\nOld Array of Integers: "
outputNewArray: .asciiz "\nNew Array of Integers: "
outputOldString: .asciiz "\nOld String: "
outputNewString: .asciiz "New String: "

space: .asciiz " "
newLine: .asciiz "\n"
doubleDot: .asciiz ":"

#"Arrays needed for functions 3 and 4"
intArray1:	 .align 2
			.space 20
		  
intArray2: 	.align 2
			.space 20	  

charArray1: .align 0
			.space 100
		  
charArray2: .align 0
			.space 100
	
	
	.text
	
.globl main
main:

	#"NOTE: $a0 is preserved for all prints/scans"
	
	li	$v0, 4 #"Welcome"
	la	$a0, menuWelcome
	syscall	
	
	li $t0,0    #"$t0 is a N"
	li $t1,0	#"$t1 is action. Initialized to 0"

	
	while_label_MAIN:
		beq $t1,5,after_loop_MAIN
			
			#"DISPLAY MENU"
			li	$v0, 4
			la	$a0, menuFunctions
			syscall	
			
			li	$v0, 5 #"READ ACTION FROM USER"
			syscall
			move $t1,$v0
						
			bne $t1,1,else_MAIN_1 #"FIRST IF - FUNCTION_1"
			
			li	$v0, 4 
			la $a0, inputInteger
			syscall
			
			li $v0,5 #"READ INTEGER FROM USER"
			syscall
			move $t0,$v0
			
			move $a1,$t0 #"$a1 is the first parameter"
			
			jal FUNCTION_1 #"Calls Function_1, Sends $a1, returns $v0"
			
			move $t4,$v0 #"Numbers Printed stored in $t4"
			
			li	$v0, 4
			la	$a0, outputTotalNumbers
			syscall
			
			li $v0, 1 #"Prints actual number of numbers printed"
			move $a0,$t4  
			syscall	
			
			j after_cond
			else_MAIN_1: #"FIRST ELSE"
				bne $t1,2,else_MAIN_2	 #"SECOND IF - FUNCTION_2"
				
				li	$v0, 4 
				la $a0, inputInteger
				syscall
			
				li $v0,5 #"READ INTEGER FROM USER"
				syscall
				move $t0,$v0
				
				move $a1,$t0 #"$a1 is the first parameter"
				
				jal FUNCTION_2 #"Calls Function_2, Sends $a1, returns $v0"
				
				move $t0,$v0  #"Here $t0 is a register that helps us not lose value of $a1"
				
				bne $t0,$zero,else_MAIN_fun2 #"If $v0 is 0"
				
					li $v0, 1
					move $a0, $a1 #"$a1 is number extracted from user"
					syscall
				
					li	$v0, 4
					la	$a0, outputEvenNumber
					syscall	

					j after_cond_MAIN_fun2
				
				else_MAIN_fun2: #"If $t0 is 1"
					
					li $v0, 1
					move $a0, $a1 #"$a1 is number extracted from user"
					syscall
				
					li	$v0, 4
					la	$a0, outputOddNumber
					syscall	
					
				after_cond_MAIN_fun2:
					j after_cond
					
				else_MAIN_2: #"SECOND ELSE"
					bne $t1,3,else_MAIN_3 #"THIRD IF - FUNCTION_3"
						
						la $a1,intArray1 #"$a1 is the adress of the first integer of intArray1"
						la $a2,intArray2 #"$a2 is the adress of the first integer of intArray2"
						
						li $t4,1 #"i=1"
						label_loop_MAIN_1:
							bgt $t4,5,after_loop_MAIN_1
								
								li	$v0, 4
								la	$a0, inputArrayInteger
								syscall	

								li $v0, 1
								move $a0, $t4
								syscall
								
								li	$v0, 4
								la	$a0, doubleDot
								syscall
						
						
								li $v0,5 #"READ INTEGER FROM USER"
								syscall
								move $t0,$v0 #"Storing input number to $v0"
								
								sw $v0, ($a1) #"Storing N to intArray1"
								
								addiu $a1, $a1, 4 #"Move $a1 to next integer"
								
								addi $t4,$t4,1 #"i++"
								
								j label_loop_MAIN_1
								
								after_loop_MAIN_1:
									
									la $a1,intArray1 #"$a1 is the adress of the first integer of intArray1"
									
									move $t6,$a1
									
									jal FUNCTION_3 #"Calls Function_3, Sends $a1,$a2 returns $v0"
									
									move $a2,$v0
									
									li	$v0, 4
									la	$a0, outputOldArray
									syscall
									
									move $a1,$t6
								
									li $t4,1 #"i=1"
									label_loop_MAIN_2:
										bgt $t4,5,after_loop_MAIN_2
											
											lw $t5, ($a1) #"Storing integer of $a1 into $t5"
										
											#"Print number"
											li $v0, 1
											move $a0, $t5 
											syscall					
											
											#"print space"
											li	$v0, 4
											la	$a0, space
											syscall							
											
											addi $t4,$t4,1 #"i++"							
											
											addiu $a1, $a1, 4 #"Move $a1 to next integer"		
						
											j label_loop_MAIN_2
											
											after_loop_MAIN_2:
													
												li	$v0, 4
												la	$a0, outputNewArray
												syscall
											
												li $t4,1 #"i=1"
												label_loop_MAIN_3:
													bgt $t4,5,after_loop_MAIN_3
														
														lw $t5, ($a2)  #"Storing integer of $a2 into $t5"
													
														#"Print number"
														li $v0, 1
														move $a0, $t5
														syscall					
														
														#"print space"
														li	$v0, 4
														la	$a0, space
														syscall							
														
														addi $t4,$t4,1 #"i++"							
														
														addiu $a2, $a2, 4 #"Move $a2 to next integer"				
									
														j label_loop_MAIN_3
														
														after_loop_MAIN_3:
															j after_cond
															
				else_MAIN_3:  #"THIRD ELSE"
					bne $t1,4,else_MAIN_4 #"FOURTH IF - FUNCTION_4"
						
						li	$v0, 4
						la	$a0, inputArrayChar
						syscall	
						
						li $v0, 8 
						la $a0, charArray1
						syscall
						
						la $a1,charArray1 #"$a1 is the adress of the first character of charArray1"
						la $a2,charArray2 #"$a2 is the adress of the first character of charArray2"
						
						move $t4,$a1 #"Hold $a1 into $t4"
						move $t5,$a2 #"Hold $a2 into $t5"
						
						jal FUNCTION_4  #"Calls Function_4, Sends $a1,$a2 returns $v0"
						
						move $a1,$t4 #"Restoring true $a1"
						move $a2,$t5 #"Restoring true $a2"
						
						li	$v0, 4
						la	$a0, outputOldString
						syscall	
						
						li	$v0, 4
						la	$a0, charArray1
						syscall
						
						
						li	$v0, 4
						la	$a0, outputNewString
						syscall	
						
						li	$v0, 4
						la	$a0, charArray2
						syscall	
						
						lb $t4,($a1)
						lb $t5,($a2)
						
						#"Clearing String at the end"
						li $t6,0 #"i = 0"
						while_label_MAIN_function4:
							bge $t6,100,after_loop_MAIN_4 #"100 For Loops"
								
								#"Clearing oldString"
								lb $t4,($a1)
								move $t4,$zero
								sb $t4,($a1)
								
								#"Clearing newString"
								lb $t5,($a2)
								move $t5,$zero
								sb $t5,($a2)
								
								#"Move $a's to next char"
								addi $a1,$a1,1 
								addi $a2,$a2,1
								
								#"i++"
								addi $t6,$t6,1
								
								j while_label_MAIN_function4
							after_loop_MAIN_4:
							
						j after_cond
						
				else_MAIN_4: #"FOURTH ELSE"
					bne $t1,5,else_MAIN_5  #"FIFTH IF - EXIT"
						
						li	$v0, 4
						la	$a0, menuSelectedExit
						syscall	
						li	$v0, 10
						syscall
						
						j after_cond
					else_MAIN_5:#"FIFTH ELSE - Action Not Found"
						li	$v0, 4
						la	$a0, menuActionNotFound
						syscall	
						after_cond:
		j while_label_MAIN
	after_loop_MAIN:
		li	$v0, 10 #"Exits the program"
		syscall


FUNCTION_1:
	
	li $t1,0 #"counter"
	li $t2,1 #"i, R15"
	li $t3,1 #"j, R16"
	
	label_loop_function1_1: #"Outside For Loop"
		bgt $t2,$a1,after_loop_function1_1
		
		label_loop_function1_2: #"Inside For Loop"
			bgt $t3,$t2,after_loop_function1_2
				
				#"print j"
				li $v0, 1
				move $a0, $t3
				syscall
					
				#"print space"
				li	$v0, 4
				la	$a0, space
				syscall		
				
				#"counter++, j++"
				addi $t1,$t1,1
				addi $t3,$t3,1	
			
				j label_loop_function1_2
				
			after_loop_function1_2:
				
				#"Sets j to 1 every time the Inside Loop "
				li $t3,1
			
				#"print \n"
				li	$v0, 4
				la	$a0, newLine
				syscall
				
				addi $t2,$t2,1 #"i++"
					
				j label_loop_function1_1
			
		after_loop_function1_1:
			move $v0,$t1
			jr $ra #"End of Function_1"
				
		

FUNCTION_2: #"Input: $a1, Output: $v0"
	move $t0,$a1 #"a1 (number extracted from user) is reserved"
	
	blt $t0,$zero,else_function2_1 #"Positive Numbers"
		
		while_label_function2_1:
			ble $t0,1,after_loop_function2_1
			
				addi $t0,$t0,-2 #"N = N-2"
			
				j while_label_function2_1
				after_loop_function2_1:
					move $v0,$t0 #"$t0 copied into return variable $v0"
					jr $ra #"End of Function_2"
	
	else_function2_1: #"Negative Numbers"
		while_label_function2_2:
			bge $t0,-1,after_loop_function2_2
			
				addi $t0,$t0,2 #"N = N+2"
				
				j while_label_function2_2
				after_loop_function2_2:
					subu $t0,$zero,$t0 #"t0 becomes -t0, returns -N"
					move $v0,$t0 #"$t0 copied into return variable $v0"
					jr $ra #"End of Function_2"

	
	
FUNCTION_3: #"Input: $a1,$a2 Output: $v0"

	move $t0,$a2
	li $t1,0 #"i = 0"
	li $t2,1 #"j = 1"

	
	label_loop_function3_1: #"Outside For Loop (for each integer)"
		bge $t1,5,after_loop_function3_1 #"5 for 5 integers"
			
			lw $t5, ($a1) #"Stores value of each consecutive integer to $t5"
			lw $t3, ($a1) #"Stores value of each consecutive integer to $t5 again for multiplication and not exponent"

			addiu $a1,$a1,4 #"Move $a1 to next integer"
			
			label_loop_function3_2:  #"Inside For Loop (multiplication by 6)"
				bge $t2,6,after_loop_function3_2 #"6 for times added"
					
					
					add $t5,$t5,$t3 #"$t5 = $t5 + $t3 (multiplication), t3 is constant"
					
					addi $t2,$t2,1 #"j++"
					
					
					j label_loop_function3_2
					after_loop_function3_2:
					
						li $t2,1 #"Sets j to 1 every time outside loop occurs"
					
						addi $t1,$t1,1 #"i++"
						sw $t5, ($a2)
						addiu $a2, $a2, 4 #"Move $a2 to next integer"
						
						j label_loop_function3_1
						after_loop_function3_1:
							
							move $v0,$t0 #"$t0 (value of $a2 at start) copied into return variable $v0"
							jr $ra #"End of Function_3"
							
					

FUNCTION_4: #"Input: $a1,$a2 Output: $v0"
	
	lb $t0, ($a1) #"Store value of first char to $t0"
	
	while_label_function4:
		beq $t0,$zero,after_loop_function4 #"While char!=NULL"
			addi $a1,$a1,1 #"Move $a1 to next char"
			blt $t0,97,else_function4_1 #"Old is Lowercase"
			bgt $t0,122,else_function4_1 #"Old is Lowercase"
			
				addi $t0,$t0,-32 #"Convert to Uppercase"
				j after_cond_function4
				
		else_function4_1:
			blt $t0,65,else_function4_2 #"Old is Uppercase"
			bgt $t0,90,else_function4_2#"Old is Uppercase"
			
				addi $t0,$t0,32 #"Convert to Lowercase"
				j after_cond_function4
				
			else_function4_2:
		after_cond_function4:
			sb $t0,($a2) #"Store"
			addi $a2,$a2,1 #"Move $a2 to next char"
			lb $t0, ($a1) #"Store value of current char to $t0"
		
		j while_label_function4
		after_loop_function4:
		jr $ra
		
		
		