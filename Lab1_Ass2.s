###############################################
# MCOM-Labor: Vorlage fuer Assemblerprogramm
# Edition History:
# 28-04-2009: Getting Started - ms
# 12-03-2014: Stack organization changed - ms
###############################################

###############################################
# Definition von symbolen Konstanten
###############################################
	.equ STACK_SIZE, 0x400	# stack size
###############################################
# DATA SECTION
# assumption: 12 kByte data section (0 - 0x2fff)
# stack is located in data section and starts
# directly behind used data items at address
# STACK_END.
# Stack is growing downwards. Stack size
# is given by STACK_SIZE. A full descending
# stack is used, accordingly first stack item
# is stored at address STACK_END+(STACKSIZE).
###############################################	
	.data
TST_PAK1:
	.word 0x11112222	# test data

STACK_END:
	.skip STACK_SIZE	# stack area filled with 0
###############################################
# TEXT SECTION
# Executable code follows
###############################################
	.global _start
	.text
_start:
	#######################################
	# stack setup:
	# HAVE Care: By default JNiosEmu sets stack pointer sp = 0x40000.
	# That stack is not used here, because SoPC does not support
	# such an address range. I. e. you should ignore the STACK
	# section in JNiosEmu's memory window.
	
	movia	sp, STACK_END		# load data section's start address
	addi	sp, sp, STACK_SIZE	# stack start position should
					# begin at end of section

START:
	movi r7, 0x9		# 0x9 = 1001 -> r7 as a parameter
	call write_LED		# subroutine write_LED is called, r7 passed into the subroutine
	
endloop:
	br endloop # that's it
	.end
###############################################
write_LED:
	subi sp, sp, 4 		# Push
	stw r2, (sp)		# ---
	movia r2, 0x810		# r2 <- 0x810=output_register_address)
	stw r7, (r2)		# r7 -> (r2) parameter -> output_register
	ldw r2, (sp) 		# Pop
	addi sp, sp, 4		# ---
ret
###############################################
	
	
