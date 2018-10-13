##############################################################
# Homework #3
# name: Fanng Dai
# sbuid:
##############################################################
.text

##############################################################
# HOMEWORK 2 PART 1 FUNCTIONS
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
		li $v0 -1	# return -1
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
# HOMEWORK 2 PART 2 FUNCTIONS
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
    		li $v0 -1		# Error return -1
    		sub $v1 $a1 $s1		# Calculate the difference of n and the amt we dealt with
    	exitExtractData:
    		move $a0 $t5		# Move $a0 back to pointing at beginning of msg
    		move $a2 $t6		# Move $a2 back to pointing at beginning of parray
    		lw $ra ($sp)		# Put pointer back
    		lw $s0 4($sp)
    		lw $s1 8($sp)
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
# HOMEWORK 2 PART 3 FUNCTIONS
##############################################################

printDatagram:
	blez $a1 exitFinally

    	addi $sp $sp -12
    	sw $ra ($sp)	# Store the address because we gunna call functions
    	sw $s0 4($sp)	# Store the save registers because we going to use it
    	sw $s1 8($sp)

    	move $s0 $a2	# byte[] msg
    	move $s1 $a3	# String[] sarray

   	# Because it was passed in, a0-a2 are where they belong
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

##############################################################
# HOMEWORK 3 PART A
# returns (0, M+1) upon success, (-1, k) upon failure.
##############################################################
extractUnorderedData:
	li $t0 1			# n < 1
	blt $a1 $t0 errorNoStack

	addi $sp $sp -24
	sw $ra ($sp)
	sw $s0 4($sp)			# s0-s4 used to store argument values
	sw $s1 8($sp)
	sw $s2 12($sp)
	sw $s3 16($sp)
	sw $s4 20($sp)			# i, the counter

	move $s0 $a0			# Packet[] parray 	starting address of the 1D array of unordered IPv4 packet(s)
	move $s1 $a1			# int n			number of packets in parray
	move $s2 $a2			# byte[] msg 		starting address of the 1D array of bytes for the msg
	move $s3 $a3			# packetentrysize	the number of bytes for each parray entry
	move $s4 $zero			# i, the counter

	checkSumValid:
		#Check sum
		mul $t0 $s4 $s3			# t0 = distance from packet
		add $t0 $t0 $s0			# location of parray that we want.
		move $a0 $t0
		jal verifyIPv4Checksum		# Return 0 if valid, value calculated o.w.
		bnez $v0 errorEUD

		# total length of packet > packet entry size
		mul $t0 $s4 $s3			# t0 = distance from packet
		add $t0 $t0 $s0			# t0 = location of parray that we want
		lhu $t2 ($t0)			# t2 = total length
		bgt $t2 $s3 errorEUD		# Check total length of packet > packet entry size

		addi $s4 $s4 1			# i++
		bne $s4 $s1 checkSumValid

	# Preparing values for flagValid
	move $s4 $s0		# location of packet[i]
	move $t0 $0		# reset the counter to zero
	li $t5 1		# beginning. minus one everytime found
	li $t6 1		# last. minus one everytime found

	flagValid:
		beq $t0 $s1 oneBegAndLast	# End of loop.

		lbu $t1 5($s4)			# t1 = Get flags value
		srl $t1 $t1 5
		lhu $t2 4($s4)			# t2 = Get fragment offset
		andi $t2 $t2 0x1FFF

		beq $s1 0x1 nEqualOne		# n = 1. Only one element in parray.

		# Making sure that flags value is always 0,2 or 4
		beq $t1 0x0 validFlag
		beq $t1 0x2 validFlag
		beq $t1 0x4 validFlag
		j invalidEUD
		validFlag:

		# Check for beginning
		bne $t1 0x4 notBeginning
		# You are here bc flags = 100
		bnez $t2 notBeginning		# fragmentoffset = 0?
		# You are here bc you are at beginning
		addi $t5 $t5 -1			# minus 1. You should be at zero.
		bnez $t5 invalidEUD		# There are more than 1 beginning
		j doneCheck			# You found beginning

		notBeginning:			# Check for last
		bnez $t1 notLast		# flag = 0?
		# You are here bc flags = 000
		beqz $t2 notLast		# fragment = 0?
		# You are here bc you are at last packet
		addi $t6 $t6 -1
		bnez $t6 invalidEUD
		j doneCheck
		notLast:

		bne $t1 0 doneCheck		# n!=1 but, flag = 0, is not last nor the only packet.
		beq $t2 0 invalidEUD

		doneCheck:
		beq $t1 0x2 invalidEUD		# n!=1 & flags = 010
		addi $t0 $t0 1			# i++
		add $s4 $s4 $s3			# Go to next packet
		j flagValid

	nEqualOne:
		beq $t1 0x4 invalidEUD
		bnez $t1 initVal
		# You are here bc flags = 000
		bnez $t2 invalidEUD	#fragment offset != 0
		j initVal		# n=1 flag & fragment values correct

	# Check to make sure there was at least one beginning and end.
	# After, set v1 our return value to zero
	oneBegAndLast:
		bnez $t5 invalidEUD	# Had exaclty one beginning
		bnez $t6 invalidEUD	# Had exactly one end
		# I know I do not have jump. It have to continue to initVal.
	initVal:
		li $v1 0		# set the return value to zero
		# make sure they are 0
		li $t5 0
		li $t6 0
		j storeInMSG

	storeInMSG:			# Store payload into MSG
		beqz $s1 sucessEUD	# finish all packets. exit
		addi $s1 $s1 -1		# n--

		lbu $t0 5($s0)		# t0 = flag
		srl $t0 $t0 5		# isolate flag
		lhu $t1 4($s0)		# t1 = flagment Offset
		andi $t1 $t1 0x1FFF	# Isolate fragment Offset
		lbu $t2 ($s0)		# t2 = total length for now

		lbu $t3 3($s0)		# header length
		andi $t3 $t3 0xF	# isolate header length
		sll $t3 $t3 2		# header length *4
		sub $t2 $t2 $t3		# payload size = total length - (4 * header length)
		add $t3 $t3 $s0		# s0 = parray[index]	t3 = header size

		beq $t0 0x2 storeAtZero	# flag = 010

		flagEqualZeroOrFour:	# flags = 000 or 100
			beq $t1 $0 storeAtZero
			# otherwise, store at fragmentOffset
		storeAtFragmentOffset:
			add $t4 $t1 $s2	# beginning location of msg[fragmentOffset] freagmentOffset*4 + msg
			j loopAddToMsg
		storeAtZero:
			move $t4 $s2	# beginning of msg (address)

		# t2 = payload size (amt times to loop)
		# t3 = beginning of payload (address)
		# t4 = beginning of msg to store (address)
		loopAddToMsg:
			beqz $t2 endLoopAddToMsg	# payload size = 0? end loop?
			lbu $t5 ($t3)			# Get the byte value in t3
			sb $t5 ($t4)			# store by byte
			addi $t3 $t3 1			# Next payload byte
			addi $t4 $t4 1			# Next byte in msg
			addi $t2 $t2 -1			# payload size--
			j loopAddToMsg

		endLoopAddToMsg:
			sub $t4 $t4 $s2			# location of msg and the beginning of msg
			sgt $t5 $t4 $v1			# check if return value is less. t5 = 1 if t4>v1.
			beqz $t5 notGreaterThan		# we only want the case when t4 > v1. -> t5 = 1
			# You are here bc t4 > v1. v1 = t4
			move $v1 $t4			# v1 = the greater value.
			notGreaterThan:

			add $s0 $s0 $s3			# next packet. parray[i++]
			j storeInMSG

	invalidEUD:			# returns -1, -1
		li $v0 -1
		li $v1 -1
		j exitEUD
	errorEUD:			# returns -1, k
		li $v0 -1
		move $v1 $s4
		j exitEUD
	sucessEUD:			# returns 0, M+1
#		lbu $t0 ($s2)		# The initial index of msg
#		sub $v1 $v1 $t0		# Get the distance from end value and msg
		li $v0 0
	exitEUD:
		lw $s4 20($sp)
		lw $s3 16($sp)
		lw $s2 12($sp)
		lw $s1 8($sp)
		lw $s0 4($sp)
		lw $ra ($sp)
		addi $sp $sp 24
		jr $ra
	errorNoStack:
		li $v0 -1
		li $v1 -1
		jr $ra

##############################################################
# HOMEWORK 3 PART B
##############################################################
printUnorderedDatagram:
	blez $a1 exitFinallyPUD
	lw $t0 ($sp)	# The packetentrysize

    	addi $sp $sp -12
    	sw $ra ($sp)	# Store the address because we gunna call functions
    	sw $s0 4($sp)	# Store the save registers because we going to use it
    	sw $s1 8($sp)

    	move $s0 $a2	# byte[] msg
    	move $s1 $a3	# String[] sarray

    	move $a3 $t0	# move the packetentrysize to argument
    	jal extractUnorderedData
    	# v0: checksum valid
    	# v1: size of payload
    	bnez $v0 failurePUD

    	# Success with checkSum
    	move $a0 $s0
    	move $a1 $v1 		# v1 is the total amt of bytes stored
    	move $a2 $s1
    	jal processDatagram
    	li $t0 -1		# if it equals -1
    	beq $v0 $t0 failurePUD    	# v0 = amt of \0

    	addi $t0 $v0 -1

    	move $a0 $s1		# s1 = sarray
    	move $a1 $0		# Start at zero
    	move $a2 $t0		# \n
    	move $a3 $v0		# The amt processDatagram returned
    	jal printStringArray
    	li $t0 -1		# if it equals -1
    	beq $v0 $t0 failurePUD  # v0 = amt of \0

    	li $v0 0		# Everything was good. return 0

    	lw $s1 8($sp)
    	lw $s0 4($sp)
    	lw $ra ($sp)
    	addi $sp $sp 12

	j exitFinallyPUD

    failurePUD:
    	lw $s1 8($sp)
    	lw $s0 4($sp)
    	lw $ra ($sp)
    	addi $sp $sp 12
    	li $v0 -1	# return -1 b/c somewhere failed
    exitFinallyPUD:
    	jr $ra

##############################################################
# HOMEWORK 3 PART C
# a0 = str1: String 	starting address of the first string
# a1 = str2: String	starting address of the second string
# a2 = m: int		length of str1
# a3 = n: int		length of str2
##############################################################
editDistance:

	bltz $a2 returnNegOne	# m<0
	bltz $a3 returnNegOne	# n<0

	addi $sp $sp -20
	sw $ra ($sp)		# store register
	sw $s0 4($sp)
	sw $s1 8($sp)
	sw $s2 12($sp)
	sw $s3 16($sp)

	move $s0 $a0
	move $s1 $a1
	move $s2 $a2
	move $s3 $a3

	################PRINT
	li $a0 'm'
	li $v0 11
	syscall

	li $a0 ':'
	li $v0 11
	syscall

	move $a0 $s2	# Value of m
	li $v0 1
	syscall

	li $a0 ','
	li $v0 11
	syscall

	li $a0 'n'
	li $v0 11
	syscall

	li $a0 ':'
	li $v0 11
	syscall

	move $a0 $s3	# value of n
	li $v0 1
	syscall

	li $a0 '\n'
	li $v0 11
	syscall
	################PRINT END

	bnez $s2 checkN		# m==0
	move $v0 $s3		# return n
	j exitED

	checkN:
	bnez $s3 valNotZero	# n==0
	move $v0 $s2		# return m
	j exitED

	valNotZero:
		addi $t0 $s2 -1	# m-1
		move $t1 $s0	# str1
		addi $t2 $s3 -1 # n-1
		move $t3 $s1	# str2

		getM:			# Get the value of str1.charAt(m-1)
			beqz $t0 getN	# Return
			addi $t0 $t0 -1	# m--
			addi $t1 $t1 1	# Next char in str1
		j getM

		getN:
			beqz $t2 sameC	# Return
			addi $t2 $t2 -1	# n--
			addi $t3 $t3 1	# Next char in str2
		j getN

		sameC:			# if(str1.charAt(m-1) == str2.charAt(n-1))
			lbu $t0 ($t1)	# t0 = str1.charAt(m-1)
			lbu $t1 ($t3)	# t1 = str2.charAt(n-1)
			bne $t0 $t1 notSameC
			move $a0 $s0	# return str1
			move $a1 $s1	# return str2
			addi $a2 $s2 -1	# return m-1
			addi $a3 $s3 -1	# return n-1
			jal editDistance
			j exitED	# return
		notSameC:
			addi $sp $sp -8
			sw $s4 ($sp)
			sw $s5 4($sp)

			move $a0 $s0	#editDistance(str1, str2,m,n-1)
			move $a1 $s1
			move $a2 $s2
			addi $a3 $s3 -1
			jal editDistance
			move $s4 $v0

			move $a0 $s0	#editDistance(str1, str2,m-1,n)
			move $a1 $s1
			addi $a2 $s2 -1
			move $a3 $s3
			jal editDistance
			move $s5 $v0

			move $a0 $s0	#editDistance(str1, str2,m-1,n-1)
			move $a1 $s1
			addi $a2 $s2 -1
			addi $a3 $s3 -1
			jal editDistance

			# Save everything so we can use
			move $t0 $s4	# insert
			move $t1 $s5	# remove
			move $t2 $v0 	# replace

			lw $s5 4($sp)	# Put stack back to location
			lw $s4 ($sp)
			addi $sp $sp 8

			blt $t1 $t2 iWantToSleep
			move $t1 $t2	# t2 > t1 set smaller to t1
			iWantToSleep:	# $t1 is less. leave
			blt $t0 $t1 degreesTho
			move $t0 $t1	# t1 > t0 set smaller to t0
			degreesTho:
			addi $v0 $t0 1	# 1 + min(insert, min(remove, replace))
			j exitED

	returnNegOne:
		li $v0 -1
		jr $ra

	exitED:
		lw $s3 16($sp)
		lw $s2 12($sp)
		lw $s1 8($sp)
		lw $s0 4($sp)
		lw $ra ($sp)
		addi $sp $sp 20
		jr $ra		# You can either be leaving somewhere mid or the function. Who knows?

#################################################################
# Student defined data section
#################################################################
.data
.align 2  # Align next items to word boundary

#place all data declarations here
