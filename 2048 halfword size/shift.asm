# hw4_main.asm
# This file is NOT part of your homework 4 submission.
# Any changes to this file WILL NOT BE GRADED.
#
# We encourage you to modify this file and/or make your own mains to test different inputs

.include "hw4_examples.asm"

# Constants
.data
shiftRowf: .asciiz "\nShift Row\t"
shiftColf: .asciiz "\nShift Col\t"
.text
.globl _start


####################################################################
# This is the "main" of your program; Everything starts here.
####################################################################

_start:
#####################################
# TESTING PART F	SHIFT_ROW
#####################################
la $a0 shiftRowf
li $v0 4
syscall
addi $sp $sp -4

	# left
	la $a0 shiftLeftE
	li $a1 5
	li $a2 5
	li $a3 0		# row
	sw $0 ($sp)
	jal shift_row
	
	move $a0 $v0
	li $v0 1		# Print return value.
	syscall

	li $a0 ' '
	li $v0 11
	syscall
	
# left
la $a0 shiftLeftE
li $a1 5
li $a2 5
li $a3 1
sw $0 ($sp)
jal shift_row
	
move $a0 $v0
li $v0 1		# Print return value.
syscall

li $a0 ' '
li $v0 11
syscall

	# left
	la $a0 shiftLeftE
	li $a1 5
	li $a2 5
	li $a3 2
	sw $0 ($sp)
	jal shift_row
	
	move $a0 $v0
	li $v0 1		# Print return value.
	syscall

	li $a0 ' '
	li $v0 11
	syscall
	
# left
la $a0 shiftLeftE
li $a1 5
li $a2 5
li $a3 3
sw $0 ($sp)
jal shift_row
	
move $a0 $v0
li $v0 1		# Print return value.
syscall

li $a0 ' '
li $v0 11
syscall

	# left
	la $a0 shiftLeftE
	li $a1 5
	li $a2 5
	li $a3 4		# row
	sw $0 ($sp)
	jal shift_row
	
	move $a0 $v0
	li $v0 1		# Print return value.
	syscall

	li $a0 ' '
	li $v0 11
	syscall
	
# right row 0
la $a0 shiftRightE
li $a1 5
li $a2 5
li $a3 0
li $t0 1
sw $t0 ($sp)
jal shift_row
	
move $a0 $v0
li $v0 1		# Print return value.
syscall

li $a0 ' '
li $v0 11
syscall

	# right row1
	la $a0 shiftRightE
	li $a1 5
	li $a2 5
	li $a3 1
	li $t0 1
	sw $t0 ($sp)
	jal shift_row
	
	move $a0 $v0
	li $v0 1		# Print return value.
	syscall

	li $a0 ' '
	li $v0 11
	syscall
	
# right row 2
la $a0 shiftRightE
li $a1 5
li $a2 5
li $a3 2
li $t0 1
sw $t0 ($sp)
jal shift_row
	
move $a0 $v0
li $v0 1		# Print return value.
syscall

li $a0 ' '
li $v0 11
syscall

	# right row3
	la $a0 shiftRightE
	li $a1 5
	li $a2 5
	li $a3 3
	li $t0 1
	sw $t0 ($sp)
	jal shift_row
	
	move $a0 $v0
	li $v0 1		# Print return value.
	syscall

	li $a0 ' '
	li $v0 11
	syscall
	
# right row4
la $a0 shiftRightE
li $a1 5
li $a2 5
li $a3 4
li $t0 1
sw $t0 ($sp)
jal shift_row
	
move $a0 $v0
li $v0 1		# Print return value.
syscall

li $a0 ' '
li $v0 11
syscall	
#####################################
# TESTING PART G	SHIFT_COL
#####################################
la $a0 shiftColf
li $v0 4
syscall

	# Up row0
	la $a0 shiftUpE
	li $a1 5
	li $a2 5
	li $a3 0
	sw $0 ($sp)
	jal shift_col
	
	move $a0 $v0
	li $v0 1		# Print return value.
	syscall

	li $a0 ' '
	li $v0 11
	syscall
	
# Up row1
la $a0 shiftUpE
li $a1 5
li $a2 5
li $a3 1
sw $0 ($sp)
jal shift_col

move $a0 $v0
li $v0 1		# Print return value.
syscall

li $a0 ' '
li $v0 11
syscall

	# Up row2
	la $a0 shiftUpE
	li $a1 5
	li $a2 5
	li $a3 2
	sw $0 ($sp)
	jal shift_col
	
	move $a0 $v0
	li $v0 1		# Print return value.
	syscall

	li $a0 ' '
	li $v0 11
	syscall
	
# Up row3
la $a0 shiftUpE
li $a1 5
li $a2 5
li $a3 3
sw $0 ($sp)
jal shift_col
	
move $a0 $v0
li $v0 1		# Print return value.
syscall

li $a0 ' '
li $v0 11
syscall

	# Up row4
	la $a0 shiftUpE
	li $a1 5
	li $a2 5
	li $a3 4
	sw $0 ($sp)
	jal shift_col
	
	move $a0 $v0
	li $v0 1		# Print return value.
	syscall

	li $a0 ' '
	li $v0 11
	syscall
	
# Down row 0
la $a0 shiftDownE
li $a1 5
li $a2 5
li $a3 0
li $t0 1
sw $t0 ($sp)
jal shift_col
	
move $a0 $v0
li $v0 1		# Print return value.
syscall

li $a0 ' '
li $v0 11
syscall

	# DOwn row1
	la $a0 shiftDownE
	li $a1 5
	li $a2 5
	li $a3 1
	li $t0 1		# down
	sw $t0 ($sp)
	jal shift_col
	
	move $a0 $v0
	li $v0 1		# Print return value.
	syscall

	li $a0 ' '
	li $v0 11
	syscall
	
# Down row2
la $a0 shiftDownE
li $a1 5
li $a2 5
li $a3 2
li $t0 1
sw $t0 ($sp)
jal shift_col
	
move $a0 $v0
li $v0 1		# Print return value.
syscall

li $a0 ' '
li $v0 11
syscall

	# Down row3
	la $a0 shiftDownE
	li $a1 5
	li $a2 5
	li $a3 3
	li $t0 1
	sw $t0 ($sp)
	jal shift_col
	
	move $a0 $v0
	li $v0 1		# Print return value.
	syscall

	li $a0 ' '
	li $v0 11
	syscall
	
# Down row4
la $a0 shiftDownE
li $a1 5
li $a2 5
li $a3 4
li $t0 1
sw $t0 ($sp)
jal shift_col
	
move $a0 $v0
li $v0 1		# Print return value.
syscall

li $a0 ' '
li $v0 11
syscall	

addi $sp $sp 4
###################################################################
# End of MAIN program
####################################################################
li $v0, 10
syscall

#################################################################
# Student defined functions will be included starting here
#################################################################

.include "hw4.asm"
