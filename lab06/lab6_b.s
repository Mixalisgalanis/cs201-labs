#"Assembly LAB06 (Part B) - Giorgos Virirakis, Mixalis Galanis"

	.data

#"CONSTANTS"
NEXT_LINE			= 10

RECEIVER_CONTROL	= 0xffff0000
RECEIVER_DATA		= 0xffff0004
TRANSMIT_CONTROL	= 0xffff0008
TRANSMIT_DATA		= 0xffff000c

READY_BIT			= 0x1
INTERRUPT_BIT		= 0x2

ENABLE_INTERRUPT_BITS = 0x801
	

	.text
	.globl main

#"MAIN"
main:

	#"Enable interrupts"
	mfc0 $t0, $12
	ori  $t0, ENABLE_INTERRUPT_BITS
	mtc0 $t0, $12
	
	lw		$t0, RECEIVER_CONTROL
	ori		$t0, INTERRUPT_BIT
	sw		$t0, RECEIVER_CONTROL

label_loop:

	jal 	READ_CH							#"CALLS READ_CH FUNCTION"
	move	$a0, $v0						#"Save output $v0 and send it to WRITE_CH"
	jal		WRITE_CH						#"CALLS WRITE_CH FUNCTION"
	
	j label_loop							#"loop again"
	

#"WRITE_CH"
WRITE_CH:									#"USES POLLING METHOD TO PRINT CHARACTED ON THE SCREEN"

	lw			$t1, TRANSMIT_CONTROL		#"t0 is the address of TRANSMIT_CONTROL"
	bne 		$t1,0, write_char			#"Go to read_char if t1 != null"
	andi 		$t1,$t1, READY_BIT			#"t1 becomes AND(t1,READY_BIT)"
	j 			WRITE_CH					#"loop again"
	
write_char:
	sw 			$a0, TRANSMIT_DATA			#"value of TRANSMIT_DATA gets saved in a0"
	jr 			$ra							#"Function exits"

# Reads a character from the keyboard using interrupts.
#

#"READ_CH"
READ_CH:									#"USES INTERRUPTS METHOD TO READ CHARACTER FROM KEYBOARD"
	lw		$t1, cflag						#"Loads cflag to $t1"
	
check_read:
	bne 	$t1, $zero, read_char			#"if cflag was 0, continue looping, else goto read_char"
	lw		$t1, cflag						#"Loads cflag to $t1"
	andi	$t1, $t1, READY_BIT				#"ti becomes AND(t1, READY_BIT)"
	j check_read							#"loop again"
	
read_char:
	lw		$v0, cdata						#"Load cdata value to $v0"
	sw		$zero, cflag					#"We just wrote the char, cflag becomes zero again"
	jr 		$ra								#"Function exits"

	
	
	
	
	
	
	