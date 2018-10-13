# hw4_main.asm
# This file is NOT part of your homework 4 submission.
# Any changes to this file WILL NOT BE GRADED.
#
# We encourage you to modify this file and/or make your own mains to test different inputs

.include "hw4_examples.asm"

# Constants
.data
clearBoardf: .asciiz "Clear Board\t"
placef: .asciiz "\nPlace\t\t"
startGamef: .asciiz "\nStart Game\t"
mergeRowf: .asciiz "\nMerge Row\t"
mergeColf: .asciiz "\nMerge Col\t"
shiftRowf: .asciiz "\nShift Row\t"
shiftColf: .asciiz "\nShift Col\t"
checkStatef: .asciiz "\nCheck State\t"
movef: .asciiz "\nMove\t\t"
.text
.globl _start


####################################################################
# This is the "main" of your program; Everything starts here.
####################################################################

_start:
#####################################
# TESTING PART A	CLEAR_BOARD
# a0 = board
# a1 = num_rows
# a2 = num_cols
#####################################
la $a0 clearBoardf
li $v0 4
syscall

	# -1 bc num_rows = 1 < 2
	li $a0 0xffff0000
	li $a1 1
	li $a2 3

	jal clear_board
	move $a0 $v0
	li $v0 1		# Print my return value.
	syscall
	
	li $a0 ' '
	li $v0 11
	syscall

# -1 bc num_cols = 1 < 2
li $a0 0xffff0000
li $a1 3
li $a2 1

jal clear_board
move $a0 $v0
li $v0 1		# Print my return value.
syscall

li $a0 ' '
li $v0 11
syscall

	# 0
	li $a0 0xffff0000
	li $a1 2
	li $a2 3

	jal clear_board
	move $a0 $v0
	li $v0 1		# Print my return value.
	syscall
	
	li $a0 ' '
	li $v0 11
	syscall
	
# 0 success
li $a0 0xffff0000
li $a1 3
li $a2 2

jal clear_board
move $a0 $v0
li $v0 1		# Print my return value.
syscall

li $a0 ' '
li $v0 11
syscall
	
	# -1 bc num_rows = -2 < 2
	li $a0 0xffff0000
	li $a1 -2
	li $a2 3

	jal clear_board
	move $a0 $v0
	li $v0 1		# Print my return value.
	syscall
	
	li $a0 ' '
	li $v0 11
	syscall

# -1 bc num_cols = -2 < 2
li $a0 0xffff0000
li $a1 3
li $a2 -2

jal clear_board
move $a0 $v0
li $v0 1		# Print my return value.
syscall
#####################################
# TESTING PART B	PLACE
# a0 = cell[][]board
# a1 = int num_rows
# a2 = int num_cols
# a3 = row
# 0($sp) = col
# 4($sp) = val
#####################################
la $a0 placef
li $v0 4
syscall

addi $sp $sp -8

	# one -1 bc num_rows = 1 < 2
	li $a0 0xffff0000	# My board
	li $a1 1
	li $a2 5
	li $a3 5
	li $t0 4
	sw $t0 ($sp)
	li $t0 -1
	sw $t0 4($sp)
	
	jal place
	move $a0 $v0
	li $v0 1		# Print my return value.
	syscall
	
	li $a0 ' '
	li $v0 11
	syscall
	
# two -1 bc n_cols = 1 < 2
li $a0 0xffff0000	# My board
li $a1 7
li $a2 1
li $a3 5
li $t0 4
sw $t0 ($sp)
li $t0 -1
sw $t0 4($sp)

jal place
move $a0 $v0
li $v0 1		# Print my return value.
syscall

li $a0 ' '
li $v0 11
syscall

	# three -1 bc num_rows = -9 < 2
	li $a0 0xffff0000	# My board
	li $a1 -9
	li $a2 5
	li $a3 5
	li $t0 4
	sw $t0 ($sp)
	li $t0 -1
	sw $t0 4($sp)
	
	jal place
	move $a0 $v0
	li $v0 1		# Print my return value.
	syscall
	
	li $a0 ' '
	li $v0 11
	syscall

# four -1 bc num_col = -9 < 2
li $a0 0xffff0000	# My board
li $a1 7
li $a2 -9
li $a3 5
li $t0 4
sw $t0 ($sp)
li $t0 -1
sw $t0 4($sp)

jal place
move $a0 $v0
li $v0 1		# Print my return value.
syscall

li $a0 ' '
li $v0 11
syscall

	# five -1 row = -1 < 0 out of range
	li $a0 0xffff0000	# My board
	li $a1 7
	li $a2 5
	li $a3 -1
	li $t0 4
	sw $t0 ($sp)
	li $t0 -1
	sw $t0 4($sp)

	jal place
	move $a0 $v0
	li $v0 1		# Print my return value.
	syscall

	li $a0 ' '
	li $v0 11
	syscall

# six -1 bc col = -1 < 0 out of range
li $a0 0xffff0000	# My board
li $a1 7
li $a2 5
li $a3 5
li $t0 -1
sw $t0 ($sp)
sw $t0 4($sp)

jal place
move $a0 $v0
li $v0 1		# Print my return value.
syscall

li $a0 ' '
li $v0 11
syscall
	
	# seven -1 row = num_rows out of range
	li $a0 0xffff0000	# My board
	li $a1 7
	li $a2 5
	li $a3 7
	li $t0 4
	sw $t0 ($sp)
	li $t0 -1
	sw $t0 4($sp)

	jal place
	move $a0 $v0
	li $v0 1		# Print my return value.
	syscall

	li $a0 ' '
	li $v0 11
	syscall

# eight -1 col = num_cols out of range
li $a0 0xffff0000	# My board
li $a1 7
li $a2 5
li $a3 5
sw $a2 ($sp)		# 5
li $t0 -1
sw $t0 4($sp)

jal place
move $a0 $v0
li $v0 1		# Print my return value.
syscall

li $a0 ' '
li $v0 11
syscall

	# nine -1 val = 0
	li $a0 0xffff0000	# My board
	li $a1 7
	li $a2 5
	li $a3 5
	li $t0 4
	sw $t0 ($sp)
	sw $0 4($sp)

	jal place
	move $a0 $v0	
	li $v0 1		# Print my return value.
	syscall

	li $a0 ' '
	li $v0 11
	syscall

# ten -1 val = 6
li $a0 0xffff0000	# My board
li $a1 7
li $a2 5
li $a3 5
li $t0 4
sw $t0 ($sp)
li $t0 6
sw $t0 4($sp)

jal place
move $a0 $v0
li $v0 1		# Print my return value.
syscall

li $a0 ' '
li $v0 11
syscall

	# eleven 0
	li $a0 0xffff0000	# My board
	li $a1 7
	li $a2 5
	li $a3 5
	li $t0 4
	sw $t0 ($sp)
	li $t0 -1
	sw $t0 4($sp)

	jal place
	move $a0 $v0
	li $v0 1		# Print my return value.
	syscall

	li $a0 ' '
	li $v0 11
	syscall

# twelve 0 success 2X5 	1,2 	val -1
li $a0 0xffff0000	# My board
li $a1 7
li $a2 5
li $a3 5
li $t0 4
sw $t0 ($sp)
li $t0 256
sw $t0 4($sp)

jal place
move $a0 $v0
li $v0 1		# Print my return value.
syscall

li $a0 ' '
li $v0 11
syscall

	# thirteen 0 success
	li $a0 0xffff0000	# My board
	li $a1 7
	li $a2 5
	li $a3 5
	li $t0 4
	sw $t0 ($sp)
	li $t0 16384		# a power of 2
	sw $t0 4($sp)

	jal place
	move $a0 $v0
	li $v0 1		# Print my return value.
	syscall

addi $sp $sp 8
#####################################
# TESTING PART C	START_GAME
#####################################
la $a0 startGamef
li $v0 4
syscall
addi $sp $sp -4 		# Previous was 8 so allocate 4 move to stack

	# -1 bc num_rows = 1 < 2
	li $a0 0xffff0000	# My board
	li $a1 1		# num_rows
	li $a2 5		# num_cols
	li $a3 5		# r1

	li $t0 0		# c1
	li $t1 6		# r2
	li $t2 4		# c2

	sw $t0 ($sp)
	sw $t1 4($sp)
	sw $t2 8($sp)

	jal start_game

	move $a0 $v0
	li $v0 1		# Print my return value.
	syscall
	
	li $a0 ' '
	li $v0 11
	syscall
	
# -1 bc num_cols = 1 < 2
li $a0 0xffff0000	# My board
li $a1 7		# num_rows
li $a2 1		# num_cols
li $a3 5		# r1

li $t0 0		# c1
li $t1 6		# r2
li $t2 4		# c2

sw $t0 ($sp)
sw $t1 4($sp)
sw $t2 8($sp)

jal start_game

move $a0 $v0
li $v0 1		# Print my return value.
syscall

li $a0 ' '
li $v0 11
syscall

	# -1 bc num_row = -4 < 2
	li $a0 0xffff0000	# My board
	li $a1 -4		# num_rows
	li $a2 5		# num_cols
	li $a3 5		# r1

	li $t0 0		# c1
	li $t1 6		# r2
	li $t2 4		# c2

	sw $t0 ($sp)
	sw $t1 4($sp)
	sw $t2 8($sp)

	jal start_game

	move $a0 $v0
	li $v0 1		# Print my return value.
	syscall

	li $a0 ' '
	li $v0 11
	syscall

# -1 bc num_col = -4 < 2
li $a0 0xffff0000	# My board
li $a1 7		# num_rows
li $a2 -4		# num_cols
li $a3 5		# r1

li $t0 0		# c1
li $t1 6		# r2
li $t2 4		# c2

sw $t0 ($sp)
sw $t1 4($sp)
sw $t2 8($sp)

jal start_game

move $a0 $v0
li $v0 1		# Print my return value.
syscall

li $a0 ' '
li $v0 11
syscall

	# -1 bc r1 = -1 < 0
	li $a0 0xffff0000	# My board
	li $a1 7		# num_rows
	li $a2 5		# num_cols
	li $a3 -1		# r1

	li $t0 0		# c1
	li $t1 6		# r2
	li $t2 4		# c2

	sw $t0 ($sp)
	sw $t1 4($sp)
	sw $t2 8($sp)

	jal start_game

	move $a0 $v0
	li $v0 1		# Print my return value.
	syscall

	li $a0 ' '
	li $v0 11
	syscall
	
# -1 bc c1 = -1 < 0
li $a0 0xffff0000	# My board
li $a1 7		# num_rows
li $a2 5		# num_cols
li $a3 5		# r1

li $t0 -1		# c1
li $t1 6		# r2
li $t2 4		# c2

sw $t0 ($sp)
sw $t1 4($sp)
sw $t2 8($sp)

jal start_game

move $a0 $v0
li $v0 1		# Print my return value.
syscall

li $a0 ' '
li $v0 11
syscall
	
	# -1 bc r2 = -1 < 0
	li $a0 0xffff0000	# My board
	li $a1 7		# num_rows
	li $a2 5		# num_cols
	li $a3 5		# r1

	li $t0 0		# c1
	li $t1 -1		# r2
	li $t2 4		# c2

	sw $t0 ($sp)
	sw $t1 4($sp)
	sw $t2 8($sp)

	jal start_game

	move $a0 $v0
	li $v0 1		# Print my return value.
	syscall

	li $a0 ' '
	li $v0 11
	syscall
	
# -1 bc c2 = -1 < 0
li $a0 0xffff0000	# My board
li $a1 7		# num_rows
li $a2 5		# num_cols
li $a3 5		# r1

li $t0 0		# c1
li $t1 6		# r2
li $t2 -1		# c2

sw $t0 ($sp)
sw $t1 4($sp)
sw $t2 8($sp)

jal start_game

move $a0 $v0
li $v0 1		# Print my return value.
syscall

li $a0 ' '
li $v0 11
syscall

	# -1 bc r1 = num_row > num_rows-1 out of range
	li $a0 0xffff0000	# My board
	li $a1 7		# num_rows
	li $a2 5		# num_cols
	li $a3 7		# r1

	li $t0 0		# c1
	li $t1 6		# r2
	li $t2 4		# c2

	sw $t0 ($sp)
	sw $t1 4($sp)
	sw $t2 8($sp)

	jal start_game

	move $a0 $v0
	li $v0 1		# Print my return value.
	syscall

	li $a0 ' '
	li $v0 11
	syscall
	
# -1 bc r2 = num_row > num_row-1
li $a0 0xffff0000	# My board
li $a1 7		# num_rows
li $a2 5		# num_cols
li $a3 5		# r1

li $t0 0		# c1
li $t1 7		# r2
li $t2 4		# c2

sw $t0 ($sp)
sw $t1 4($sp)
sw $t2 8($sp)

jal start_game

move $a0 $v0
li $v0 1		# Print my return value.
syscall

li $a0 ' '
li $v0 11
syscall

	# -1 c1 = num_cols > num_cols-1 out of range
	li $a0 0xffff0000	# My board
	li $a1 7		# num_rows
	li $a2 5		# num_cols
	li $a3 5		# r1

	li $t0 5		# c1
	li $t1 6		# r2
	li $t2 4		# c2

	sw $t0 ($sp)
	sw $t1 4($sp)
	sw $t2 8($sp)

	jal start_game

	move $a0 $v0
	li $v0 1		# Print my return value.
	syscall

	li $a0 ' '
	li $v0 11
	syscall
	
# -1 bc c2 = num_cols > num_cols-1 out of range
li $a0 0xffff0000	# My board
li $a1 7		# num_rows
li $a2 5		# num_cols
li $a3 5		# r1

li $t0 5		# c1
li $t1 6		# r2
li $t2 4		# c2

sw $t0 ($sp)
sw $t1 4($sp)
sw $t2 8($sp)

jal start_game

move $a0 $v0
li $v0 1		# Print my return value.
syscall

li $a0 ' '
li $v0 11
syscall

	# 0 the correct elements
	li $a0 0xffff0000	# My board
	li $a1 7		# num_rows
	li $a2 5		# num_cols
	li $a3 5		# r1
	
	li $t0 0		# c1
	li $t1 6		# r2
	li $t2 4		# c2
	
	sw $t0 ($sp)
	sw $t1 4($sp)
	sw $t2 8($sp)
	
	jal start_game
	
	move $a0 $v0
	li $v0 1		# Print my return value.
	syscall
	
	li $a0 ' '
	li $v0 11
	syscall
	
# 0
li $a0 0xffff0000	# My board
li $a1 7		# num_rows
li $a2 5		# num_cols
li $a3 0		# r1
	
li $t0 0		# c1
li $t1 6		# r2
li $t2 4		# c2
	
sw $t0 ($sp)
sw $t1 4($sp)
sw $t2 8($sp)
	
jal start_game
	
move $a0 $v0
li $v0 1		# Print my return value.
syscall

li $a0 ' '
li $v0 11
syscall

	# 0
	li $a0 0xffff0000	# My board
	li $a1 7		# num_rows
	li $a2 5		# num_cols
	li $a3 5		# r1
	
	li $t0 0		# c1
	li $t1 6		# r2
	li $t2 4		# c2
	
	sw $t0 ($sp)
	sw $t1 4($sp)
	sw $t2 8($sp)
	
	jal start_game
	
	move $a0 $v0
	li $v0 1		# Print my return value.
	syscall
	
	li $a0 ' '
	li $v0 11
	syscall
	
# 0
li $a0 0xffff0000	# My board
li $a1 7		# num_rows
li $a2 5		# num_cols
li $a3 5		# r1
	
li $t0 0		# c1
li $t1 0		# r2
li $t2 4		# c2
	
sw $t0 ($sp)
sw $t1 4($sp)
sw $t2 8($sp)
	
jal start_game
	
move $a0 $v0
li $v0 1		# Print my return value.
syscall

li $a0 ' '
li $v0 11
syscall
	
	# 0 success
	li $a0 0xffff0000	# My board
	li $a1 7		# num_rows
	li $a2 5		# num_cols
	li $a3 5		# r1
	
	li $t0 0		# c1
	li $t1 6		# r2
	li $t2 0		# c2
	
	sw $t0 ($sp)
	sw $t1 4($sp)
	sw $t2 8($sp)
	
	jal start_game
	
	move $a0 $v0
	li $v0 1		# Print my return value.
	syscall
	
	li $a0 ' '
	li $v0 11
	syscall

# 0 sucess
li $a0 0xffff0000	# My board
li $a1 7		# num_rows
li $a2 5		# num_cols
li $a3 6		# r1
	
li $t0 0		# r2
li $t1 6		# c1
li $t2 4		# c2
	
sw $t0 ($sp)
sw $t1 4($sp)
sw $t2 8($sp)
	
jal start_game
	
move $a0 $v0
li $v0 1		# Print my return value.
syscall

li $a0 ' '
li $v0 11
syscall

	# 0 sucess
	li $a0 0xffff0000	# My board
	li $a1 7		# num_rows
	li $a2 5		# num_cols
	li $a3 5		# r1
	
	li $t0 0		# c1
	li $t1 6		# r2
	li $t2 4		# c2
	
	sw $t0 ($sp)
	sw $t1 4($sp)
	sw $t2 8($sp)
	
	jal start_game

	
	move $a0 $v0
	li $v0 1		# Print my return value.
	syscall
	
	li $a0 ' '
	li $v0 11
	syscall
	
# 0
li $a0 0xffff0000	# My board
li $a1 7		# num_rows
li $a2 5		# num_cols
li $a3 5		# r1
	
li $t0 4		# c1
li $t1 6		# r2
li $t2 4		# c2
	
sw $t0 ($sp)
sw $t1 4($sp)
sw $t2 8($sp)
	
jal start_game
	
move $a0 $v0
li $v0 1		# Print my return value.
syscall

li $a0 ' '
li $v0 11
syscall
	
	# 0 success
	li $a0 0xffff0000	# My board
	li $a1 7		# num_rows
	li $a2 5		# num_cols
	li $a3 5		# r1
	
	li $t0 0		# c1
	li $t1 6		# r2
	li $t2 4		# c2
	
	sw $t0 ($sp)
	sw $t1 4($sp)
	sw $t2 8($sp)
	
	jal start_game
	
	move $a0 $v0
	li $v0 1		# Print my return value.
	syscall
	
addi $sp $sp 12

#####################################
# TESTING PART D	MERGE_ROW
# a0 = cell[][]board
# a1 = num_rows
# a2 = num_cols
# a3 = row
# 0($sp) = direction
#####################################
la $a0 mergeRowf
li $v0 4
syscall

addi $sp $sp -4
	
	# 6
	la $a0 board1		# My board
	li $a1 4		# num_rows
	li $a2 6		# num_cols
	li $a3 1		# row
	sw $0 ($sp)
	
	jal merge_row
	
	move $a0 $v0
	li $v0 1		# Print my return value.
	syscall

	li $a0 ' '
	li $v0 11
	syscall
	
# 6
la $a0 board1		# My board
li $a1 4		# num_rows
li $a2 6		# num_cols
li $a3 1		# row
sw $0 ($sp)

jal merge_row

move $a0 $v0
li $v0 1		# Print my return value.
syscall

li $a0 ' '
li $v0 11
syscall

	# 6
	la $a0 board1		# My board
	li $a1 4		# num_rows
	li $a2 6		# num_cols
	li $a3 2		# row
	
	li $t0 1
	sw $t0 ($sp)
	jal merge_row
	
	move $a0 $v0
	li $v0 1		# Print my return value.
	syscall

	li $a0 ' '
	li $v0 11
	syscall
	
# 6
la $a0 board1		# My board
li $a1 4		# num_rows
li $a2 6		# num_cols
li $a3 2		# row

li $t0 1
sw $t0 ($sp)
jal merge_row

move $a0 $v0
li $v0 1		# Print my return value.
syscall

li $a0 ' '
li $v0 11
syscall

	# 0
	la $a0 board2		# My board
	li $a1 8		# num_rows
	li $a2 7		# num_cols
	li $a3 4		# row
	sw $0 ($sp)
	
	jal merge_row
	
	move $a0 $v0
	li $v0 1		# Print my return value.
	syscall

	li $a0 ' '
	li $v0 11
	syscall
	
# 0
la $a0 board2		# My board
li $a1 8		# num_rows
li $a2 7		# num_cols
li $a3 4		# row
li $t0 1
sw $t0 ($sp)

jal merge_row

move $a0 $v0
li $v0 1		# Print my return value.
syscall

li $a0 ' '
li $v0 11
syscall
	
	# 3 left
	la $a0 board2		# My board
	li $a1 8		# num_rows
	li $a2 7		# num_cols
	li $a3 6		# row
	sw $0 ($sp)
	
	jal merge_row
	
	move $a0 $v0
	li $v0 1		# Print my return value.
	syscall

	li $a0 ' '
	li $v0 11
	syscall
	
# 3 right
la $a0 board2		# My board
li $a1 8		# num_rows
li $a2 7		# num_cols
li $a3 6		# row
li $t0 1
sw $t0 ($sp)

jal merge_row

move $a0 $v0
li $v0 1		# Print my return value.
syscall

li $a0 ' '
li $v0 11
syscall

	# 4 left
	la $a0 board2		# My board
	li $a1 8		# num_rows
	li $a2 7		# num_cols
	li $a3 2		# row
	sw $0 ($sp)
	
	jal merge_row
	
	move $a0 $v0
	li $v0 1		# Print my return value.
	syscall

	li $a0 ' '
	li $v0 11
	syscall
	
# 4 right
la $a0 board2		# My board
li $a1 8		# num_rows
li $a2 7		# num_cols
li $a3 5		# row
li $t0 1
sw $t0 ($sp)

jal merge_row

move $a0 $v0
li $v0 1		# Print my return value.
syscall

li $a0 ' '
li $v0 11
syscall

	# 2 left
	la $a0 board2		# My board
	li $a1 8		# num_rows
	li $a2 7		# num_cols
	li $a3 0		# row
	sw $0 ($sp)
	
	jal merge_row
	
	move $a0 $v0
	li $v0 1		# Print my return value.
	syscall

	li $a0 ' '
	li $v0 11
	syscall
	
# 2 right
la $a0 board2		# My board
li $a1 8		# num_rows
li $a2 7		# num_cols
li $a3 7		# row
li $t0 1
sw $t0 ($sp)

jal merge_row

move $a0 $v0
li $v0 1		# Print my return value.
syscall

li $a0 ' '
li $v0 11
syscall

	# 4 merge left
	la $a0 board3		# My board
	li $a1 4		# num_rows
	li $a2 6		# num_cols
	li $a3 0		# row
	sw $0 ($sp)
	
	jal merge_row
	
	move $a0 $v0
	li $v0 1		# Print my return value.
	syscall

	li $a0 ' '
	li $v0 11
	syscall
	
# 4 merge left
la $a0 board3		# My board
li $a1 4		# num_rows
li $a2 6		# num_cols
li $a3 1		# row
sw $0 ($sp)

jal merge_row

move $a0 $v0
li $v0 1		# Print my return value.
syscall

li $a0 ' '
li $v0 11
syscall

	# 4 merge right
	la $a0 board3		# My board
	li $a1 4		# num_rows
	li $a2 6		# num_cols
	li $a3 2		# row
	li $t0 1
	sw $t0 ($sp)
	
	jal merge_row
	
	move $a0 $v0
	li $v0 1		# Print my return value.
	syscall

	li $a0 ' '
	li $v0 11
	syscall
	
# 4 merge right
la $a0 board3		# My board
li $a1 4		# num_rows
li $a2 6		# num_cols
li $a3 3		# row
li $t0 1
sw $t0 ($sp)

jal merge_row

move $a0 $v0
li $v0 1		# Print my return value.
syscall

li $a0 ' '
li $v0 11
syscall

	# 2 combine all
	la $a0 board4		# My board
	li $a1 4		# num_rows
	li $a2 4		# num_cols
	li $a3 0		# row
	sw $0 ($sp)
	
	jal merge_row
	
	move $a0 $v0
	li $v0 1		# Print my return value.
	syscall

	li $a0 ' '
	li $v0 11
	syscall
	
# 2 combine all
la $a0 board4		# My board
li $a1 4		# num_rows
li $a2 4		# num_cols
li $a3 1		# row
li $t0 1
sw $t0 ($sp)

jal merge_row

move $a0 $v0
li $v0 1		# Print my return value.
syscall

li $a0 ' '
li $v0 11
syscall

###################### ERRORS BEGIN HERE

	# -1 row value
	la $a0 board4		# My board
	li $a1 4		# num_rows
	li $a2 4		# num_cols
	li $a3 -1		# row
	sw $0 ($sp)
	
	jal merge_row
	
	move $a0 $v0
	li $v0 1		# Print my return value.
	syscall

	li $a0 ' '
	li $v0 11
	syscall
	
# -1 row value
la $a0 board4		# My board
li $a1 4		# num_rows
li $a2 4		# num_cols
li $a3 4		# row
li $t0 1
sw $t0 ($sp)

jal merge_row

move $a0 $v0
li $v0 1		# Print my return value.
syscall

li $a0 ' '
li $v0 11
syscall

	# -1 num_rows
	la $a0 board4		# My board
	li $a1 0		# num_rows
	li $a2 4		# num_cols
	li $a3 0		# row
	sw $0 ($sp)
	
	jal merge_row
	
	move $a0 $v0
	li $v0 1		# Print my return value.
	syscall

	li $a0 ' '
	li $v0 11
	syscall
	
# -1 num_cols
la $a0 board4		# My board
li $a1 4		# num_rows
li $a2 0		# num_cols
li $a3 1		# row
li $t0 1
sw $t0 ($sp)

jal merge_row

move $a0 $v0
li $v0 1		# Print my return value.
syscall

li $a0 ' '
li $v0 11
syscall

	# -1 num_rows
	la $a0 board4		# My board
	li $a1 -2		# num_rows
	li $a2 4		# num_cols
	li $a3 0		# row
	sw $0 ($sp)
	
	jal merge_row
	
	move $a0 $v0
	li $v0 1		# Print my return value.
	syscall

	li $a0 ' '
	li $v0 11
	syscall
	
# -1 num_cols
la $a0 board4		# My board
li $a1 4		# num_rows
li $a2 -2		# num_cols
li $a3 1		# row
li $t0 1
sw $t0 ($sp)

jal merge_row

move $a0 $v0
li $v0 1		# Print my return value.
syscall

li $a0 ' '
li $v0 11
syscall

	# -1 direction
	la $a0 board4		# My board
	li $a1 4		# num_rows
	li $a2 4		# num_cols
	li $a3 1		# row
	li $t0 -1
	sw $t0 ($sp)
	
	jal merge_row
	
	move $a0 $v0
	li $v0 1		# Print my return value.
	syscall

	li $a0 ' '
	li $v0 11
	syscall
	
# -1 direction
la $a0 board4		# My board
li $a1 4		# num_rows
li $a2 4		# num_cols
li $a3 2		# row
li $t0 2
sw $t0 ($sp)

jal merge_row

move $a0 $v0
li $v0 1		# Print my return value.
syscall

addi $sp $sp 4

#####################################
# TESTING PART E	MERGE_COL
#####################################
la $a0 mergeColf
li $v0 4
syscall

	# 4
	la $a0 board1	# My board
	li $a1 4		# num_rows
	li $a2 6		# num_cols
	li $a3 2		# col
	addi $sp $sp -4
	sw $0 ($sp)
	
	jal merge_col
	addi $sp $sp 4
	
	move $a0 $v0
	li $v0 1		# Print my return value.
	syscall

	li $a0 ' '
	li $v0 11
	syscall
	
# 4
la $a0 board1		# My board
li $a1 4		# num_rows
li $a2 6		# num_cols
li $a3 4		# col
addi $sp $sp -4
li $t0 1
sw $t0 ($sp)

jal merge_col
addi $sp $sp 4

move $a0 $v0
li $v0 1		# Print my return value.
syscall

li $a0 ' '
li $v0 11
syscall

	# 3 down
	la $a0 board2		# My board
	li $a1 8		# num_rows
	li $a2 7		# num_cols
	li $a3 1		# col
	addi $sp $sp -4
	sw $zero ($sp)
	
	jal merge_col
	addi $sp $sp 4
	
	move $a0 $v0
	li $v0 1		# Print my return value.
	syscall

	li $a0 ' '
	li $v0 11
	syscall
	
# 3 up
la $a0 board2		# My board
li $a1 8		# num_rows
li $a2 7		# num_cols
li $a3 5		# col
addi $sp $sp -4
li $t0 1
sw $t0 ($sp)

jal merge_col
addi $sp $sp 4

move $a0 $v0
li $v0 1		# Print my return value.
syscall

li $a0 ' '
li $v0 11
syscall

	# 3 down
	la $a0 board2		# My board
	li $a1 8		# num_rows
	li $a2 7		# num_cols
	li $a3 2		# col
	addi $sp $sp -4
	sw $zero ($sp)
	
	jal merge_col
	addi $sp $sp 4
	
	move $a0 $v0
	li $v0 1		# Print my return value.
	syscall

	li $a0 ' '
	li $v0 11
	syscall
	
# 3 up
la $a0 board2		# My board
li $a1 8		# num_rows
li $a2 7		# num_cols
li $a3 4		# col
addi $sp $sp -4
li $t0 1
sw $t0 ($sp)

jal merge_col
addi $sp $sp 4

move $a0 $v0
li $v0 1		# Print my return value.
syscall

li $a0 ' '
li $v0 11
syscall

	# 1 down
	la $a0 board2		# My board
	li $a1 8		# num_rows
	li $a2 7		# num_cols
	li $a3 0		# col
	addi $sp $sp -4
	sw $zero ($sp)
	
	jal merge_col
	addi $sp $sp 4
	
	move $a0 $v0
	li $v0 1		# Print my return value.
	syscall

	li $a0 ' '
	li $v0 11
	syscall
	
# 1 up
la $a0 board2		# My board
li $a1 8		# num_rows
li $a2 7		# num_cols
li $a3 0		# col
addi $sp $sp -4
li $t0 1
sw $t0 ($sp)

jal merge_col
addi $sp $sp 4

move $a0 $v0
li $v0 1		# Print my return value.
syscall

li $a0 ' '
li $v0 11
syscall

	# 1 down
	la $a0 board2		# My board
	li $a1 8		# num_rows
	li $a2 7		# num_cols
	li $a3 6		# col
	addi $sp $sp -4
	sw $zero ($sp)
	
	jal merge_col
	addi $sp $sp 4
	
	move $a0 $v0
	li $v0 1		# Print my return value.
	syscall

	li $a0 ' '
	li $v0 11
	syscall
	
# 1 up
la $a0 board2		# My board
li $a1 8		# num_rows
li $a2 7		# num_cols
li $a3 6		# col
addi $sp $sp -4
li $t0 1
sw $t0 ($sp)

jal merge_col
addi $sp $sp 4

move $a0 $v0
li $v0 1		# Print my return value.
syscall

li $a0 ' '
li $v0 11
syscall
	# 2 down
	la $a0 board5		# My board
	li $a1 4		# num_rows
	li $a2 9		# num_cols
	li $a3 0		# col
	addi $sp $sp -4
	sw $zero ($sp)
	
	jal merge_col
	addi $sp $sp 4
	
	move $a0 $v0
	li $v0 1		# Print my return value.
	syscall

	li $a0 ' '
	li $v0 11
	syscall
	
# 2 down
la $a0 board5		# My board
li $a1 4		# num_rows
li $a2 9		# num_cols
li $a3 1		# col
addi $sp $sp -4
sw $0 ($sp)

jal merge_col
addi $sp $sp 4

move $a0 $v0
li $v0 1		# Print my return value.
syscall

li $a0 ' '
li $v0 11
syscall

	# 2 up
	la $a0 board5		# My board
	li $a1 4		# num_rows
	li $a2 9		# num_cols
	li $a3 8		# col
	addi $sp $sp -4
	li $t0 1
	sw $t0 ($sp)
	
	jal merge_col
	addi $sp $sp 4
	
	move $a0 $v0
	li $v0 1		# Print my return value.
	syscall

	li $a0 ' '
	li $v0 11
	syscall
	
# 2 up
la $a0 board5		# My board
li $a1 4		# num_rows
li $a2 9		# num_cols
li $a3 7		# col
addi $sp $sp -4
li $t0 1
sw $t0 ($sp)

jal merge_col
addi $sp $sp 4

move $a0 $v0
li $v0 1		# Print my return value.
syscall

li $a0 ' '
li $v0 11
syscall

	# 2 down
	la $a0 board5		# My board
	li $a1 4		# num_rows
	li $a2 9		# num_cols
	li $a3 3		# col
	addi $sp $sp -4
	sw $zero ($sp)
	
	jal merge_col
	addi $sp $sp 4
	
	move $a0 $v0
	li $v0 1		# Print my return value.
	syscall

	li $a0 ' '
	li $v0 11
	syscall
	
# 2 up
la $a0 board5		# My board
li $a1 4		# num_rows
li $a2 9		# num_cols
li $a3 5		# col
addi $sp $sp -4
li $t0 1
sw $t0 ($sp)

jal merge_col
addi $sp $sp 4

move $a0 $v0
li $v0 1		# Print my return value.
syscall

li $a0 ' '
li $v0 11
syscall

###################### ERRORS BEGIN HERE
addi $sp $sp -4

	# -1 col value
	la $a0 board4		# My board
	li $a1 4		# num_rows
	li $a2 4		# num_cols
	li $a3 -1		# col
	sw $0 ($sp)
	
	jal merge_col
	move $a0 $v0
	li $v0 1		# Print my return value.
	syscall

	li $a0 ' '
	li $v0 11
	syscall
	
# -1 col value
la $a0 board4		# My board
li $a1 4		# num_rows
li $a2 4		# num_cols
li $a3 4		# col
li $t0 1
sw $t0 ($sp)

jal merge_col

move $a0 $v0
li $v0 1		# Print my return value.
syscall

li $a0 ' '
li $v0 11
syscall

	# -1 num_col
	la $a0 board4		# My board
	li $a1 0		# num_rows
	li $a2 4		# num_cols
	li $a3 0		# col
	sw $0 ($sp)
	
	jal merge_col
	
	move $a0 $v0
	li $v0 1		# Print my return value.
	syscall

	li $a0 ' '
	li $v0 11
	syscall
	
# -1 num_cols
la $a0 board4		# My board
li $a1 4		# num_rows
li $a2 0		# num_cols
li $a3 1		# col
li $t0 1
sw $t0 ($sp)

jal merge_col

move $a0 $v0
li $v0 1		# Print my return value.
syscall

li $a0 ' '
li $v0 11
syscall

	# -1 num_col
	la $a0 board4		# My board
	li $a1 -2		# num_rows
	li $a2 4		# num_cols
	li $a3 0		# col
	sw $0 ($sp)
	
	jal merge_col
	
	move $a0 $v0
	li $v0 1		# Print my return value.
	syscall

	li $a0 ' '
	li $v0 11
	syscall
	
# -1 num_cols
la $a0 board4		# My board
li $a1 4		# num_rows
li $a2 -2		# num_cols
li $a3 1		# col
li $t0 1
sw $t0 ($sp)

jal merge_col

move $a0 $v0
li $v0 1		# Print my return value.
syscall

li $a0 ' '
li $v0 11
syscall

	# -1 direction
	la $a0 board4		# My board
	li $a1 4		# num_rows
	li $a2 4		# num_cols
	li $a3 1		# col
	li $t0 -1
	sw $t0 ($sp)
	
	jal merge_col
	
	move $a0 $v0
	li $v0 1		# Print my return value.
	syscall

	li $a0 ' '
	li $v0 11
	syscall
	
# -1 direction
la $a0 board4		# My board
li $a1 4		# num_rows
li $a2 4		# num_cols
li $a3 2		# col
li $t0 2
sw $t0 ($sp)

jal merge_col

move $a0 $v0
li $v0 1		# Print my return value.
syscall

addi $sp $sp 4
#####################################
# TESTING PART F	SHIFT_ROW
#####################################
la $a0 shiftRowf
li $v0 4
syscall
addi $sp $sp -4

	# 0 not shifting
	la $a0 board1
	li $a1 4
	li $a2 6
	li $a3 1
	sw $zero ($sp)
	jal shift_row
	
	move $a0 $v0
	li $v0 1		# Print return value.
	syscall

	li $a0 ' '
	li $v0 11
	syscall
	
# 0 not shifting
la $a0 board1
li $a1 4
li $a2 6
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

	# 10 left
	la $a0 board2
	li $a1 8
	li $a2 7
	li $a3 7		# row
	sw $0 ($sp)
	jal shift_row
	
	move $a0 $v0
	li $v0 1		# Print return value.
	syscall

	li $a0 ' '
	li $v0 11
	syscall
	
# 10 right
la $a0 board2
li $a1 8
li $a2 7
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

	# 7 right
	la $a0 board2
	li $a1 8
	li $a2 7
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
	
# 2 left
la $a0 board2
li $a1 8
li $a2 7
li $a3 6
sw $0 ($sp)
jal shift_row
	
move $a0 $v0
li $v0 1		# Print return value.
syscall

li $a0 ' '
li $v0 11
syscall

	# 0 right nothing all -1
	la $a0 board2
	li $a1 8
	li $a2 7
	li $a3 4		# row
	li $t0 1
	sw $t0 ($sp)
	jal shift_row
	
	move $a0 $v0
	li $v0 1		# Print return value.
	syscall

	li $a0 ' '
	li $v0 11
	syscall
	
# 0 left
la $a0 board2
li $a1 8
li $a2 7
li $a3 4
sw $0 ($sp)
jal shift_row
	
move $a0 $v0
li $v0 1		# Print return value.
syscall

li $a0 ' '
li $v0 11
syscall

	# 3 left
	la $a0 board4
	li $a1 4
	li $a2 4
	li $a3 2
	sw $0 ($sp)
	jal shift_row
	
	move $a0 $v0
	li $v0 1		# Print return value.
	syscall

	li $a0 ' '
	li $v0 11
	syscall
	
# 0 left
la $a0 board4
li $a1 4
li $a2 4
li $a3 2
sw $0 ($sp)
jal shift_row
	
move $a0 $v0
li $v0 1		# Print return value.
syscall

li $a0 ' '
li $v0 11
syscall

	# 3 right
	la $a0 board4
	li $a1 4
	li $a2 4
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
	
# 0 right
la $a0 board4
li $a1 4
li $a2 4
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

	# -1
	la $a0 board4
	li $a1 4
	li $a2 4
	li $a3 -1	# row
	li $t0 1
	sw $t0 ($sp)
	jal shift_row
	
	move $a0 $v0
	li $v0 1		# Print return value.
	syscall

	li $a0 ' '
	li $v0 11
	syscall
	
# -1
la $a0 board4
li $a1 4
li $a2 4
li $a3 4	# row
li $t0 1
sw $t0 ($sp)
jal shift_row
	
move $a0 $v0
li $v0 1		# Print return value.
syscall

li $a0 ' '
li $v0 11
syscall	

	# -1
	la $a0 board4
	li $a1 1
	li $a2 4
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
	
# 0 right
la $a0 board4
li $a1 4
li $a2 1
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

	# -1
	la $a0 board4
	li $a1 4
	li $a2 4
	li $a3 2
	li $t0 -1
	sw $t0 ($sp)
	jal shift_row
	
	move $a0 $v0
	li $v0 1		# Print return value.
	syscall

	li $a0 ' '
	li $v0 11
	syscall
	
# -1
la $a0 board4
li $a1 4
li $a2 4
li $a3 2
li $t0 2
sw $t0 ($sp)
jal shift_row
	
move $a0 $v0
li $v0 1		# Print return value.
syscall

li $a0 ' '
li $v0 11
syscall	

addi $sp $sp 4

#####################################
# TESTING PART G	SHIFT_COL
#####################################
la $a0 shiftColf
li $v0 4
syscall
addi $sp $sp -4

	# 0 not shifting
	la $a0 board1
	li $a1 4
	li $a2 6
	li $a3 1
	sw $0 ($sp)
	jal shift_col
	
	move $a0 $v0
	li $v0 1		# Print return value.
	syscall

	li $a0 ' '
	li $v0 11
	syscall
	
# 0 not shifting
la $a0 board1
li $a1 4
li $a2 6
li $a3 1
li $t0 1
sw $t0 ($sp)
jal shift_col

move $a0 $v0
li $v0 1		# Print return value.
syscall

li $a0 ' '
li $v0 11
syscall

	# 0 down
	la $a0 board2
	li $a1 8
	li $a2 7
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
	
# 12 up
la $a0 board2
li $a1 8
li $a2 7
li $a3 0
sw $0 ($sp)
jal shift_col
	
move $a0 $v0
li $v0 1		# Print return value.
syscall

li $a0 ' '
li $v0 11
syscall

	# 3 up
	la $a0 board2
	li $a1 8
	li $a2 7
	li $a3 0
	sw $0 ($sp)
	jal shift_col
	
	move $a0 $v0
	li $v0 1		# Print return value.
	syscall

	li $a0 ' '
	li $v0 11
	syscall
	
# 12 down
la $a0 board2
li $a1 8
li $a2 7
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

	# 3 down
	la $a0 board4
	li $a1 4
	li $a2 4
	li $a3 2
	li $t0 1		# down
	sw $t0 ($sp)
	jal shift_col
	
	move $a0 $v0
	li $v0 1		# Print return value.
	syscall

	li $a0 ' '
	li $v0 11
	syscall
	
# 3 down
la $a0 board4
li $a1 4
li $a2 4
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

	# 3 up
	la $a0 board4
	li $a1 4
	li $a2 4
	li $a3 2
	sw $0 ($sp)
	jal shift_col
	
	move $a0 $v0
	li $v0 1		# Print return value.
	syscall

	li $a0 ' '
	li $v0 11
	syscall
	
# 3 down
la $a0 board4
li $a1 4
li $a2 4
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

	# 0
	la $a0 board4
	li $a1 4
	li $a2 4
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
	
# -1
la $a0 board4
li $a1 4
li $a2 4
li $a3 4	# col
li $t0 1
sw $t0 ($sp)
jal shift_col
	
move $a0 $v0
li $v0 1		# Print return value.
syscall

li $a0 ' '
li $v0 11
syscall	

	# -1
	la $a0 board4
	li $a1 1 	#<-
	li $a2 4
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
	
# -1
la $a0 board4
li $a1 4
li $a2 1	# <-
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

	# -1
	la $a0 board4
	li $a1 4
	li $a2 4
	li $a3 2
	li $t0 -1	# <-
	sw $t0 ($sp)
	jal shift_col
	
	move $a0 $v0
	li $v0 1		# Print return value.
	syscall

	li $a0 ' '
	li $v0 11
	syscall
	
# -1
la $a0 board4
li $a1 4
li $a2 4
li $a3 2
li $t0 2	# <-
sw $t0 ($sp)
jal shift_col
	
move $a0 $v0
li $v0 1		# Print return value.
syscall

li $a0 ' '
li $v0 11
syscall	

	# -1
	la $a0 board4
	li $a1 4
	li $a2 4
	li $a3 -1	# row
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

#####################################
# TESTING PART H	CHECK_STATE
#####################################
la $a0 checkStatef
li $v0 4
syscall
	# -1
	la $a0 board1
	li $a1 4
	li $a2 6
	
	jal check_state
	move $a0 $v0
	li $v0 1		# Print return value.
	syscall

	li $a0 ' '
	li $v0 11
	syscall
	
# 0
la $a0 board2
li $a1 8
li $a2 7

jal check_state
move $a0 $v0
li $v0 1		# Print return value.
syscall

li $a0 ' '
li $v0 11
syscall
	
	#####CALLING PLACE CAUSE NOBODY GOT TIME TO MAKE ANOTHER BOARD
	la $a0 board1	# My board
	li $a1 4
	li $a2 6
	li $a3 3
	li $t0 5
	sw $t0 ($sp)
	li $t0 2048
	sw $t0 4($sp)

	jal place
	
	# 1
	la $a0 board1
	li $a1 4
	li $a2 6
	
	jal check_state
	move $a0 $v0
	li $v0 1		# Print return value.
	syscall

	li $a0 ' '
	li $v0 11
	syscall
	
	la $a0 board1	# My board
	li $a1 4
	li $a2 6
	li $a3 3
	li $t0 5
	sw $t0 ($sp)
	li $t0 8	# Put some digits in. Will be using to make sure move works.
	sw $t0 4($sp)

	jal place
	
#####################################
# TESTING PART I	MOVE
#####################################
la $a0 movef
li $v0 4
syscall
	
	# Move left
	la $s0 myGame
	li $s1 4
	li $s2 5
	
	move $a0 $s0
	move $a1 $s1
	move $a2 $s2
	li $a3 'L'
	
	jal user_move
	
	move $a0 $v0
	li $v0 1		# Print return value.
	syscall
	
	move $a0 $v1
	li $v0 1		# Print return value.
	syscall
	
	li $a0 ' '
	li $v0 11
	syscall
	
# Move Right	
move $a0 $s0
move $a1 $s1
move $a2 $s2
li $a3 'R'
	
jal user_move

move $a0 $v0
li $v0 1		# Print return value.
syscall

move $a0 $v1
li $v0 1		# Print return value.
syscall

li $a0 ' '
li $v0 11
syscall

	# Move Up
	move $a0 $s0
	move $a1 $s1
	move $a2 $s2
	li $a3 'U'
	
	jal user_move
	
	move $a0 $v0
	li $v0 1		# Print return value.
	syscall
	
	move $a0 $v1
	li $v0 1		# Print return value.
	syscall
	
	li $a0 ' '
	li $v0 11
	syscall

# Move Down	
move $a0 $s0
move $a1 $s1
move $a2 $s2
li $a3 'D'
	
jal user_move

move $a0 $v0
li $v0 1		# Print return value.
syscall

move $a0 $v1
li $v0 1		# Print return value.
syscall

li $a0 ' '
li $v0 11
syscall

	# Move Right
	move $a0 $s0
	move $a1 $s1
	move $a2 $s2
	li $a3 'R'
	
	jal user_move
	
	move $a0 $v0
	li $v0 1		# Print return value.
	syscall
	
	move $a0 $v1
	li $v0 1		# Print return value.
	syscall
	
	li $a0 ' '
	li $v0 11
	syscall
	

# Move Down	
la $a0 board1
li $a1 4
li $a2 6
li $a3 'D'
	
jal user_move

move $a0 $v0
li $v0 1		# Print return value.
syscall

move $a0 $v1
li $v0 1		# Print return value.
syscall

###################################################################
# End of MAIN program
####################################################################
li $v0, 10
syscall

#################################################################
# Student defined functions will be included starting here
#################################################################

.include "hw4.asm"
