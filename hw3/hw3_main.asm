# hw2_main1.asm
# This file is NOT part of your homework 2 submission.
# Any changes to this file WILL NOT BE GRADED.
#
# We encourage you to modify this file  and/or make your own mains to test different inputs

.include "hw3_examples.asm"

# Constants
.data
newline:  .asciiz "\n"
comma:    .asciiz ", "
testchar: .byte '9'
success: .asciiz "Success: "
bytes: .asciiz "Bytes: "
packetNumber_1: .asciiz "packet number "
packetNumber_2: .asciiz " has invalid checksum"

Cat: .asciiz "Cat"
Toad: .asciiz "Toad"

.text
.globl _start


####################################################################
# This is the "main" of your program; Everything starts here.
####################################################################

_start:

	la $a0 queen_holes_unsorted
	li $a1 4
	la $a2 msg_buffer
	la $a3 str_array
	li $t0 80
	addi $sp $sp -4
	sw $t0 ($sp)
	jal printUnorderedDatagram
	addi $sp $sp 4
	
#	la $a0 Cat
#	la $a1 Toad
#	li $a2 3
#	li $a3 4
#	jal editDistance
	
	li $v0, 10
	syscall

###################################################################
# End of MAIN program
####################################################################


#################################################################
# Student defined functions will be included starting here
#################################################################

.include "hw3.asm"
