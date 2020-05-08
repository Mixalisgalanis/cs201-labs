#"Assembly LAB06 (Part A) - Giorgos Virirakis, Mixalis Galanis"

	.data
	
#"CONSTANTS"
NEXT_LINE 			= 10
NULL				= 0

RECEIVER_CONTROL	= 0xffff0000
RECEIVER_DATA		= 0xffff0004
TRANSMIT_CONTROL	= 0xffff0008
TRANSMIT_DATA		= 0xffff000c

READY_BIT			= 0x1
	
#"PRINT MESSAGES"
newLine: .asciiz 	"\n" 
input:   .asciiz 	"Please type the string: "
output:	 .asciiz	"New String: "

#"STRING ARRAY"
string:				.align 0
					.space 100

					
	.text
	.globl main
	
#"MAIN"
main:	
	la 			$a0, input							#"Loading address of first element of string"
	jal 		WRITE_STR							#"CALL WRITE STRING FUNCTION"
	
	la 			$a0, string							#"Loading address of first element of string"
	jal 		READ_STR							#"CALL READ STRING FUNCTION"
	
	la			$a0, newLine						#"Loading address of first element of string"
	jal 		WRITE_STR							#"CALL WRITE STRING FUNCTION"
	
	la			$a0, output							#"Loading address of first element of string"
	jal 		WRITE_STR							#"CALL WRITE STRING FUNCTION"

	la 			$a0, string							#"Loading address of first element of string"
	jal			CONVERTER							#"CALL CONVERTER FUNCTION"
	
	la 			$a0,string							#"Loading address of first element of string"
	jal 		WRITE_STR							#"CALL WRITE STRING FUNCTION"
	
	li 			$v0, 10								#"EXIT"
	syscall											#"System Call"
	

#"READ_CH"
READ_CH:
	li 			$t0, RECEIVER_CONTROL				#"t0 is the address of RECEIVER_CONTROL"
	lw 			$t1, ($t0)							#"t1 is the value of RECEIVER_CONTROL"
	
check_read:											#"Checks repeatedly if ready bit is 1"
	bne 		$t1,NULL, read_char					#"Go to read_char if it's ready"
	lw 			$t1, ($t0)							#"t1 is the value of RECEIVER_CONTROL"
	andi 		$t1,$t1, READY_BIT					#"t1 becomes AND(t1,READY_BIT)"
	j 			check_read							#"loop again"

read_char:										
	lw			$v0, RECEIVER_DATA					#"READ_CH returns v0, which is the value of RECEIVER_DATA"
	jr 			$ra									#"Function exits"
	

#"WRITE_CH"
WRITE_CH:
	lw			$t1, TRANSMIT_CONTROL				#"t0 is the address of TRANSMIT_CONTROL"
	bne 		$t1,NULL, write_char				#"Go to read_char if t1 != null"
	andi 		$t1,$t1, READY_BIT					#"t1 becomes AND(t1,READY_BIT)"
	j 			WRITE_CH							#"loop again"
	
write_char:
	sw 			$a0, TRANSMIT_DATA					#"value of TRANSMIT_DATA gets saved in a0"
	jr 			$ra									#"Function exits"
	
	
#"READ_STR"
READ_STR:
	addi 		$sp, $sp, -16						#"Allocate 16 bytes for stack"
	sw 			$ra, 0($sp)							#"Storing $ra to stack"
	sw 			$s0, 4($sp)							#"Storing $s0 to stack"
	sw 			$s3, 8($sp)							#"Storing $s3 to stack"
	sw			$s4, 12($sp)						#"Storing $s4 to stack"
	
	la			$s0, string							#"$s0 = address of first element of string"
	li			$s3, 0								#"$s3 is the counter"
	
label_loop_read_str:
	jal			READ_CH								#"CALL READ_CH FUNCTION"
	
	move 		$s4, $v0							#"READ_CH returns v0 which we take and use as s4"
	add			$t0, $s0, $s3 						#"Used for accessing the n'th element of string"
	sb 			$s4, ($t0)							#"Storing address of $t0 into s4"
	
	beq 		$s4,NEXT_LINE,after_cond_read_str	#"Checking if we press enter "
	beq			$s4,NULL,after_cond_read_str		#"Checking if we encounter \0"
	addi 		$s3,$s3	,1							#"$s3 ++"
	move 		$a0, $s4							#"Restoring a0 from s4"
	
	jal			WRITE_CH							#"CALL WRITE_CH FUNCTION"
	
	j 			label_loop_read_str
	
after_cond_read_str:
	lw			$s4, 12($sp)						#"Restoring value of $s4 from stack"
	lw			$s3, 8($sp)							#"Restoring value of $s3 from stack"
	lw 			$s0, 4($sp)							#"Restoring value of $s0 from stacK"
	lw			$ra, 0($sp)							#"Restoring value of $ra from stack"
	addi		$sp, $sp, 16						#"Freeing stack memory"
	jr 			$ra									#"Function exits"
	

	
	
	
#"WRITE_STR"
WRITE_STR:
	addiu		$sp,$sp,-12							#"allocating space in stack"
	sw 			$ra, 0($sp)							#"Storing $ra to stack"
	sw			$s1, 4($sp)							#"Storing $s1 to stack"
	sw 			$s2, 8($sp)							#"Storing $s2 to stack"
	move		$s1, $a0							#"s1 = a0"
	li 			$s2, 0								#"s2 = counter"
	
label_loop_write_str:
	add 		$t2, $s2, $s1						#"t2 is temporary register used to access n'th element of array"
	
	lb			$a0, 0($t2)							#"load address of t2 into a0"
	
	jal			WRITE_CH							#"CALL WRITE_CH FUNCTION"
	
	sb			$a0,($s1)							#"Storing address of s1 into a0"
	
	beq			$a0,NULL,after_cond_write_str		#"Checking if we press enter "
	beq 		$a0,NEXT_LINE,after_cond_write_str	#"Checking if we encounter \0"
	addi		$s2, $s2, 1							#"s2 ++"
	j 			label_loop_write_str

after_cond_write_str:

	lw			$s2, 8($sp)							#"Restoring value of $s2 from stack"
	lw			$s1, 4($sp)							#"Restoring value of $s1 from stack"
	lw 			$ra, 0($sp)							#"Restoring value of $ra from stack"
	addi 		$sp, $sp, 12						#"Freeing stack memory"
	jr 			$ra									#"Function exits"
	
	
	
#"CONVERTER"
CONVERTER: 
	addi		$sp ,$sp, -4						#"allocating space in stack"
	sw 			$ra, 0($sp)							#"Storing $ra to stack"
	
	move		$t1, $a0 							#"t1 = address"
	
label_loop:
	lb			$t0,($t1)							#"Loading address into t0"

	beq			$t0,NEXT_LINE,after_loop			#"Checking if we press enter "
	
	blt			$t0,97,else_label	 				#"Old is Lowercase"
	bgt		    $t0,122,else_label 					#"Old is Lowercase"
	
	addi 		$t0,$t0,-32							#"Convert to Uppercase"
	
	j 			after_cond
	
else_label:
	blt			$t0,65,after_cond					#"Old is Uppercase"
	bgt 		$t0,90,after_cond					#"Old is Uppercase"
	
	addi 		$t0,$t0,32							#"Convert to Lowercase"
	
after_cond:
	sb			$t0,($t1)							#"Address of t1 = t0"
	addi		$t1,$t1,1							#"t1  ++"
	
	j 			label_loop
	
after_loop:
	lw 			$ra, 0($sp)							#"Restoring value of $ra from stack"
	addi 		$sp,$sp,4							#"Freeing stack memory"
	jr 			$ra									#"Function exits"





	
	
	