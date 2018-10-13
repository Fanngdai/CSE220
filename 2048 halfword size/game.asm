# hw4_main.asm
# This file is NOT part of your homework 4 submission.
# Any changes to this file WILL NOT BE GRADED.
#
# This actually plays the game. Any board size greater than 2X2.
# Play at your own risk.

# Constants
.data
	rules: .asciiz "Welcome!\nRow and column size must be greater than 1.\nAll input must be capital.\nL - for left\nR - for right\nU - for up\nD - for down\n"
	row_size: .asciiz "What should the row size be?\t"
	col_size: .asciiz "What should the column size be?\t"
	win_print: .asciiz "You Won! Play Again? (Y/N)\t"
	lose_print: .asciiz "You Lost! Play Again? (Y/N)\t"
.text
.globl _start

####################################################################
# This is the "main" of your program; Everything starts here.
####################################################################

_start:
	li $s7 5
	# Print the rules
	la $a0 rules
	li $v0 4
	syscall

ask_row_size:
	# Ask user for the size of row.
	la $a0 row_size
	li $v0 4
	syscall
	
	li $v0, 5		# Read int
    	syscall
    	move $s0 $v0
    	
    	ble $s0 1 ask_row_size	# row is not valid
	
ask_col_size:
	# Ask user for the size of col.
	la $a0 col_size
	li $v0 4
	syscall
	
	li $v0, 5		# Read int
    	syscall
    	move $s1 $v0
    	
    	ble $s1 1 ask_col_size	# col is not valid
    	
start_the_game:
	# r1
	move $a1, $s0       	# where you set the upper bound
	li $v0, 42           	# system call to generate random int
	syscall              	# your generated number will be in $a0
	move $s2 $a0		# rand num of 0,1,2or3
	
	# r2
	move $a1, $s0      	# where you set the upper bound
	li $v0, 42           	# system call to generate random int
	syscall              	# your generated number will be in $a0
	move $s3 $a0		# rand num of 0,1,2or3
	
	# c1
	move $a1, $s1       	# where you set the upper bound
	li $v0, 42           	# system call to generate random int
	syscall              	# your generated number will be in $a0
	move $s4 $a0		# rand num of 0,1,2or3
	
	# c2
	move $a1, $s1       	# where you set the upper bound
	li $v0, 42           	# system call to generate random int
	syscall              	# your generated number will be in $a0
	move $s5 $a0		# rand num of 0,1,2or3

	bne $s2 $s3 fine
	bne $s4 $s5 fine
	j start_the_game	# regenerate random row and col. Make sure they are not the same
	
fine:
	# Start the game. Clear board. Place 2 numbers randomly on board
	li $a0 0xffff0000	# My board
	move $a1 $s0		# num_rows
	move $a2 $s1		# num_cols
	
	move $a3 $s2		# r1
	addi $sp $sp -12
	sw $s4 ($sp)		# c1
	sw $s3 4($sp)		# r2
	sw $s5 8($sp)		# c2
	
	jal start_game
	addi $sp $sp 12		# Put stack pointer back

getUserInput:
 	li $v0, 12		# Read char
    	syscall
    	
    	beq $v0 'L' userMove
    	beq $v0 'U' userMove
    	beq $v0 'R' userMove
    	beq $v0 'D' userMove
	j getUserInput		# User did not enter L, U, R nor D
	
userMove:
	# User entered LURD. User move.	
	li $a0 0xffff0000
	move $a1 $s0		# rows
	move $a2 $s1		# cols
	move $a3 $v0		# Put user input
	jal user_move
	
	beq $v1 0x1 win_game	# win
	li $t0 -1
	beq $v1	$t0 lose_game	# lose
	
	# otherwise, continue. But first, place a number
place_rand_num:	
	# row
	move $a1 $s0
	#addi $a1 $s0 -1       	# where you set the upper bound
	li $v0 42           	# system call to generate random int
	syscall              	# your generated number will be in $a0
	move $s2 $a0		# rand num of 0,1,2or3
	
	# col
	move $a1 $s1
	#addi $a1 $s1 -1       	# where you set the upper bound
	li $v0 42           	# system call to generate random int
	syscall              	# your generated number will be in $a0
	move $s3 $a0		# rand num of 0,1,2or3.
	
	mul $t0 $s2 $s1		# i * n_col
	add $t0 $t0 $s3		# (i*n_col) + j
	sll $t0 $t0 1		# [(i*n_col) + j] * 2	size = 2
	addi $t0 $t0 0xffff0000	# a[i][j]
	
	lh $t0 ($t0)		# Get the value at this address
	li $t1 -1
	bne $t0 $t1 place_rand_num	# Value already exist. Generate another random cell
	
	li $a0 0xffff0000	# My board
	move $a1 $s0		# row
	move $a2 $s1		# col
	move $a3 $s2		# where to place row
	addi $sp $sp -8
	sw $s3 ($sp)		# where to place col
	li $t0 2		# value put 2
	sw $t0 4($sp)
	jal place
	addi $sp $sp 8
	
	# Check the state again after you place a rand value.
	li $a0 0xffff0000
	move $a1 $s0		# row
	move $a2 $s1		# column
	jal check_state
	beq $v0 0x1 win_game	# win
	li $t0 -1
	beq $v0	$t0 lose_game	# lose
	
	j getUserInput
	
win_game:
	la $a0 win_print
	li $v0 4
	syscall
	j play_again
lose_game:
	la $a0 lose_print
	li $v0 4
	syscall
play_again:
	li $v0, 12		# Read char
    	syscall
    	beq $v0 'Y' _start	# User wants to play again
###################################################################
# End of MAIN program
####################################################################
li $v0, 10
syscall

#################################################################
# Student defined functions will be included starting here
#################################################################

.include "hw4.asm"
