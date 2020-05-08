#Assembly LAB05 - Giorgos Virirakis, Mixalis Galanis

	.data
	
printLabyrinth: .asciiz "\nLabyrinth:\n"
printNewLine:	.asciiz "\n"

map: 
	.ascii 	"I.IIIIIIIIIIIIIIIIIII"
	.ascii 	"I....I....I.......I.I"
	.ascii 	"III.IIIII.I.I.III.I.I"
	.ascii 	"I.I.....I..I..I.....I"
	.ascii 	"I.I.III.II...II.I.III"
	.ascii 	"I...I...III.I...I...I"
	.ascii 	"IIIII.IIIII.III.III.I"
	.ascii	"I.............I.I...I"
	.ascii	"IIIIIIIIIIIIIII.I.III"
	.ascii	"@...............I..II"
	.asciiz	"IIIIIIIIIIIIIIIIIIIII"
	

temp:	.align 0
		.space 100
		
	.text
	
#"MAIN"
.globl main
main:
	
	li		$a0, 1 						#"Gathering input for MAKE_MOVE - STARTX"
	jal 	MAKE_MOVE					#"Calling MAKE_MOVE"
	jal 	PRINT_LABYRINTH             #"Calling PrintLabyrinth"
	li		$v0, 10						#"Exits the program"
	syscall
	
#"PRINT_LABYRINTH"
PRINT_LABYRINTH:

	#"Setting up counters"
	li		$t4, 0	#"i=0"
	li		$t5, 0	#"j=0"
	li		$t6, 0	#"k=0"

	addiu	$sp, $sp, -4				#"allocating stack space for $ra"
	sw		$ra, ($sp)					#"Store $ra to stack"
	
	jal 	USLEEP						#"Calls function USLEEP"
	
	#"print Labyrinth"
	li		$v0, 4 
	la		$a0, printLabyrinth
	syscall

	
label_loop_1:							#"Outside for loop"
	
	bge		$t4, 11, after_loop_1		#"H=11 "
	
label_loop_2:							#"Inside for loop"
	
	bge		$t5, 21, after_loop_2		#"W=21 "
	
	#"T7 = MAP[T6]
	la		$t7,map
	addu	$t7,$t7,$t6
	lb		$t7,($t7)
	
	#"temp[T5] = T7 "
	la		$t8,temp
	addu	$t8,$t8,$t5
	sb		$t7,($t8)
	
	addi	$t6,$t6,1					#"k++"
	
	addi	$t5,$t5,1					#"j++"
	
	j		label_loop_2
	
after_loop_2:
	
	addi	$t2,$t5,1					#"Creating j+1"
	
	#"temp[T8] = '\0'
	la		$t3,temp
	addu	$t3,$t3,$t2
	sb		$zero,($t3)
	
	#"Printing temp and \n"
	li		$v0, 4
	la		$a0, temp
	syscall
	
	li		$v0, 4
	la		$a0, printNewLine
	syscall
	
	li		$t5,0						#"Resetting j to 0"
	addi	$t4, $t4, 1					#"i++"
	j		label_loop_1
	
after_loop_1:
	
    lw		$ra, ($sp)					#"Restoring value of $ra from stack[0]"
	addiu	$sp, $sp, 4					#"Freeing stack memory"
	
	jr $ra								#"FUNCTION RETURN"
	
	
#"USLEEP"
USLEEP:
	li		$t0,0						
	
for_loop:
	bge 	$t0,30000,after_loop		#"<30000 for faster and >30000 is slower"
	addi	$t0,$t0,1
	j		for_loop
	
after_loop:
	
	jr		$ra							#"FUNCTION RETURN"
	
	
#"MAKE_MOVE"
MAKE_MOVE:
	
	addiu	$sp, $sp, -12				#"allocating space in stack"
	sw 		$ra, 0($sp)					#"Storing $ra to stack[0]"
	sw		$s0, 4($sp)					#"Storing $s0 to stack[1]"
	move	$s0,$a0						#"Storing function input $a0 in $s0"
	
	#"The two following if's are for initial check:"
	
	bgtz	$a0,after_cond_1			#"Checking for index<0"
	
	j RETURN_0							#"Jumps to RETURN_0 label"
	
after_cond_1:
	
	blt $a0,231,after_cond_2			#"Checking for index>TotalElements "
	
	j RETURN_0							#"Jumps to RETURN_0 label"
	
after_cond_2:
	
	#"Outside if"
	la		$t0,map						#"Saving first index of map to $t0"
	addu	$s1,$t0,$s0					#"Moving map index to $s1"
	sw		$s1, 8($sp)					#"Storing $s1 to stack[2]"
	lb		$t0,($s1)					#"Loading value of that index"

	bne		$t0,46,else_label			#"ASCII CODE FOR . is 46"
	
	li		$t0,42						#"ASCII CODE FOR * is 42"
	sb		$t0,($s1)					#"Replacing . with *"
	
	jal		PRINT_LABYRINTH				#"Calling PrintLabyrinth"
    
	
	#"First if"
	addu	$a0,$s0,1					#"a0 = S0 + 1 "
	
	jal		MAKE_MOVE					#"Calling MAKE_MOVE"
 
	bne		$v0,1,after_cond_3			#"Checking if MAKE_MOVE returns $v0 = 1"
	
	j		REPLACE						#"Replacing * with #"
	
after_cond_3:
	
	
	#"Second if"
	addi	$a0,$s0,21					#"a0 = S0 + W "
	jal		MAKE_MOVE					#"Calling MAKE_MOVE"
   
	bne		$v0,1,after_cond_4			#"Checking if MAKE_MOVE returns $v0 = 1"
	
	j		REPLACE						#"Replacing * with #"
	
after_cond_4:
	
	
	#"Third if"
	addi	$a0,$s0,-1					#"a0 = S0 - 1 "
	jal		MAKE_MOVE					#"Calling MAKE_MOVE"
  
	bne		$v0,1,after_cond_5			#"Checking if MAKE_MOVE returns $v0 = 1"
	
	j		REPLACE						#"Replacing * with #"
	
after_cond_5:
	
	
	#"Fourth if"
	addi	$a0,$s0,-21					#"A0 = S0 - W "
	jal		MAKE_MOVE					#"Calling MAKE_MOVE"

	bne		$v0,1,after_cond_6			#"Checking if MAKE_MOVE returns $v0 = 1"
	
	j		REPLACE						#"Replacing * with #"
	
after_cond_6:
	
	j after_cond
	
	
	#"ELSE"
else_label:
	
	bne		$t0, 64, after_cond			#"ASCII CODE FOR @ IS 64"
	li		$t0,37						#"ASCII CODE FOR % IS 37"
	sb		$t0,($s1)					#"Replacing @ with %"
	jal		PRINT_LABYRINTH				#"Calling PrintLabyrinth"
	
	j 		RETURN_1					#"Jumps to RETURN_1 label"

after_cond:
	
	j 		RETURN_0					#"Jumps to RETURN_0 label"
	
	
	
#"Replace with #"
REPLACE:
	lw		$s1,8($sp)					#"Restoring value of $s1 from stack[2]"
	
	li		$t0,35						#"ASCII CODE FOR # IS 35"
	sb		$t0,($s1)					#"Replacing * with #"
	
	j 		RETURN_1					#"Jumps to RETURN_1 label"
	

	
#"Return 0"
RETURN_0:
	
	lw		$s1, 8($sp)					#"Restoring value of $s1 from stack[2]"
	lw		$s0, 4($sp)					#"Restoring value of $s0 from stack[1]"
	lw		$ra, ($sp)					#"Restoring value of $ra from stack[0]"
	addiu	$sp, $sp, 12				#"Freeing stack memory"
	
	li		$v0,0
	jr		$ra							#"FUNCTION RETURN"

	
	
#"Return 1"
RETURN_1:

	lw		$s1, 8($sp)					#"Restoring value of $s1 from stack[2]"
	lw		$s0, 4($sp)					#"Restoring value of $s0 from stack[1]"
	lw		$ra, ($sp)					#"Restoring value of $ra from stack[0]"
	addiu	$sp, $sp, 12				#"Freeing stack memory"
	
	li		$v0,1						
	jr		$ra							#"FUNCTION RETURN"
	
	
	
