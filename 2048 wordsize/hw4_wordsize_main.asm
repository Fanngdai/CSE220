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

li $s0 -1
li $s1 1
li $s2 2
#####################################
# TESTING PART A	CLEAR_BOARD
# a0 = board
# a1 = num_rows
# a2 = num_cols
#####################################
la $a0 clearBoardf
li $v0 4
syscall

	# -1 bc num_cols = 0 < 2
	li $a0 0xffff0000
	li $a1 6
	li $a2 0

	jal clear_board
	move $a0 $v0
	move $v0 $s1		# Print my return value.
	syscall
	
	li $a0 ' '
	li $v0 11
	syscall

# -1 bc num_cols = 1 < 2
li $a0 0xffff0000
move $a1 $s1
li $a2 8

jal clear_board
move $a0 $v0
move $v0 $s1		# Print my return value.
syscall

li $a0 ' '
li $v0 11
syscall

	# -1 bc num_rows = -1 < 2
	li $a0 0xffff0000
	li $a1 -1
	li $a2 8

	jal clear_board
	move $a0 $v0
	move $v0 $s1		# Print my return value.
	syscall
	
	li $a0 ' '
	li $v0 11
	syscall
	
# 0 success
li $a0 0xffff0000
li $a1 6
li $a2 8

jal clear_board
move $a0 $v0
move $v0 $s1		# Print my return value.
syscall

li $a0 ' '
li $v0 11
syscall
	
	# 0 success
	li $a0 0xffff0000
	li $a1 5
	li $a2 5

	jal clear_board
	move $a0 $v0
	move $v0 $s1		# Print my return value.
	syscall
	
	li $a0 ' '
	li $v0 11
	syscall

# 0 sucess
li $a0 0xffff0000
move $a1 $s2
li $a2 6

jal clear_board
move $a0 $v0
move $v0 $s1		# Print my return value.
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

	# -1 bc n_rows = -9 < 2
	li $a0 0xffff0000	# My board
	li $a1 -9
	li $a2 5
	li $a3 3
	addi $sp $sp 8
	sw $s2 ($sp)
	sw $s0 4($sp)
	
	jal place
	addi $sp $sp -8
	move $a0 $v0
	move $v0 $s1		# Print my return value.
	syscall
	
	li $a0 ' '
	li $v0 11
	syscall
	
# -1 bc n_rows = 1 < 2
li $a0 0xffff0000	# My board
move $a1 $s1
li $a2 5
li $a3 3
addi $sp $sp 8
sw $s2 ($sp)
sw $s0 4($sp)

jal place
addi $sp $sp -8
move $a0 $v0
move $v0 $s1		# Print my return value.
syscall

li $a0 ' '
li $v0 11
syscall

	# -1 bc n_cols = 0 < 2
	li $a0 0xffff0000	# My board
	move $a1 $0
	li $a2 5
	li $a3 3
	addi $sp $sp 8
	sw $s2 ($sp)
	sw $s0 4($sp)
	
	jal place
	addi $sp $sp -8
	move $a0 $v0
	move $v0 $s1		# Print my return value.
	syscall
	
	li $a0 ' '
	li $v0 11
	syscall

# -1 bc n_col = 1 < 2
li $a0 0xffff0000	# My board
li $a1 5
move $a2 $s1
li $a3 1
addi $sp $sp 8
sw $s2 ($sp)
sw $s0 4($sp)

jal place
addi $sp $sp -8
move $a0 $v0
move $v0 $s1		# Print my return value.
syscall

li $a0 ' '
li $v0 11
syscall

	# -1 row = -1 < 0 out of range
	li $a0 0xffff0000	# My board
	move $a1 $s2
	li $a2 5
	move $a3 $s0
	addi $sp $sp 8
	sw $s2 ($sp)
	sw $s0 4($sp)

	jal place
	addi $sp $sp -8
	move $a0 $v0
	move $v0 $s1		# Print my return value.
	syscall

	li $a0 ' '
	li $v0 11
	syscall

# -1 row = num_row out of range
li $a0 0xffff0000	# My board
move $a1 $s2
li $a2 5
move $a3 $a1
addi $sp $sp 8
sw $s2 ($sp)
sw $s0 4($sp)

jal place
addi $sp $sp -8
move $a0 $v0
move $v0 $s1		# Print my return value.
syscall

li $a0 ' '
li $v0 11
syscall
	
	# -1 col = -1 < 0 out of range
	li $a0 0xffff0000	# My board
	li $a1 7
	li $a2 2
	move $a3 $s0
	addi $sp $sp 8
	sw $s0 ($sp)
	sw $s0 4($sp)

	jal place
	addi $sp $sp -8
	move $a0 $v0
	move $v0 $s1		# Print my return value.
	syscall

	li $a0 ' '
	li $v0 11
	syscall

# -1 col = num_cols out of range
li $a0 0xffff0000	# My board
move $a1 $s2
li $a2 5
li $a3 1
addi $sp $sp 8
sw $a2 ($sp)
sw $s0 4($sp)

jal place
addi $sp $sp -8
move $a0 $v0
move $v0 $s1		# Print my return value.
syscall

li $a0 ' '
li $v0 11
syscall

	# -1 val = 0
	li $a0 0xffff0000	# My board
	move $a1 $s2
	li $a2 5
	li $a3 1
	addi $sp $sp 8
	sw $s2 ($sp)
	sw $0 4($sp)

	jal place
	addi $sp $sp -8
	move $a0 $v0	
	move $v0 $s1		# Print my return value.
	syscall

	li $a0 ' '
	li $v0 11
	syscall

# -1 val = 3
li $a0 0xffff0000	# My board
move $a1 $s2
li $a2 5
li $a3 1
addi $sp $sp 8
sw $s2 ($sp)
li $t0 3
sw $t0 4($sp)

jal place
addi $sp $sp -8
move $a0 $v0
move $v0 $s1		# Print my return value.
syscall

li $a0 ' '
li $v0 11
syscall

	# -1 val = -2
	li $a0 0xffff0000	# My board
	move $a1 $s2
	li $a2 5
	li $a3 1
	addi $sp $sp 8
	sw $s2 ($sp)
	li $t0 -2
	sw $t0 4($sp)

	jal place
	addi $sp $sp -8
	move $a0 $v0
	move $v0 $s1		# Print my return value.
	syscall

	li $a0 ' '
	li $v0 11
	syscall

# 0 success 2X5 	1,2 	val -1
li $a0 0xffff0000	# My board
move $a1 $s2
li $a2 5
li $a3 1
addi $sp $sp 8
sw $s2 ($sp)
sw $s0 4($sp)

jal place
addi $sp $sp -8
move $a0 $v0
move $v0 $s1		# Print my return value.
syscall

li $a0 ' '
li $v0 11
syscall

	# 0 success
	li $a0 0xffff0000	# My board
	li $a1 8
	li $a2 7
	li $a3 7
	addi $sp $sp 8
	sw $s2 ($sp)
	li $t0 16384		# a power of 2
	sw $t0 4($sp)

	jal place
	addi $sp $sp -8
	move $a0 $v0
	move $v0 $s1		# Print my return value.
	syscall

#####################################
# TESTING PART C	START_GAME
#####################################
la $a0 startGamef
li $v0 4
syscall

	# -1 bc num_row < 2
	li $a0 0xffff0000	# My board
	li $a1 0		# num_rows
	li $a2 7		# num_cols
	li $a3 4		# r1

	li $t0 6		# c1
	li $t1 4		# r2
	li $t2 5		# c2

	addi $sp $sp -12	# Shove my value in stack pointer
	sw $t0 ($sp)
	sw $t1 4($sp)
	sw $t2 8($sp)

	jal start_game
	addi $sp $sp 12

	move $a0 $v0
	li $v0 1		# Print my return value.
	syscall
	
	li $a0 ' '
	li $v0 11
	syscall
	
# -1 bc num_row < 2
li $a0 0xffff0000	# My board
li $a1 1		# num_rows
li $a2 7		# num_cols
li $a3 4		# r1

li $t0 6		# c1
li $t1 4		# r2
li $t2 5		# c2

addi $sp $sp -12	# Shove my value in stack pointer
sw $t0 ($sp)
sw $t1 4($sp)
sw $t2 8($sp)

jal start_game
addi $sp $sp 12

move $a0 $v0
li $v0 1		# Print my return value.
syscall

li $a0 ' '
li $v0 11
syscall

	# -1 bc num_col < 2
	li $a0 0xffff0000	# My board
	li $a1 6		# num_rows
	li $a2 -2		# num_cols
	li $a3 4		# r1

	li $t0 6		# c1
	li $t1 4		# r2
	li $t2 5		# c2

	addi $sp $sp -12	# Shove my value in stack pointer
	sw $t0 ($sp)
	sw $t1 4($sp)
	sw $t2 8($sp)

	jal start_game
	addi $sp $sp 12

	move $a0 $v0
	li $v0 1		# Print my return value.
	syscall

	li $a0 ' '
	li $v0 11
	syscall

# -1 bc num_col < 2
li $a0 0xffff0000	# My board
li $a1 1		# num_rows
li $a2 0		# num_cols
li $a3 4		# r1

li $t0 6		# c1
li $t1 4		# r2
li $t2 5		# c2

addi $sp $sp -12	# Shove my value in stack pointer
sw $t0 ($sp)
sw $t1 4($sp)
sw $t2 8($sp)

jal start_game
addi $sp $sp 12

move $a0 $v0
li $v0 1		# Print my return value.
syscall

li $a0 ' '
li $v0 11
syscall

	# -1 bc r1 < 0
	li $a0 0xffff0000	# My board
	li $a1 6		# num_rows
	li $a2 7		# num_cols
	li $a3 -1		# r1

	li $t0 6		# c1
	li $t1 4		# r2
	li $t2 5		# c2

	addi $sp $sp -12	# Shove my value in stack pointer
	sw $t0 ($sp)
	sw $t1 4($sp)
	sw $t2 8($sp)

	jal start_game
	addi $sp $sp 12

	move $a0 $v0
	li $v0 1		# Print my return value.
	syscall

	li $a0 ' '
	li $v0 11
	syscall
	
# -1 bc r1 = num_row > num_rows-1 out of range
li $a0 0xffff0000	# My board
li $a1 6		# num_rows
li $a2 7		# num_cols
li $a3 6		# r1

li $t0 6		# c1
li $t1 4		# r2
li $t2 5		# c2

addi $sp $sp -12	# Shove my value in stack pointer
sw $t0 ($sp)
sw $t1 4($sp)
sw $t2 8($sp)

jal start_game
addi $sp $sp 12

move $a0 $v0
li $v0 1		# Print my return value.
syscall

li $a0 ' '
li $v0 11
syscall
	
	# -1 bc r1 > num_rows-1
	li $a0 0xffff0000	# My board
	li $a1 6		# num_rows
	li $a2 7		# num_cols
	li $a3 7		# r1

	li $t0 6		# c1
	li $t1 4		# r2
	li $t2 5		# c2

	addi $sp $sp -12	# Shove my value in stack pointer
	sw $t0 ($sp)
	sw $t1 4($sp)
	sw $t2 8($sp)

	jal start_game
	addi $sp $sp 12

	move $a0 $v0
	li $v0 1		# Print my return value.
	syscall

	li $a0 ' '
	li $v0 11
	syscall
	
# -1 bc r2 < 0
li $a0 0xffff0000	# My board
li $a1 6		# num_rows
li $a2 7		# num_cols
li $a3 5		# r1

li $t0 6		# c1
li $t1 -1		# r2
li $t2 5		# c2

addi $sp $sp -12	# Shove my value in stack pointer
sw $t0 ($sp)
sw $t1 4($sp)
sw $t2 8($sp)

jal start_game
addi $sp $sp 12

move $a0 $v0
li $v0 1		# Print my return value.
syscall

li $a0 ' '
li $v0 11
syscall

	# -1 bc r2 = num_row > num_rows-1 out of range
	li $a0 0xffff0000	# My board
	li $a1 6		# num_rows
	li $a2 7		# num_cols
	li $a3 5		# r1

	li $t0 6		# c1
	li $t1 6		# r2
	li $t2 5		# c2

	addi $sp $sp -12	# Shove my value in stack pointer
	sw $t0 ($sp)
	sw $t1 4($sp)
	sw $t2 8($sp)

	jal start_game
	addi $sp $sp 12

	move $a0 $v0
	li $v0 1		# Print my return value.
	syscall

	li $a0 ' '
	li $v0 11
	syscall
	
# -1 bc r2 > num_rows-1
li $a0 0xffff0000	# My board
li $a1 6		# num_rows
li $a2 7		# num_cols
li $a3 5		# r1

li $t0 6		# c1
li $t1 7		# r2
li $t2 5		# c2

addi $sp $sp -12	# Shove my value in stack pointer
sw $t0 ($sp)
sw $t1 4($sp)
sw $t2 8($sp)

jal start_game
addi $sp $sp 12

move $a0 $v0
li $v0 1		# Print my return value.
syscall

li $a0 ' '
li $v0 11
syscall

	# -1 bc c1 < 0
	li $a0 0xffff0000	# My board
	li $a1 6		# num_rows
	li $a2 7		# num_cols
	li $a3 5		# r1

	li $t0 -1		# c1
	li $t1 3		# r2
	li $t2 5		# c2

	addi $sp $sp -12	# Shove my value in stack pointer
	sw $t0 ($sp)
	sw $t1 4($sp)
	sw $t2 8($sp)

	jal start_game
	addi $sp $sp 12

	move $a0 $v0
	li $v0 1		# Print my return value.
	syscall

	li $a0 ' '
	li $v0 11
	syscall
	
# -1 bc c1 = num_cols > num_cols-1 out of range
li $a0 0xffff0000	# My board
li $a1 6		# num_rows
li $a2 7		# num_cols
li $a3 5		# r1

li $t0 7		# c1
li $t1 4		# r2
li $t2 5		# c2

addi $sp $sp -12	# Shove my value in stack pointer
sw $t0 ($sp)
sw $t1 4($sp)
sw $t2 8($sp)

jal start_game
addi $sp $sp 12

move $a0 $v0
li $v0 1		# Print my return value.
syscall

li $a0 ' '
li $v0 11
syscall

	# -1 bc c1 > num_cols-1
	li $a0 0xffff0000	# My board
	li $a1 5		# num_rows
	li $a2 7		# num_cols
	li $a3 4		# r1
	
	li $t0 20		# c1
	li $t1 4		# r2
	li $t2 5		# c2
	
	addi $sp $sp -12	# Shove my value in stack pointer
	sw $t0 ($sp)
	sw $t1 4($sp)
	sw $t2 8($sp)
	
	jal start_game
	addi $sp $sp 12
	
	move $a0 $v0
	li $v0 1		# Print my return value.
	syscall
	
	li $a0 ' '
	li $v0 11
	syscall
	
# -1 bc c2 < 0
li $a0 0xffff0000	# My board
li $a1 5		# num_rows
li $a2 7		# num_cols
li $a3 4		# r1
	
li $t0 6		# c1
li $t1 4		# r2
li $t2 -2		# c2
	
addi $sp $sp -12	# Shove my value in stack pointer
sw $t0 ($sp)
sw $t1 4($sp)
sw $t2 8($sp)
	
jal start_game
addi $sp $sp 12
	
move $a0 $v0
li $v0 1		# Print my return value.
syscall

li $a0 ' '
li $v0 11
syscall

	# -1 bc c2 = num_col > num_col-1 out of range
	li $a0 0xffff0000	# My board
	li $a1 5		# num_rows
	li $a2 7		# num_cols
	li $a3 4		# r1
	
	li $t0 6		# c1
	li $t1 4		# r2
	li $t2 7		# c2
	
	addi $sp $sp -12	# Shove my value in stack pointer
	sw $t0 ($sp)
	sw $t1 4($sp)
	sw $t2 8($sp)
	
	jal start_game
	addi $sp $sp 12
	
	move $a0 $v0
	li $v0 1		# Print my return value.
	syscall
	
	li $a0 ' '
	li $v0 11
	syscall
	
# -1 bc c2 > num_rows-1
li $a0 0xffff0000	# My board
li $a1 5		# num_rows
li $a2 7		# num_cols
li $a3 4		# r1
	
li $t0 6		# c1
li $t1 4		# r2
li $t2 8		# c2
	
addi $sp $sp -12	# Shove my value in stack pointer
sw $t0 ($sp)
sw $t1 4($sp)
sw $t2 8($sp)
	
jal start_game
addi $sp $sp 12
	
move $a0 $v0
li $v0 1		# Print my return value.
syscall

li $a0 ' '
li $v0 11
syscall
	
	# 0 sucess
	li $a0 0xffff0000	# My board
	li $a1 70		# num_rows
	li $a2 70		# num_cols
	li $a3 68		# r1
	
	li $t0 1		# c1
	li $t1 56		# r2
	li $t2 63		# c2
	
	addi $sp $sp -12	# Shove my value in stack pointer
	sw $t0 ($sp)
	sw $t1 4($sp)
	sw $t2 8($sp)
	
	jal start_game
	addi $sp $sp 12
	
	move $a0 $v0
	li $v0 1		# Print my return value.
	syscall
	
	li $a0 ' '
	li $v0 11
	syscall

# 0 sucess
li $a0 0xffff0000	# My board
li $a1 2		# num_rows
li $a2 2		# num_cols
li $a3 0		# r1
	
li $t0 0		# r2
li $t1 0		# c1
li $t2 1		# c2
	
addi $sp $sp -12	# Shove my value in stack pointer
sw $t0 ($sp)
sw $t1 4($sp)
sw $t2 8($sp)
	
jal start_game
addi $sp $sp 12
	
move $a0 $v0
li $v0 1		# Print my return value.
syscall

li $a0 ' '
li $v0 11
syscall

	# 0 sucess
	li $a0 0xffff0000	# My board
	li $a1 5		# num_rows
	li $a2 7		# num_cols
	li $a3 4		# r1
	
	li $t0 6		# c1
	li $t1 4		# r2
	li $t2 5		# c2
	
	addi $sp $sp -12	# Shove my value in stack pointer
	sw $t0 ($sp)
	sw $t1 4($sp)
	sw $t2 8($sp)
	
	jal start_game
	addi $sp $sp 12
	
	move $a0 $v0
	li $v0 1		# Print my return value.
	syscall

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
	
	# 1 direction left-to-right no combine
	la $a0 board1a		# My board
	li $a1 4		# num_rows
	li $a2 4		# num_cols
	li $a3 0		# row
	addi $sp $sp -4
	sw $0 ($sp)
	
	jal merge_row
	addi $sp $sp 4
	
	move $a0 $v0
	li $v0 1		# Print my return value.
	syscall

	li $a0 ' '
	li $v0 11
	syscall
	
# 1 direction right-to-left no combine
la $a0 board1b		# My board
li $a1 4		# num_rows
li $a2 4		# num_cols
li $a3 0		# row
addi $sp $sp -4
li $t0 1
sw $t0 ($sp)

jal merge_row
addi $sp $sp 4

move $a0 $v0
li $v0 1		# Print my return value.
syscall

li $a0 ' '
li $v0 11
syscall

	# 1 direction left-to-right combine some
	la $a0 board1a		# My board
	li $a1 4		# num_rows
	li $a2 4		# num_cols
	li $a3 3		# row
	addi $sp $sp -4
	sw $0 ($sp)
	
	jal merge_row
	addi $sp $sp 4
	
	move $a0 $v0
	li $v0 1		# Print my return value.
	syscall

	li $a0 ' '
	li $v0 11
	syscall
	
# 1 direction right-to-left combine some
la $a0 board1b		# My board
li $a1 4		# num_rows
li $a2 4		# num_cols
li $a3 3		# row
addi $sp $sp -4
li $t0 1
sw $t0 ($sp)

jal merge_row
addi $sp $sp 4

move $a0 $v0
li $v0 1		# Print my return value.
syscall

li $a0 ' '
li $v0 11
syscall
	
	# 2 direction left-to-right combine all
	la $a0 board1a		# My board
	li $a1 4		# num_rows
	li $a2 4		# num_cols
	li $a3 1		# row
	addi $sp $sp -4
	sw $0 ($sp)
	
	jal merge_row
	addi $sp $sp 4
	
	move $a0 $v0
	li $v0 1		# Print my return value.
	syscall

	li $a0 ' '
	li $v0 11
	syscall
	
# 2 direction right-to-left combine all
la $a0 board1b		# My board
li $a1 4		# num_rows
li $a2 4		# num_cols
li $a3 1		# row
addi $sp $sp -4
li $t0 1
sw $t0 ($sp)

jal merge_row
addi $sp $sp 4

move $a0 $v0
li $v0 1		# Print my return value.
syscall

li $a0 ' '
li $v0 11
syscall

	# 2 direction left-to-right combine none
	la $a0 board1a		# My board
	li $a1 4		# num_rows
	li $a2 4		# num_cols
	li $a3 2		# row
	addi $sp $sp -4
	sw $0 ($sp)
	
	jal merge_row
	addi $sp $sp 4
	
	move $a0 $v0
	li $v0 1		# Print my return value.
	syscall

	li $a0 ' '
	li $v0 11
	syscall
	
# 2 direction right-to-left combine none
la $a0 board1b		# My board
li $a1 4		# num_rows
li $a2 4		# num_cols
li $a3 2		# row
addi $sp $sp -4
li $t0 1
sw $t0 ($sp)

jal merge_row
addi $sp $sp 4

move $a0 $v0
li $v0 1		# Print my return value.
syscall

li $a0 ' '
li $v0 11
syscall

	# 3 direction left-to-right combine none
	la $a0 board2a		# My board
	li $a1 3		# num_rows
	li $a2 3		# num_cols
	li $a3 1		# row
	addi $sp $sp -4
	sw $0 ($sp)
	
	jal merge_row
	addi $sp $sp 4
	
	move $a0 $v0
	li $v0 1		# Print my return value.
	syscall

	li $a0 ' '
	li $v0 11
	syscall
	
# 3 direction right-to-left combine none
la $a0 board2b		# My board
li $a1 3		# num_rows
li $a2 3		# num_cols
li $a3 1		# row
addi $sp $sp -4
li $t0 1
sw $t0 ($sp)

jal merge_row
addi $sp $sp 4

move $a0 $v0
li $v0 1		# Print my return value.
syscall

li $a0 ' '
li $v0 11
syscall

	# 2 direction left-to-right combine some
	la $a0 board2a		# My board
	li $a1 3		# num_rows
	li $a2 3		# num_cols
	li $a3 2		# row
	addi $sp $sp -4
	sw $0 ($sp)
	
	jal merge_row
	addi $sp $sp 4
	
	move $a0 $v0
	li $v0 1		# Print my return value.
	syscall

	li $a0 ' '
	li $v0 11
	syscall
	
# 2 direction right-to-left combine some
la $a0 board2b		# My board
li $a1 3		# num_rows
li $a2 3		# num_cols
li $a3 2		# row
addi $sp $sp -4
li $t0 1
sw $t0 ($sp)

jal merge_row
addi $sp $sp 4

move $a0 $v0
li $v0 1		# Print my return value.
syscall

li $a0 ' '
li $v0 11
syscall

	# 2 direction left-to-right combine some
	la $a0 board3a		# My board
	li $a1 3		# num_rows
	li $a2 3		# num_cols
	li $a3 2		# row
	addi $sp $sp -4
	sw $0 ($sp)
	
	jal merge_row
	addi $sp $sp 4
	
	move $a0 $v0
	li $v0 1		# Print my return value.
	syscall

	li $a0 ' '
	li $v0 11
	syscall
	
# 2 direction right-to-left combine some
la $a0 board3b		# My board
li $a1 3		# num_rows
li $a2 3		# num_cols
li $a3 2		# row
addi $sp $sp -4
li $t0 1
sw $t0 ($sp)

jal merge_row
addi $sp $sp 4

move $a0 $v0
li $v0 1		# Print my return value.
syscall

li $a0 ' '
li $v0 11
syscall

	# 0 direction left-to-right combine some
	la $a0 board4a		# My board
	li $a1 2		# num_rows
	li $a2 2		# num_cols
	li $a3 1		# row
	addi $sp $sp -4
	sw $0 ($sp)
	
	jal merge_row
	addi $sp $sp 4
	
	move $a0 $v0
	li $v0 1		# Print my return value.
	syscall

	li $a0 ' '
	li $v0 11
	syscall
	
# 0 direction right-to-left combine some
la $a0 board4b		# My board
li $a1 2		# num_rows
li $a2 2		# num_cols
li $a3 1		# row
addi $sp $sp -4
li $t0 1
sw $t0 ($sp)

jal merge_row
addi $sp $sp 4

move $a0 $v0
li $v0 1		# Print my return value.
syscall

#####################################
# TESTING PART E	MERGE_COL
#####################################
la $a0 mergeColf
li $v0 4
syscall

	# 1 direction bottom to top
	la $a0 board1c	# My board
	li $a1 4		# num_rows
	li $a2 4		# num_cols
	li $a3 0		# col
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
	
# 1 direction top to bottom
la $a0 board1d		# My board
li $a1 4		# num_rows
li $a2 4		# num_cols
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

	# 1 direction bottom to top
	la $a0 board1c		# My board
	li $a1 4		# num_rows
	li $a2 4		# num_cols
	li $a3 3		# row
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
	
# 1 direction top to bottom
la $a0 board1d		# My board
li $a1 4		# num_rows
li $a2 4		# num_cols
li $a3 3		# col
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
	
	# 2 direction bottom to top
	la $a0 board1c		# My board
	li $a1 4		# num_rows
	li $a2 4		# num_cols
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
	
# 2 direction top to bottom
la $a0 board1d		# My board
li $a1 4		# num_rows
li $a2 4		# num_cols
li $a3 1		# col
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

	# 2 direction bottom to top
	la $a0 board1c		# My board
	li $a1 4		# num_rows
	li $a2 4		# num_cols
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
	
# 2 direction top to bottom
la $a0 board1d		# My board
li $a1 4		# num_rows
li $a2 4		# num_cols
li $a3 2		# col
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

	# 3 direction bottom to top
	la $a0 board2c		# My board
	li $a1 3		# num_rows
	li $a2 3		# num_cols
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
	
# 3 direction top to bottom
la $a0 board2d		# My board
li $a1 3		# num_rows
li $a2 3		# num_cols
li $a3 1		# col
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

	# 2 direction bottom to top
	la $a0 board2c		# My board
	li $a1 3		# num_rows
	li $a2 3		# num_cols
	li $a3 0		# col
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
	
# 2 direction top to bottom
la $a0 board2d		# My board
li $a1 3		# num_rows
li $a2 3		# num_cols
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

	# 2 direction bottom to top
	la $a0 board3c		# My board
	li $a1 3		# num_rows
	li $a2 3		# num_cols
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
	
# 2 direction top to bottom
la $a0 board3d		# My board
li $a1 3		# num_rows
li $a2 3		# num_cols
li $a3 2		# col
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

	# 0 direction bottom to top
	la $a0 board5c		# My board
	li $a1 2		# num_rows
	li $a2 2		# num_cols
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
	
# 0 direction top to bottom
la $a0 board5d		# My board
li $a1 2		# num_rows
li $a2 2		# num_cols
li $a3 1		# col
addi $sp $sp -4
li $t0 1
sw $t0 ($sp)

jal merge_col
addi $sp $sp 4

move $a0 $v0
li $v0 1		# Print my return value.
syscall

#####################################
# TESTING PART F	SHIFT_ROW
#####################################
la $a0 shiftRowf
li $v0 4
syscall
addi $sp $sp -4

	# 0 not shifting
	la $a0 board1c
	li $a1 4
	li $a2 4
	li $a3 0
	sw $0 ($sp)
	jal shift_row
	
	move $a0 $v0
	li $v0 1		# Print return value.
	syscall

	li $a0 ' '
	li $v0 11
	syscall
	
# 0 not shifting
la $a0 board1c
li $a1 4
li $a2 4
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

	# 0 not shifting
	la $a0 shiftFull
	li $a1 6
	li $a2 4
	li $a3 0
	sw $0 ($sp)
	jal shift_row
	
	move $a0 $v0
	li $v0 1		# Print return value.
	syscall

	li $a0 ' '
	li $v0 11
	syscall
	
# 0 not shifting
la $a0 shiftFull
li $a1 6
li $a2 4
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

	# 3
	la $a0 board1c
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
	
# 0
la $a0 board1c
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

	# 3
	la $a0 board1c
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
	
# 0
la $a0 board1c
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

	# 3
	la $a0 shiftRow
	li $a1 4
	li $a2 5
	li $a3 0
	sw $0 ($sp)
	jal shift_row
	
	move $a0 $v0
	li $v0 1		# Print return value.
	syscall

	li $a0 ' '
	li $v0 11
	syscall
	
# 3
la $a0 shiftRow
li $a1 4
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

	# 3
	la $a0 shiftRow
	li $a1 4
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
	
# 3
la $a0 shiftRow
li $a1 4
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

addi $sp $sp 4
#####################################
# TESTING PART G	SHIFT_COL
#####################################
la $a0 shiftColf
li $v0 4
syscall
addi $sp $sp -4

	# 0 not shifting
	la $a0 board1b
	li $a1 4
	li $a2 4
	li $a3 0
	sw $0 ($sp)
	jal shift_col
	
	move $a0 $v0
	li $v0 1		# Print return value.
	syscall

	li $a0 ' '
	li $v0 11
	syscall
	
# 0 not shifting
la $a0 board1b
li $a1 4
li $a2 4
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

	# 0 not shifting
	la $a0 shiftFull
	li $a1 6
	li $a2 4
	li $a3 0
	sw $0 ($sp)
	jal shift_col
	
	move $a0 $v0
	li $v0 1		# Print return value.
	syscall

	li $a0 ' '
	li $v0 11
	syscall
	
# 0 not shifting
la $a0 shiftFull
li $a1 6
li $a2 4
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

	# 3
	la $a0 board1b
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
	
# 0
la $a0 board1b
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

	# 3
	la $a0 board1b
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
la $a0 board1b
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

	# 3
	la $a0 shiftCol
	li $a1 5
	li $a2 4
	li $a3 0
	sw $0 ($sp)
	jal shift_col
	
	move $a0 $v0
	li $v0 1		# Print return value.
	syscall

	li $a0 ' '
	li $v0 11
	syscall
	
# 3
la $a0 shiftCol
li $a1 5
li $a2 4
li $a3 1
sw $0 ($sp)
jal shift_col
	
move $a0 $v0
li $v0 1		# Print return value.
syscall

li $a0 ' '
li $v0 11
syscall	

	# 3
	la $a0 shiftCol
	li $a1 5
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
	
# 3
la $a0 shiftCol
li $a1 5
li $a2 4
li $a3 3
li $t0 1
sw $t0 ($sp)
jal shift_col
	
move $a0 $v0
li $v0 1		# Print return value.
syscall

addi $sp $sp 4
#####################################
# TESTING PART H	CHECK_STATE
#####################################
la $a0 checkStatef
li $v0 4
syscall
	# -1
	la $a0 loseGame
	li $a1 2
	li $a2 2
	
	jal check_state
	move $a0 $v0
	li $v0 1		# Print return value.
	syscall

	li $a0 ' '
	li $v0 11
	syscall
	
# -1
la $a0 shiftFull
li $a1 6
li $a2 4
	
jal check_state
move $a0 $v0
li $v0 1		# Print return value.
syscall

li $a0 ' '
li $v0 11
syscall
	
	# 0
	la $a0 board1a
	li $a1 6
	li $a2 4
	
	jal check_state
	move $a0 $v0
	li $v0 1		# Print return value.
	syscall

	li $a0 ' '
	li $v0 11
	syscall
	
# 1
la $a0 board3a
li $a1 3
li $a2 3

jal check_state
move $a0 $v0
li $v0 1		# Print return value.
syscall
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
la $a0 loseGame
li $a1 2
li $a2 2
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
