
##############################################################
# Homework #2
# name: Fanng Dai
# sbuid: 109684495
##############################################################
.text

##############################################################
# PART 1 FUNCTIONS
##############################################################

replace1st: 					# $a1 = look for  $a2 = replace with
	blt $a1 0x00 rangeNotValid		# toReplace less than 0x00
	blt $a2 0x00 rangeNotValid		# toReplace less than 0x00
	bgt $a1 0x7F rangeNotValid		# replaceWith greater than 0x7F
	bgt $a2 0x7F rangeNotValid		# replaceWith greater than 0x7F
	lookForLetter:
		lbu $t0 ($a0)			# Get char
		beq $t0 $a1 equal		# t0 the char we looking for?
		beqz $t0 notFound		# end of string
		addi $a0 $a0 1			# i++. Next address of string
		j lookForLetter
	equal:
		sb $a2 ($a0)	# position = letter
		addi $a0 $a0 1	# The next address
		move $v0 $a0	# return the address at which it was found
		j leaveReplace1st
	notFound:
		li $v0 0	# return 0
		j leaveReplace1st
	rangeNotValid:
		li $v0 -1	# return 1
	leaveReplace1st:
		jr $ra

printStringArray:
	blt $a3 1 errorPassIn	# Length is less than 1
    	blt $a1 0 errorPassIn	# startIndex < 0
    	blt $a2 0 errorPassIn	# endIndex < 0
    	bge $a1 $a3 errorPassIn	# startIndex >= length
    	bge $a2 $a3 errorPassIn	# endIndex >= length
    	blt $a2 $a1 errorPassIn	# endIndex is less than startIndex
    	move $t5 $a0		# Save it
    
    	move $t0 $a1		# Start Index
    	#sll $t1 $t0 2		# startIndex mul by 4. Get the beginning address
    	#add $t1 $t0 $a0	# Get to the index sarray[i]
    	li $t2 0		# Counter
		
    	printString:
        	bgt $t0 $a2 donePrintingString	# startIndex > endIndex? Exit
		
		addi $t2 $t2 1	# counter++
		sll $t3 $t0 2	# Get the next word. Progressing
    		add $t1 $t3 $t5	# Get sarray[i]
    		addi $t0 $t0 1	# i++ (start index)
    		
    		lw $a0 ($t1)	# Get the next word
    		li $v0 4	# Print string
    		syscall
    	
    		li $a0 '\n'	# Print new line
		li $v0 11
		syscall

		li $a0 '\n'	# Print new line
		li $v0 11
		syscall
	
    		j printString
    	
    	donePrintingString:
    		move $a0 $t5		# move the array back
    		move $v0 $t2		# The amount of string printed
    		j leavePrintStringArray
    	errorPassIn:
    		li $v0 -1		# Error return -1
    	leavePrintStringArray:
    		jr $ra

verifyIPv4Checksum:
	lbu $t0 3($a0)		# Get the byte with the header length
	andi $t0 $t0 0xF	# Get the header length
	sll $t0 $t0 1		# Header length * 2 b/c headerlength = word. Dealing with halfword
	
	move $t1 $a0		# Move the header so don't modify
	li $t3 0		# Set checkSum = 0
	
	addHeader:
		lhu $t2 0($t1)		# load the half word in header
		beqz $t0 endAddHeader	# Header length = 0?
		addi $t0 $t0 -1		# decrement so we can end loop
		addi $t1 $t1 2 		# Next half word
		add $t3 $t3 $t2		# sum of all half word in header = $t3
		j addHeader
	endAddHeader:
	
	li $t0 0x10000	# checker
	sumChecksum:
		blt $t3 $t0 endChecksum		# t3 = halfword?
		srl $t2 $t3 16			# Get the higher
		sll $t3 $t3 16			# Get the lower
		srl $t3 $t3 16			# Get the lower continued
		add $t3 $t3 $t2			# Add the hi + lo
		j sumChecksum
	endChecksum:		# $t3 is now half word size

	xori $t3 $t3 0xFFFF	# One's complement
	
	beqz $t3 checkSumEqual	# checksum equal?
	move $v0 $t3		# Return the checksum I calculated
	j exitCheckSum
	
	checkSumEqual:
	li $v0 0	# No error return 0
	exitCheckSum:
    	jr $ra

##############################################################
# PART 2 FUNCTIONS
##############################################################

extractData:
	addi $sp $sp -24
	sw $ra ($sp)	# Store the return address cause we gunna call another function
	sw $s0 4($sp)	# whatever was in $s0 must stay
	sw $s1 8($sp)	# Using this as counter so must be saved
	
	sw $a0 12($sp)	# Don't want to lose these
	sw $a1 16($sp)
	sw $a2 20($sp)
	move $s0 $a0	# array[0] address
	move $s1 $a1	# The amt of array we have. A value

	checkingSumValid:
		beqz $s1 checkingSumValidPass
		jal verifyIPv4Checksum
		bnez $v0 errorWithCheckSum
		addi $s0 $s0 60 # 60 + i = where the array[i] is located
		move $a0 $s0	# 
		addi $s1 $s1 -1	# i++
	j checkingSumValid
	
	checkingSumValidPass:
	
	lw $a2 20($sp) # Retrieve the info
	lw $a1 16($sp)
	lw $a0 12($sp)
	
	li $v1 0	# Counter of bytes in payload stored to msg
	li $t1 0	# i. The location of the array
	move $t0 $a0	# Do not want to modify
	move $t5 $a0	# The beginning address of parray
	move $t6 $a2	# The beginning address of msg.
	
	arrayCounter:
		beq $t1 $a1 extractDataSuccess	# end of array?
		
		# It should be 20 but. Doing it for fun.
    		lbu $t2 3($t0)			# Get the 3rd byte which contains header length
    		andi $t2 $t2 0X0F		# Isolate the header length
    		sll $t2 $t2 2			# Header length * 4 = header size

		lhu $t3 ($t0)			# total length
    		li $t4 60			# Size of the array
    		sub $t4 $t4 $t3			# The amt of space not used in array
    		sub $t3 $t3 $t2			# total length - header length = payload size
		
		removeHeader:
			beqz $t2 loadPayloadMsg	# End of header
			addi $t0 $t0 4		# Next WRORD. t0 is the address so add
			addi $t2 $t2 -4		# skip word
		j removeHeader
		
		loadPayloadMsg:
			beqz $t3 goToNextArray	# payload done
			lbu $t2 ($t0)		# Get the byte at the array
			sb $t2 ($a2)		# Put into msg
			addi $a2 $a2 1		# Next address in msg
			addi $v1 $v1 1		# Adding up the bytes we store in msg
			addi $t0 $t0 1		# Next byte address in array
			addi $t3 $t3 -1		# payload -= 1
		j loadPayloadMsg
		
		goToNextArray:
			beqz $t4 doneWithArrayPosition
			addi $t4 $t4 -1		# The amt of useless bytes left
			addi $t0 $t0 1		# Go to next byte
		j goToNextArray
		
		doneWithArrayPosition:
			addi $t1 $t1 1		# The next array
			
	j arrayCounter
    	
    	# EXIT
    	extractDataSuccess:
    		li $v0 0		# Success. Return 0
    		j exitExtractData
    	errorWithCheckSum:
    		# Just in case, I am putting them back. But can delete if really want to
	#	lw $a0 12($sp)	# Not put back because up part is only if all checksum pass
	#	lw $a1 16($sp)	# Put them back
	#	lw $a2 20($sp)	# Retrieve the info
	
    		li $v0 -1		# Error return -1
    		sub $v1 $a1 $s1		# Calculate the difference of n and the amt we dealt with
    	exitExtractData:
    		move $a0 $t5		# Move $a0 back to pointing at beginning of msg
    		move $a2 $t6		# Move $a2 back to pointing at beginning of parray
    		lw $ra ($sp)		# Put pointer back
    		lw $s0 4($sp)
    		lw $s1 8($sp)
    		# Note I put $a0 back towards the beginning of the code after calling function
    		addi $sp $sp 24		# Put the stack pointer back to where it belongs
    		jr $ra

processDatagram:
	blez $a1 notValidBytes		# M <= 0, M = total number of bytes stored in msg
	
	addi $sp $sp -16
	sw $ra ($sp)	# Will be calling another function
	sw $s0 4($sp)	# Use to store msg
	sw $s1 8($sp)	# Use to store sarray
	sw $s2 12($sp)	# msg + m
	
	move $s0 $a0	# msg = array of bytes
	move $s1 $a2	# sarray = starting address of the array to hold the addresses of 
	
	sw $a0 ($s1)	# Put the address into sarray
	addi $s1 $s1 4	# Go to next word address
	
	move $s2 $s0	# The address of msg
	add $s2 $s2 $a1	# msg + m = the location where you CANNOT store no address into msg
		
	li $t0 '\0'	# My null byte
	move $t1 $s0	# The string address
	goToM:
		beqz $a1 replaceWithNull
		addi $a1 $a1 -1 # Sub 1 next byte in string
		addi $t1 $t1 1	# Next char
	j goToM
	
	replaceWithNull:
		sb $t0 ($t1)	# Replace that location with null char

		move $v0 $s0 		# To the beginning pointer of the string
		li $s0 1		# Now s0 is a counter
		
	changeBytes:
		move $a0 $v0	# Get the word address. Start at the last string location if one was found
		li $a1, '\n'	# Look for
		li $a2,	'\0'	# Replace with
		jal replace1st	# Check only if that char matches
		
		beqz $v0 processDatagramSuccess	# That char is not "\n"
		beq $v0 $s2 processDatagramSuccess	# There was a "\n" found at position msg + m. Do not store. We done.
		sw $v0 ($s1)			# If found, store the address into s2
		addi $s1 $s1 4			# s1 = a2 = sarray. Go to next because this space used
		addi $s0 $s0 1			# counter++
	j changeBytes
	
	processDatagramSuccess:
		move $v0 $s0	# The return value. Amt \n found and replaced
		lw $s2 12($sp)	
		lw $s1 8($sp)	# Put the values back
		lw $s0 4($sp)
		lw $ra ($sp)
		addi $sp $sp 16
	j exitProcessDatagram
	notValidBytes:
		li $v0 -1	# Return -1 if M <= 0
	exitProcessDatagram:
    		jr $ra

##############################################################
# PART 3 FUNCTIONS
##############################################################

printDatagram:
	blez $a1 exitFinally
	
    	addi $sp $sp -12
    	sw $ra ($sp)	# Store the address because we gunna call functions
    	sw $s0 4($sp)	# Store the save registers because we going to use it
    	sw $s1 8($sp)
    
    	move $s0 $a2	# byte[] msg
    	move $s1 $a3	# String[] sarray
    
   	# Because it was passed in, a0-a3 are where they belong
    	jal extractData
    	# v0: checksum valid
    	# v1: size of payload
    	bnez $v0 failure
    
    	# Success with checkSum
    	move $a0 $s0
    	move $a1 $v1 		# v1 is the total amt of bytes stored
    	move $a2 $s1
    	jal processDatagram
    	li $t0 -1		# if it equals -1
    	beq $v0 $t0 failure    	# v0 = amt of \0
    
    	addi $t0 $v0 -1	
    	
    	move $a0 $s1		# s1 = sarray
    	move $a1 $0		# Start at zero
    	move $a2 $t0		# \n
    	move $a3 $v0		# The amt processDatagram returned
    	jal printStringArray
    	li $t0 -1		# if it equals -1
    	beq $v0 $t0 failure    	# v0 = amt of \0
    
    	li $v0 0		# Everything was good. return 0
    
    	lw $s1 8($sp)
    	lw $s0 4($sp)
    	lw $ra ($sp)
    	addi $sp $sp 12
    	
    j exitFinally
    
    failure:
    	lw $s1 8($sp)
    	lw $s0 4($sp)
    	lw $ra ($sp)
    	addi $sp $sp 12
    	li $v0 -1	# return -1 b/c somewhere failed
    exitFinally:
    	jr $ra

#################################################################
# Student defined data section
#################################################################
.data
.align 2  # Align next items to word boundary

#place all data declarations here
