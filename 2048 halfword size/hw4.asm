
##############################################################
# Homework #4
# name: Fanng Dai
# sbuid: 109684495
##############################################################
.text
##############################################################
# HOMEWORK 4 PART 1 a
# $a0 = cell[][] board	address
# $a1 = int num_rows	num rows in board
# $a2 = int num_cols	num cols in board
# returns: 0 for sucess, -1 for error
##############################################################
clear_board:
	blt $a1 2 invalidRowCol
	blt $a2 2 invalidRowCol
	
	addi $sp $sp -24		# Look at line 40. That's why we add 32.
	sw $ra ($sp)
	sw $s0 4($sp)
	sw $s1 8($sp)
	sw $s2 12($sp)
	sw $s3 16($sp)
	sw $s4 20($sp)
	
	move $s0 $a0			# Shove the given arguments into save register
	move $s1 $a1
	move $s2 $a2
	
	li $s3 0			# Row
	li $s4 0			# col
	
	clearing:
		move $a0 $s0		# These are all constant values.
		move $a1 $s1
		move $a2 $s2
	
		addi $sp $sp -8
		move $a3 $s3		# Row
		sw $s4 0($sp)		# Col
		li $t0 -1		# value
		sw $t0 4($sp)
		
		jal place		# Put -1 at that location
		addi $sp $sp 8
		beq $v0 -1 invalid_Clearing
		
		addi $s4 $s4 1		# col ++
		bne $s4 $s2 clearing	# There are more cols in this row
		
		li $s4 0		# set col = 0
		addi $s3 $s3 1		# row ++
		bne $s3 $s1 clearing	# Not finished with the board. At a new row.
		
	valid_Clearing:			# Goes to invalid_Clearing so that we can shove the registers back
		li $v0 0		# Success return 0
	invalid_Clearing:		# Put registers back.
		lw $s4 20($sp)
		lw $s3 16($sp)
		lw $s2 12($sp)
		lw $s1 8($sp)
		lw $s0 4($sp)
		lw $ra ($sp)
		addi $sp $sp 24
		jr $ra
		
	invalidRowCol:		# Row or Col is less than 2
		li $v0 -1
		jr $ra
		
##############################################################
# HOMEWORK 4 PART 1 b
# $a0 = int[][] board	address
# $a1 = int n_rows	num rows in board
# $a2 = int n_cols	num cols in board
# $a3 = int row		i
# 0($sp) = int col	j
# 4($sp) = int val	value to put at position
##############################################################
place:
	blt $a1 2 invalidPlace		# n_rows is less than 2
	blt $a2 2 invalidPlace		# n_cols is less than 2
	
	bltz $a3 invalidPlace		# row is less than 0, outside the range
	bge $a3 $a1 invalidPlace	# row >= n_rows, outside the range
	
	lw $t5 ($sp)			# Get the value of col
	bltz $t5 invalidPlace		# col is less than 0, outside the range
	bge $t5 $a2 invalidPlace	# col >= n_cols, outside the range
	
	lh $t6 4($sp)			# Get the actual value but the value is only half word
	move $t7 $t6			# Will be modifying the value. Need to keep the value to store.
	bltz $t6 lessThanZero
	beq $t6 -1 validPlace		# value = -1
	blt $t6 2 invalidPlace		# value = 0|1; not possible
	
	li $t1 2 			# Equal to 2. Bc we gotta keep dividing by 2
	checkValue:
		div $t6 $t1		# value / 2
		mflo $t6		# value %= 2
		mfhi $t2		# Get the remainder
		bnez $t2 invalidPlace	# remainder is not 0
		beq $t6 1 validPlace	# Keep dividing value by 2. If it ends up as 1, it is a power of 2.
	j checkValue
	
	lessThanZero:
		bne $t6 -1 invalidPlace	# -1 is a valid val
	validPlace:			# a[i][j] = base address + (i*n_col+j) * size	t5 = col = j	t6 = val
		mul $t0 $a3 $a2		# i * n_col
		add $t0 $t0 $t5		# (i*n_col) + j
		sll $t0 $t0 1		# [(i*n_col) + j] * 2	size = 2
		add $t0 $t0 $a0		# a[i][j]
		sh $t7 ($t0)		# put the val in index
		
		li $v0 0
		jr $ra
	invalidPlace:
		li $v0 -1
		jr $ra

##############################################################
# HOMEWORK 4 PART 1 c
# $a0 = int[][] board	address
# $a1 = int n_rows	num rows in board
# $a2 = int n_cols	num cols in board
# $a3 = int r1		row num for first starting value
# 0($sp) = int c1	col num for first starting value
# 4($sp) = int r2	row num for second starting value
# 8($sp) = int c2	col num for second starting value
##############################################################
start_game:
    	blt $a1 2 invalidSG	# n_rows is less than 2
	blt $a2 2 invalidSG	# n_cols is less than 2
   	
   	bltz $a3 invalidSG	# r1 < 0
   	bge $a3 $a1 invalidSG	# r1 >= num_rows
   	
   	lw $t0 4($sp)		# Get the value of r2
   	bltz $t0 invalidSG	# r2 < 0
   	bge $t0 $a1 invalidSG	# r2 >= num_rows
   	
   	lw $t1 ($sp)		# Get the value of c1
   	bltz $t1 invalidSG	# c1 < 0
   	bge $t1 $a2 invalidSG	# c1 >= num_cols
   	
   	lw $t2 8($sp)		# Get the value of c2
   	bltz $t2 invalidSG	# c2 < 0
   	bge $t2 $a2 invalidSG	# c2 >= num_cols
   	
   	addi $sp $sp -32
   	sw $ra ($sp)
   	sw $s0 4($sp)
   	sw $s1 8($sp)
   	sw $s2 12($sp)
   	sw $s3 16($sp)
   	sw $s4 20($sp)
   	sw $s5 24($sp)
   	sw $s6 28($sp)
   	
   	move $s0 $a0
   	move $s1 $a1
   	move $s2 $a2
   	move $s3 $a3		# r1
   	move $s4 $t0		# r2
   	move $s5 $t1		# c1
   	move $s6 $t2		# c2
   	
   	jal clear_board		# clear the board
   	beq $v0 -1 putRegBack	# check if clearing the board was successful
   	
   	### Put value in r1 & c1
   	move $a0 $s0
   	move $a1 $s1
   	move $a2 $s2
   	move $a3 $s3		# r1
   	
   	addi $sp $sp -8
   	sw $s5 ($sp)		# c1
   	li $t0 2		# the value
   	sw $t0 4($sp)
   	
   	jal place
   	beq $v0 -1 putSPBack	# If return value in invalid for some reason
   	
   	### Put value in r2 & c2
   	move $a0 $s0
   	move $a1 $s1
   	move $a2 $s2
   	move $a3 $s4		# r2
   	
   	sw $s6 ($sp)		# c2
   	li $t0 2		# Don't have to do this but just in case.
   	sw $t0 4($sp)
   	
   	jal place
   	beq $v0 -1 putSPBack	# If return value in invalid for some reason
   	li $v0 0		# Success return 0
   	
   	putSPBack:
   	addi $sp $sp 8
   	putRegBack:
   	lw $s6 28($sp)
   	lw $s5 24($sp)
   	lw $s4 20($sp)
   	lw $s3 16($sp)
   	lw $s2 12($sp)
   	lw $s1 8($sp)
   	lw $s0 4($sp)
   	lw $ra ($sp)
   	addi $sp $sp 32
   	jr $ra
   	
    	invalidSG:
    	li $v0 -1
    	jr $ra

##############################################################
# HOMEWORK 4 PART 2 d
# $a0 = int[][] board		address
# $a1 = int n_rows		num rows in board
# $a2 = int n_cols		num cols in board
# $a3 = int row			row whose cells should be merged
# 0($sp) = int direction	0 -> left to right	1 -> right to left
#
# This function checks if the pass in values are valid. If they are, it store 
# the values and check if 2 adjacent values of the same row is equal. It has 
# 2 for loops (not nested for loops) which checks and replaces the values 
# accordingly using the place function.
##############################################################
merge_row:
    	bltz $a3 invalidRow	# row is neg
    	bge $a3 $a1 invalidRow	# row >= num_rows
    
   	li $t0 2
    	blt $a1 $t0 invalidRow	# num_rows < 2
    	blt $a2 $t0 invalidRow	# num_cols < 2
    
    	lw $t0 ($sp)		# Get the value of direction
    	beqz $t0 mrunal		# direction is valid
    	li $t1 1		# if direction is not 1 & not 0, invalid.
    	bne $t1 $t0 invalidRow	# direction is not 0 nor 1
    	mrunal:
    	
    	addi $sp $sp -24
    	sw $ra ($sp)
    	sw $s0 4($sp)		# Store my argument values just bc
    	sw $s1 8($sp)
    	sw $s2 12($sp)
    	sw $s3 16($sp)
    	sw $s4 20($sp)		# counter
    	
    	move $s0 $a0		# board
	move $s1 $a1		# n_rows
	move $s2 $a2		# n_cols
	move $s3 $a3		# int row
    
	beqz $t0 leftToRightInit
	
	# init values
	addi $s4 $a2 -1		# counter. col - 1
	rightToLeft:
		blez $s4 doneMergeRow	# Stop when s4 = 0. We dont count the last value.
		
		# base address + (i*n_col+j) * size
		mul $t0 $s3 $s2		# i * n_col
		add $t1 $t0 $s4		# i*n_col+j	right value
		sll $t1 $t1 1		# (i*n_col+j)*size
		add $t1 $t1 $s0		# a[i][j] = base address + (i*4+j) * size
		lh $t1 ($t1)		# The value at these two locations
		
		addi $s4 $s4 -1		# previous index. We are moving right to left
		beq $t1 -1 rightToLeft	# We cannot double -1...
		
		add $t0 $t0 $s4		# i*n_col+j	left value
		sll $t0 $t0 1		# (i*n_col+j)*size
		add $t0 $t0 $s0		# a[i][j] = base address + (i*4+j) * size
		lh $t0 ($t0)		# The value at these two locations
		
		bne $t1 $t0 rightToLeft	# Values do not equal
		
		# If the two values are equal double the right
		move $a0 $s0
		move $a1 $s1
		move $a2 $s2
		move $a3 $s3
		addi $t0 $s4 1		# Bc I sub s4 by 1, I have to put it back to get the right index
		addi $sp $sp -8
		sw $t0 0($sp)
		sll $t1 $t1 1		# mul 2
		sw $t1 4($sp)
		
		jal place
		addi $sp $sp 8
		beq $v0 -1 exitMergeRow
		
		# set the left to -1
		move $a0 $s0
		move $a1 $s1
		move $a2 $s2
		move $a3 $s3
		addi $sp $sp -8
		sw $s4 0($sp)		# Bc I sub s4 by 1, this is the left index.
		li $t0 -1
		sw $t0 4($sp)
		
		jal place
		addi $sp $sp 8
		beq $v0 -1 exitMergeRow
		
		addi $s4 $s4 -1
		j rightToLeft
		
	leftToRightInit:
		li $s4 0		# Counter
	leftToRight:
		addi $t0 $s4 1		# the next index of s4
		bge $t0 $s2 doneMergeRow
			
		# base address + (row*n_cols+col) * size
		mul $t0 $s3 $s2		# row*n_cols
		add $t0 $t0 $s4		# row*n_cols+col
		sll $t0 $t0 1		# (row*n_cols+col) * 2 <- 2 is the size
		add $t0 $t0 $s0		# a[i][j] <- the left one
		lh $t0 ($t0)		# element at that index
		
		addi $s4 $s4 1		# col++
		bltz $t0 leftToRight	# if that value is less than 0, we cannot double. value is -1
		
		mul $t1 $s3 $s2		# row*n_cols
		add $t1 $t1 $s4		# row*n_cols+col
		sll $t1 $t1 1		# (row*n_cols+col) * 2 <- 2 is the size
		add $t1 $t1 $s0		# a[i][j] <- the right one
		lh $t1 ($t1)		# element at that value
		
		bne $t0 $t1 leftToRight
		
		move $a0 $s0 
		move $a1 $s1
		move $a2 $s2
		move $a3 $s3
		addi $t1 $s4 -1		# col-1
		addi $sp $sp -8
		sw $t1 0($sp)
		sll $t0 $t0 1		# mul 2
		sw $t0 4($sp)
		
		jal place
		addi $sp $sp 8
		beq $v0 -1 exitMergeRow
		
		move $a0 $s0 
		move $a1 $s1
		move $a2 $s2
		move $a3 $s3
		addi $sp $sp -8
		sw $s4 0($sp)		# Bc I s4 ++, this is the right index.
		li $t0 -1		# Set the right index to -1
		sw $t0 4($sp)
		
		jal place
		addi $sp $sp 8
		beq $v0 -1 exitMergeRow
		
		addi $s4 $s4 1
		j leftToRight
    
    	doneMergeRow:
    	li $v0 0			# Set the return value to 0
    	li $t0 0
    	
    		countRow:
    		beq $t0 $s2 exitMergeRow
    		mul $t1 $s3 $s2		# Row * n_col
    		add $t1 $t1 $t0		# row * n_col + col
    		sll $t1 $t1 1		# mul by size
    		add $t1 $t1 $s0		# index
    		lh $t1 ($t1)		# element
    		
    		addi $t0 $t0 1		# go to next index
    		beq $t1 -1 countRow	# value = -1
    		addi $v0 $v0 1		# counter++ Not -1 so add one
    		j countRow
    		
    	exitMergeRow:			# Should never go here directly.
    	lw $s4 20($sp)
    	lw $s3 16($sp)
    	lw $s2 12($sp)
    	lw $s1 8($sp)
    	lw $s0 4($sp)
    	lw $ra ($sp)
    	addi $sp $sp 24
    	jr $ra
    	invalidRow:
    	li $v0 -1
    	jr $ra

##############################################################
# HOMEWORK 4 PART 2 e
# $a0 = int[][] board		address
# $a1 = int n_rows		num rows in board
# $a2 = int n_cols		num cols in board
# $a3 = int col			col whose cells should be merged
# 0($sp) = int direction	0 -> bottom to top	1 -> top to bottom
#
# This function checks if the pass in values are valid. If they are, it store 
# the values and check if 2 adjacent values of the same col is equal.
#
# If we combined, we go to the next next index. Not point of checking
# the next right? since it is -1
##############################################################
merge_col:
    	bltz $a3 invalidCol	# less than zero out of range
    	bge $a3 $a2 invalidCol	# col >= num_col out of range
    	blt $a1 2 invalidCol	# num_rows < 2
    	blt $a2 2 invalidCol	# num_cols < 2
    	
    	li $t0 0		# index = 0
    	move $v0 $zero		# return value
    	lw $t5 ($sp)		# direction
    	beqz $t5 validDir
    	bne $t5 1 invalidCol	# direction must be 0 or 1
    	validDir:
    	bnez $t5 topToBottom	# equal to zero -> bottomToTop
    	
	addi $t0 $a1 -1		# index = n_row - 1	
    	bottomToTop:
    		blez $t0 checkLastBT
    		# get the bottom value
    		mul $t1 $t0 $a2		# i * n_col
    		add $t1 $t1 $a3		# i * n_col + j
    		sll $t1 $t1 1		# mul 2 <- size
    		add $t1 $t1 $a0		# a[i][j]
		lh $t2 ($t1) 		# element at index
		
		addi $t0 $t0 -1		# index --
		bltz $t2 bottomToTop	# value is -1
		addi $v0 $v0 1		# it's not -1 so add 1. Don't care if it is combined or not.
		
		# get the top value
		mul $t3 $t0 $a2		# i * n_col
    		add $t3 $t3 $a3		# i * n_col + j
    		sll $t3 $t3 1		# mul 2 <- size
    		add $t3 $t3 $a0		# a[i][j]
		lh $t4 ($t3) 		# element at index
		
		bne $t2 $t4 bottomToTop
		sll $t2 $t2 1		# value * 2
		sh $t2 ($t1)		# replace value with double
		li $t4 -1
		sh $t4 ($t3)		# replace top element with -1
		addi $t0 $t0 -1		# Skip the next one. It's -1 so...
		j bottomToTop
    	
    	topToBottom:
    		addi $t3 $a1 -1		# Check to make sure it is not that last element
    		bge $t0 $t3 checkLastTB
    		
    		# top value
    		mul $t1 $t0 $a2		# i * n_col
    		add $t1 $t1 $a3		# i * n_col + j
    		sll $t1 $t1 1		# mul 2 <- size of obj
    		add $t1 $t1 $a0		# a[i][j]
		lh $t3 ($t1) 		# element at index
		
		addi $t0 $t0 1		# index++
		beq $t3 -1 topToBottom	# -1 do nothing.
		addi $v0 $v0 1		# not -1 add one.
		
		# bottom value
		mul $t2 $t0 $a2		# i * n_col
    		add $t2 $t2 $a3		# i * n_col + j
    		sll $t2 $t2 1		# mul 2 <- size of obj
    		add $t2 $t2 $a0		# a[i][j]
		lh $t4 ($t2) 		# element at index
		
		bne $t3 $t4 topToBottom
		sll $t3 $t3 1		# value * 2
		sh $t3 ($t1)		# replace value with double
		li $t3 -1
		sh $t3 ($t2)		# replace bottom index with -1
		addi $t0 $t0 1		# Skip the next one. It's -1 so...
		j topToBottom
		
	checkLastTB:	# Check row-1 index element. Is it -1 or a value?
		addi $t0 $a1 -1
		j sum_Merge_Col
	checkLastBT:	# Check 0 index element.
		li $t0 0
	sum_Merge_Col:
		mul $t1 $t0 $a2		# i * n_col
    		add $t1 $t1 $a3		# i * n_col + j
    		sll $t1 $t1 1		# mul 2 <- size
    		add $t1 $t1 $a0		# a[i][j]
		lh $t1 ($t1) 		# element at index
		
		beq $t1 -1 exit_Merge_Col
		addi $v0 $v0 1		# Count the last value.
		j exit_Merge_Col
    	invalidCol:
    		li $v0 -1
    	exit_Merge_Col:
    		jr $ra

##############################################################
# HOMEWORK 4 PART 2 f
# $a0 = int[][] board		address
# $a1 = int n_rows		num rows in board
# $a2 = int n_cols		num cols in board
# $a3 = int row			row whose cells should be merged
# 0($sp) = int direction	0 -> left	1 -> right
##############################################################
shift_row:
    	bltz $a3 notOkRow	# less than zero out of range
    	bge $a3 $a1 notOkRow	# row >= num_row out of range
    	blt $a1 2 notOkRow	# n_row < 2
    	blt $a2 2 notOkRow	# n_col < 2
    
    	li $v0 0		# return value to 0
    	lw $t1 ($sp)		# direction
    	beqz $t1 dirLeftInit
    	bne $t1 1 notOkRow	# direction not 0 nor 1
    
    	addi $t0 $a2 -2		# Col #num_col-2
    	addi $t1 $a2 -1		# The first place. Is it -1? We don't know yet. #num_col-1
    	dirRight:
    		bltz $t0 exit_Shift_Row
    	
    		mul $t2 $a3 $a2	# i * n_col
    		add $t2 $t2 $t0	# i * n_col + j
    		sll $t2 $t2 1	# mul 2 <- size
    		add $t2 $t2 $a0	# a[i][j]
		lh $t3 ($t2) 	# element at index
	
		addi $t0 $t0 -1		# index--
		bltz $t3 dirRight	# -1 no need to shift
	
	shiftingRight:
	    	beq $t1 $t0 dirRight	# There are no available place to shift.
	    
	    	mul $t4 $a3 $a2		# i * n_col
    	   	add $t4 $t4 $t1		# i * n_col + j
    	    	sll $t4 $t4 1		# mul 2
    	    	add $t4 $t4 $a0		# a[i][j]
	    	lh $t5 ($t4) 		# element at index
	    
	    	addi $t1 $t1 -1		# index-- No -1 found yet.
	    	beq $t5 -1 moveRight	# This location is -1
	    	j shiftingRight
	    
	moveRight:
		li $t6 -1
	    	sh $t6 ($t2)		# -1 at this location
	    	sh $t3 ($t4)		# Move to this location
	    
	    	#sub $t4 $t4 $t2		# End location - start location
	    	#srl $t4 $t4 1		# Getting the amt shifted divide 2 since each is 2 bytes
	    	beq $t4 $t2 dirRight	# If no shifting was done. Then no need to add one to return value.
	    	#add $v0 $v0 $t4
	    	addi $v0 $v0 1		# Otherwise add 1
	    	j dirRight
		
    	dirLeftInit:
    		li $t0 1		# index Col #1
    		move $t1 $0
    	
    	dirLeft:
    	    	beq $t0 $a2 exit_Shift_Row
    	    
    	    	mul $t2 $a3 $a2		# i * n_col
    	    	add $t2 $t2 $t0		# i * n_col + j
    	    	sll $t2 $t2 1		# mul 2
    	    	add $t2 $t2 $a0		# a[i][j]
	    	lh $t3 ($t2) 		# element at index
	    
	    	addi $t0 $t0 1		# i++
	    	bltz $t3 dirLeft	# -1 no need to shift
	
	shiftingLeft:
	    	beq $t1 $t0 dirLeft	# There are no available place to shift.
	    
	    	mul $t4 $a3 $a2		# i * n_col
    	   	add $t4 $t4 $t1		# i * n_col + j
    	    	sll $t4 $t4 1		# mul 2
    	    	add $t4 $t4 $a0		# a[i][j]
	    	lh $t5 ($t4) 		# element at index
	    
	    	addi $t1 $t1 1		# index++ No -1 found yet.
	    	beq $t5 -1 moveLeft	# This location is -1
	    	j shiftingLeft
	    
	moveLeft:
		li $t6 -1
	    	sh $t6 ($t2)		# -1 at this location
	    	sh $t3 ($t4)		# Move to this location
	    
	    	sub $t4 $t0 $t1		# the difference in index
	    	beqz $t4 dirLeft	# If no shifting was done
	    	addi $v0 $v0 1		# Otherwise add 1
	    	#add $v0 $v0 $t4
	    	j dirLeft
    
    notOkRow:
    li $v0 -1
    exit_Shift_Row:
    jr $ra

##############################################################
# HOMEWORK 4 PART 2 g
# $a0 = int[][] board		address
# $a1 = int n_rows		num rows in board
# $a2 = int n_cols		num cols in board
# $a3 = int col			col whose cells should be merged
# 0($sp) = int direction	
##############################################################
shift_col:
    	bltz $a3 notOkCol		# less than zero out of range
    	bge $a3 $a2 notOkCol	# col >= num_col out of range
    	blt $a1 2 notOkCol		# n_row < 2
    	blt $a2 2 notOkCol		# n_col < 2
    
    	lw $t0 ($sp)
    	
    	beqz $t0 validDirection
    	bne $t0 1 notOkCol
    	validDirection:
    
   	addi $sp $sp -28
    	sw $ra ($sp)
    	sw $s0 4($sp)
    	sw $s1 8($sp)
    	sw $s2 12($sp)
    	sw $s3 16($sp)
    	sw $s4 20($sp)
    	sw $s5 24($sp)
    
    	move $s0 $a0
    	move $s1 $a1
    	move $s2 $a2
    	move $s3 $a3
    	li $s5 0			# Return value.
    
    	beqz $t0 dirUpInit
    
    	addi $s4 $s1 -2			# num_rows - 2
   	dirDown:
    		bltz $s4 putStuffBack
    		
    		mul $t1 $s4 $s2		# i * n_col
    	    	add $t1 $t1 $s3		# i * n_col + j
    	    	sll $t1 $t1 1		# mul 2
    	    	add $t1 $t1 $s0		# a[i][j]
	    	lh $t2 ($t1) 		# element at index
    		
    		addi $s4 $s4 -1		# i--
    		beq $t2 -1 dirDown	# Not a value. skip
    		
    		addi $t5 $s1 -1		# num_rows - 1
    	shiftDown:
    		beq $t5 $s4 dirDown
    		
    		mul $t3 $t5 $s2		# i * n_col
    	    	add $t3 $t3 $s3		# i * n_col + j
    	    	sll $t3 $t3 1		# mul 2 <- size of object
    	    	add $t3 $t3 $s0		# a[i][j]
	    	lh $t4 ($t3) 		# element at index
    		
    		addi $t5 $t5 -1		# i--
    		bne $t4 -1 shiftDown
    		
    		#sub $t0 $t5 $s4	# Add the shift amt
    		#add $s5 $s5 $t0
    		addi $s5 $s5 1		# add one. The distance should not be the same
    		
    		move $a0 $s0
    		move $a1 $s1
    		move $a2 $s2
    		
    		addi $a3 $t5 1
    		addi $sp $sp -8
    		sw $s3 0($sp)		# col
    		sw $t2 4($sp)		# value
    		
    		jal place
    		addi $sp $sp 8
    		beq $v0 -1 shouldNeverGoHere
    	    	
    	    	move $a0 $s0
    		move $a1 $s1
    		move $a2 $s2
    		addi $a3 $s4 1
    		addi $sp $sp -8
    		sw $s3 0($sp)
    		li $t0 -1
    		sw $t0 4($sp)
    		
    		jal place
    		addi $sp $sp 8
    		beq $v0 -1 shouldNeverGoHere
    		j dirDown
    		
    	dirUpInit:
    		li $s4 1
   		dirUp:
    			beq $s4 $s1 putStuffBack
    		
    			mul $t1 $s4 $s2		# i * n_col
    	    		add $t1 $t1 $s3		# i * n_col + j
    	    		sll $t1 $t1 1		# mul 2
    	    		add $t1 $t1 $s0		# a[i][j]
	    		lh $t2 ($t1) 		# element at index
    		
    			addi $s4 $s4 1		# i++
    			beq $t2 -1 dirUp	# Not a value. skip
    		
    			li $t5 0
    		shiftUp:
    			beq $t5 $s4 dirUp
    		
    			mul $t3 $t5 $s2		# i * n_col
    	    		add $t3 $t3 $s3		# i * n_col + j
    	    		sll $t3 $t3 1		# mul 2
    	    		add $t3 $t3 $s0		# a[i][j]
	    		lh $t4 ($t3) 		# element at index
    		
    			addi $t5 $t5 1		# i++
    			bne $t4 -1 shiftUp
    		
    			#sub $t0 $s4 $t5	# Distance shifting.
    			#add $s5 $s5 $t0
    			addi $s5 $s5 1		# Add one the distane should not be the same
    		
    			move $a0 $s0
    			move $a1 $s1
    			move $a2 $s2
    			addi $a3 $t5 -1
    			addi $sp $sp -8
    			sw $s3 0($sp)
    			sw $t2 4($sp)
    		
    			jal place
    			addi $sp $sp 8
    			beq $v0 -1 shouldNeverGoHere
    	    	
    	    		move $a0 $s0
    			move $a1 $s1
    			move $a2 $s2
    			addi $a3 $s4 -1
    			addi $sp $sp -8
    			sw $s3 0($sp)
    			li $t0 -1
    			sw $t0 4($sp)
    		
    			jal place
    			addi $sp $sp 8
    			beq $v0 -1 shouldNeverGoHere
    			j dirUp
    	putStuffBack:
    		move $v0 $s5		# My return value. Amt shifted
    	
    		j shouldNeverGoHere	# Only in this case is it valid to go there.
    	notOkCol:
    	li $v0 -1
    	exit_Shift_Col:
    	jr $ra
    	shouldNeverGoHere:
    		lw $s5 24($sp)
    		lw $s4 20($sp)
    		lw $s3 16($sp)
    		lw $s2 12($sp)
    		lw $s1 8($sp)
    		lw $s0 4($sp)
    		lw $ra ($sp)
    		addi $sp $sp 28
    		
    		jr $ra
    		
##############################################################
# HOMEWORK 4 PART 2 h
# $a0 = int[][] board		address
# $a1 = int n_rows		num rows in board
# $a2 = int n_cols		num cols in board
##############################################################
check_state:
	li $t0 0		# Check there are any -1
	li $t1 2048		# is it 2048?
	li $t2 0		# row
	li $t3 0		# col
    	checkWon:
		mul $t4 $t2 $a2		# i * n_col
    		add $t4 $t4 $t3		# i * n_col + j
    		sll $t4 $t4 1		# mul 2
    		add $t4 $t4 $a0		# a[i][j]
		lh $t4 ($t4) 		# element at index
	
		bge $t4 $t1 win		# element is >= 2048
		bne $t4 -1 notNegOne
		addi $t0 $t0 1		# Keeping track if there are any -1
		notNegOne:
			addi $t3 $t3 1	# col++
			bne $t3 $a2 checkWon	# End of col?
			# End of col go to next row
			li $t3 0		# col = 0
			addi $t2 $t2 1		# row ++
			bne $t2 $a1 checkWon
			
	checkLose:
		bgtz $t0 resume		# There are -1 (empty spots) in this board
		li $t0 0		# row
		li $t1 0		# col
		li $t3 -1		# The index value will never be -1.
		
	checkHorizontal:
		mul $t2 $t0 $a2		# i * n_col
    		add $t2 $t2 $t1		# i * n_col + j
    		sll $t2 $t2 1		# mul 2
    		add $t2 $t2 $a0		# a[i][j]
		lh $t2 ($t2) 		# element at index
		
		beq $t2 $t3 resume	# Same so continue game.
		addi $t1 $t1 1		# col ++
		bne $t1 $a2 continue1	# End of col?
		# End of col go to next 
		li $t1 0		# reset col
		addi $t0 $t0 1		# row++
		li $t2 -1		# bc you will be comparing the first value.
		beq $t0 $a1 checkVertical	# end of row. No duplicates found
		
		continue1:
			mul $t3 $t0 $a2		# i * n_col
    			add $t3 $t3 $t1		# i * n_col + j
    			sll $t3 $t3 1		# mul 2
    			add $t3 $t3 $a0		# a[i][j]
			lh $t3 ($t3) 		# element at index
		
			beq $t2 $t3 resume	# Same so continue game.
			addi $t1 $t1 1		# col++
			bne $t1 $a2 checkHorizontal	# End of col?
			# End of col go to next 
			li $t1 0		# reset col
			addi $t0 $t0 1		# row++
			li $t3 -1
			beq $t0 $a1 checkVertical	# end of row. No duplicates found
			j checkHorizontal
		
		checkVertical:	# t0 = row	t1 = 0
			addi $t0 $t0 -1		# Comparing bottom to top. must minus
			bgtz $t0 goOn1		# end row. Go to next col
			
			addi $t0 $a1 -1		# reset to row to bottom
			addi $t1 $t1 1
			beq $t1 $a2 lose	# end of board. No match found
			goOn1:
			
			mul $t2 $t0 $a2		# i * n_col
    			add $t2 $t2 $t1		# i * n_col + j
    			sll $t2 $t2 1		# mul 2
    			add $t2 $t2 $a0		# a[i][j]
			lh $t2 ($t2) 		# element at index
			
			addi $t5 $t0 -1		# The top value
			
			mul $t3 $t5 $a2		# i * n_col
    			add $t3 $t3 $t1		# i * n_col + j
    			sll $t3 $t3 1		# mul 2
    			add $t3 $t3 $a0		# a[i][j]
			lh $t3 ($t3) 		# element at index
			
			beq $t2 $t3 resume	# same found. Resume game
			j checkVertical
	
	win:
		li $v0 1
		jr $ra
	resume:
		li $v0 0
		jr $ra
	lose:
		li $v0 -1
		jr $ra

    		
##############################################################
# HOMEWORK 4 PART 2 i
# $a0 = int[][] board		address
# $a1 = int n_rows		num rows in board
# $a2 = int n_cols		num cols in board
# $a3 = dir			L R U D
##############################################################
user_move:
    addi $sp $sp -20
    sw $ra ($sp)
    sw $a0 4($sp)
    sw $a1 8($sp)
    sw $a2 12($sp)
    sw $s0 16($sp)	# row/col
    
    li $s0 0		# init value
    
    li $t0 'L'
    beq $a3 $t0 userLeft
    
    li $t0 'R'
    beq $a3 $t0 userRight
    
    li $t0 'U'
    beq $a3 $t0 userUp
    
    li $t0 'D'
    beq $a3 $t0 userDown
    j error_User_Move	# dir != LRUD
    
    userLeft:
    	# Shift1
    	move $a3 $s0	# row to check
    	addi $sp $sp -4
    	sw $0 ($sp)	# direction = 0
    	jal shift_row
    	addi $sp $sp 4
    	beq $v0 -1 error_User_Move
    	
    	# Combine
    	lw $a2 12($sp)	# num_col
    	lw $a1 8($sp)	# num_row
    	lw $a0 4($sp)	# board

    	move $a3 $s0
    	addi $sp $sp -4
    	sw $0 ($sp)	# direction = 0
    	jal merge_row
    	addi $sp $sp 4
    	beq $v0 -1 error_User_Move
    	
    	# Shift2
    	lw $a2 12($sp)
    	lw $a1 8($sp)
    	lw $a0 4($sp)

    	move $a3 $s0
    	addi $sp $sp -4
    	sw $0 ($sp)	# direction = 0
    	jal shift_row
    	addi $sp $sp 4
    	beq $v0 -1 error_User_Move
    	
    	# next row
    	addi $s0 $s0 1
    	lw $t0 8($sp)	# num_row
    	beq $s0 $t0 checkBoard
    	j userLeft
    	
    userRight:
    	# Shift1
    	move $a3 $s0	# row to check
    	addi $sp $sp -4
    	li $t0 1	# direction
    	sw $t0 ($sp)	# direction = 1
    	jal shift_row
    	addi $sp $sp 4
    	beq $v0 -1 error_User_Move
    	
    	# Combine
    	lw $a2 12($sp)
    	lw $a1 8($sp)
    	lw $a0 4($sp)

    	move $a3 $s0
    	addi $sp $sp -4
    	li $t0 1	# direction
    	sw $t0 ($sp)	# direction = 1
    	jal merge_row
    	addi $sp $sp 4
    	beq $v0 -1 error_User_Move
    	
    	# Shift2
    	lw $a2 12($sp)
    	lw $a1 8($sp)
    	lw $a0 4($sp)

    	move $a3 $s0
    	addi $sp $sp -4
    	li $t0 1	# direction
    	sw $t0 ($sp)	# direction = 1
    	jal shift_row
    	addi $sp $sp 4
    	beq $v0 -1 error_User_Move
    	
    	# next row
    	addi $s0 $s0 1
    	lw $t0 8($sp)	# num_rows
    	beq $s0 $t0 checkBoard
    	j userRight
    
    userUp:
    	# Shift1
    	move $a3 $s0	# col to check
    	addi $sp $sp -4
    	sw $0 ($sp)	# direction = 0
    	jal shift_col
    	beq $v0 -1 error_User_Move
    	
    	# Combine
    	lw $a2 16($sp)
    	lw $a1 12($sp)
    	lw $a0 8($sp)

    	move $a3 $s0
    	li $t0 1
    	sw $t0 ($sp)	# direction = 1
    	jal merge_col
    	beq $v0 -1 error_User_Move
    	
    	# Shift2
    	lw $a2 16($sp)
    	lw $a1 12($sp)
    	lw $a0 8($sp)

    	move $a3 $s0
    	sw $0 ($sp)	# direction = 0
    	jal shift_col
    	addi $sp $sp 4
    	beq $v0 -1 error_User_Move
    	
    	# next col
    	addi $s0 $s0 1
    	lw $t0 12($sp)	# num_cols
    	beq $s0 $t0 checkBoard
    	j userUp
    	
    userDown:
    	# Shift1
    	move $a3 $s0	# col to check
    	addi $sp $sp -4
    	li $t0 1	# direction
    	sw $t0 ($sp)	# direction = 1
    	jal shift_col
    	beq $v0 -1 error_User_Move
    	
    	# Combine
    	lw $a2 16($sp)
    	lw $a1 12($sp)
    	lw $a0 8($sp)

    	move $a3 $s0
    	sw $0 ($sp)	# direction = 0
    	jal merge_col
    	beq $v0 -1 error_User_Move
    	
    	# Shift2
    	lw $a2 16($sp)
    	lw $a1 12($sp)
    	lw $a0 8($sp)

    	move $a3 $s0
    	li $t0 1	# direction
    	sw $t0 ($sp)	# direction = 1
    	jal shift_col
    	addi $sp $sp 4
    	beq $v0 -1 error_User_Move
    	
    	# next col
    	addi $s0 $s0 1
    	lw $t0 12($sp)	# num_cols
    	beq $s0 $t0 checkBoard
    	j userDown
    
    checkBoard:
    	lw $a2 12($sp)
    	lw $a1 8($sp)
    	lw $a0 4($sp)
    	jal check_state
    	move $v1 $v0	# The result.
    	li $v0 0
    	j exit_User_Move
    error_User_Move:
    	li $v0 -1
    	li $v1 -1
    exit_User_Move:
    	lw $s0 16($sp)
  	lw $ra ($sp)
    	addi $sp $sp 20
    	jr $ra


#################################################################
# Student defined data section
#################################################################
.data
.align 2  # Align next items to word boundary

#place all data declarations here


