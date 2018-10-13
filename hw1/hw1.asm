# Homework #1
# Name: Fanng Dai
# Net ID: Fdai
# SBU ID:
#########################################################
# Prof code start
#########################################################
.include "Header3.asm"	# change this line to test with other inputs

.data
	ipv: .asciiz "IPv"
	unsupported: .asciiz "Unsupported:"

.align 2
	numargs: .word 0
	AddressOfIPDest3: .word 0
	AddressOfIPDest2: .word 0
	AddressOfIPDest1: .word 0
	AddressOfIPDest0: .word 0
	AddressOfBytesSent: .word 0
	AddressOfPayload: .word 0

	Err_string: .asciiz "ERROR\n"
	newline: .asciiz "\n"

# Helper macro for  accessing command line arguments via Label
.macro load_args
	sw $a0, numargs
	lw $t0, 0($a1)
	sw $t0, AddressOfIPDest3
	lw $t0, 4($a1)
	sw $t0, AddressOfIPDest2
	lw $t0, 8($a1)
	sw $t0, AddressOfIPDest1
	lw $t0, 12($a1)
	sw $t0, AddressOfIPDest0
	lw $t0, 16($a1)
	sw $t0, AddressOfBytesSent
	lw $t0, 20($a1)
	sw $t0, AddressOfPayload
.end_macro

.text
.globl main
main:
	load_args()	# Only do this once

#########################################################
# My code start. Part 1. Check passed in args valid
#########################################################

	li $t0 6		# If numargs does not equal 6. $t1 = numargs
	lw $t1 numargs
	bne $t0 $t1 error

	li $t2 255		# $t2 = 255

	lw $a0 AddressOfIPDest3	# Check if IPDest3 is integer.
	li $v0 84		# calls the atoi
	syscall
	move $s3 $v0
	bne $0 $v1 error	# Integer?
	blt $s3 $0 error	# IPDest3 negative?
	bgt $s3 $t2 error	# IPDest3 > 255?

	lw $a0 AddressOfIPDest2	# Check if IPDest2 is integer.
	li $v0 84		# calls the atoi
	syscall
	move $s2 $v0
	bne $0 $v1 error	# Integer?
	blt $s2 $0 error	# IPDest2 negative?
	bgt $s2 $t2 error	# IPDest2 > 255?

	lw $a0 AddressOfIPDest1	# Check if IPDest1 is integer.
	li $v0 84		# calls the atoi
	syscall
	move $s1 $v0		# Move the value to $s1
	bne $0 $v1 error	# Integer?
	blt $s1 $0 error	# IPDest1 negative?
	bgt $s1 $t2 error	# IPDest1 > 255?

	lw $a0 AddressOfIPDest0	# Check if IPDest0 is integer.
	li $v0 84		# calls the atoi
	syscall
	move $s0 $v0		# Move the value to $v0
	bne $0 $v1 error	# Integer?
	blt $s0 $0 error	# IPDest0 negative?
	bgt $s0 $t2 error	# IPDest0 > 255?

	lw $a0 AddressOfBytesSent	# Check if bytesSent is integer. $s4 = bytesSent
	li $v0 84		# Calls the atoi
	syscall
	move $s4 $v0 		# $s4 = $v0 We need this for 2.6
	bne $0 $v1 error	# Integer?
	li $t2 8191		# $t2 = 8191
	bgt $s4 $t2 error	# bytesSent > 8191?
	li $t2 -1		# $t2 = -1
	blt $s4 $t2 error	# bytesSent < -1?
	beq $s4 $t2 skipDivBy8	# bytesSent = -1? No need to see if multiple of 8

	li $t2 8		# $t2 = 0
	div $s4 $t2		# bytesSent / 8
	mfhi $t1		# Store the remainder
	bnez $t1 error		# Check if the remainder = 0 or not

	skipDivBy8:		# Continue the code if all is good

#########################################################
# Part 2.1 of hw
# Take the header only byte 3. If it is 4, skip changing it
# If it is not, change it. But store the change somewhere else.
# Then both will print IPv# of original.
#########################################################

	la $t0 Header		# Load the Header
	lbu $t1 3($t0)		# Load the byte 3 = $t1
	srl $t1 $t1 4		# shift to get version = $t2

	li $t2 4		# Check if that byte is 4
	beq $t2 $t1 skipPrintUnsupported

	li $v0 4		# Print "Unsupported"
	la $a0 unsupported
	syscall

	skipPrintUnsupported:

	li $v0 4		# Print "IPv"
	la $a0 ipv
	syscall

	li $v0 1		# Print the number stored in $t1
	move $a0 $t1
	syscall

	li $v0 4		# Print the next line
	la $a0 newline
	syscall

	# Change the upper byte to equal 4
	lbu $t1 3($t0)		# load byte 3
	# Replace version with 4
	andi $t2 $t1 0x0F	# Get the lower bits
	ori $t2 $t2 0x40	# Change the higher bits to 4
	sb $t2 3($t0)		# Store altered bytes

#########################################################
# Part 2.2 of hw
#########################################################

	li $v0 1		# Print Type of Service
	lbu $a0 2($t0)
	syscall

	li $a0 ','		# Print comma
	li $v0 11
	syscall

	lhu $a0 6($t0)		# Print Identifier
	li $v0 1
	syscall

	li $v0 11		# Print comma
	li $a0 ','
	syscall

	li $v0 1		# Print Time to Live
	lbu $a0 11($t0)
	syscall

	li $v0 11		# Print comma
	li $a0 ','
	syscall

	li $v0 1		# Print Protocol
	lbu $a0 10($t0)
	syscall

	li $v0 4		# Print the next line
	la $a0 newline
	syscall

#########################################################
# Part 2.3 & 2.4 of hw
#########################################################

	lbu $a0 15($t0)		# Load IPSrc3 to argument
	li $v0 1
	syscall

	li $v0 11		# Print period
	li $a0 '.'
	syscall

	lbu $a0 14($t0)		# Load IPSrc2 to argument
	li $v0 1
	syscall

	li $v0 11		# Print period
	li $a0 '.'
	syscall

	lbu $a0 13($t0)		# Load IPSrc1 to argument
	li $v0 1
	syscall

	li $v0 11		# Print period
	li $a0 '.'
	syscall

	lbu $a0 12($t0)		# Load IPSrc0 to argument
	li $v0 1
	syscall

	li $v0 4		#Print the next line
	la $a0 newline
	syscall

	sb $s3 19($t0)		# Store IPDest3 to Destination IP Address
	sb $s2 18($t0)		# Store IPDest2 to Destination IP Address
	sb $s1 17($t0)		# Store IPDest1 to Destination IP Address
	sb $s0 16($t0)		# Store IPDest0 to Destination IP Address

	lw $a0 16($t0)		# Retrieve the data from the header
	li $v0 34		# Print the Destination IP Address
	syscall

	li $v0 4		#Print the next line
	la $a0 newline
	syscall

#########################################################
# Part 2.5 of hw
# $t4 = counter of payload
#########################################################

	lw $t1 AddressOfPayload	# Store the payload to $t1
	li $t4 0		# Counter for amt of char.

	counter:
		lbu $t3 0($t1)	# Take next char store to $t3
		beqz $t3 endCounter	# If Null char is reached, end of loop
		addi $t4 $t4 1	# Add one
		addi $t1 $t1 1	# Next Char
		j counter	# Back to loop
	endCounter:

	lbu $t1 3($t0)		# Load the byte
	andi $t1 $t1 0x0F	# leave only the header length
	sll $t1 $t1 2

	add $t1 $t4 $t1		# Add header length and payload chars and store in $t1
	sh $t1 0($t0) 		# Store in header. Header = $t0

#########################################################
# Part 2.6 of hw
# t1 = flag
# t2 = fragment_offset
#########################################################

	lbu $t1 5($t0)		# Load byte where flags is
	srl $t1 $t1 5		# Shift the byte so only flags is left
	move $a0 $t1		# Print binary of flags
	li $v0 35
	syscall

	li $v0 11		# Print comma
	li $a0 ','
	syscall

	lhu $t2 4($t0)		# Load the half word of flags & fragment_Offset
	sll $t2 $t2 19		# Remove flags from fragment_Offset
	srl $t2 $t2 19		# Put fragment_Offset back into place
	li $v0 35
	move $a0 $t2		# Print fragment_Offset
	syscall

	li $v0 4		#Print the next line
	la $a0 newline
	syscall

	bnez $s4 negOne		# bytesSent != 0
	li $t1 0
	j endSwitch		# Do not process when bytesSent = -1 or greater than 0
	negOne:
	li $t3 -1		# The value to compare $t2 with
	bne $s4 $t3 greaterOne	# t2 == -1? If not, go to greaterOne
	li $t1 0x4000		# flag = 010, fragment = 0 0000, 0100 0000 = 64
	j endSwitch
	greaterOne:		# No need to check b/c it is either 0,-1 or greater
	li $t1 4
	sll $t1 $t1 13
	add $t1 $t1 $s4		# Add 1000 0000 0000 0000 to bytes sent. which is # #### #### ####
	#ori $t1 $t2 0x8000	# Fragment offset. add 100 in front. 13 + 3 = 16

	endSwitch:
	sh $t1 4($t0)		# Changed so just store

#########################################################
# Part 2.7 of hw
# t4 = payload amt from 2.5
#########################################################

	#la $t1 AddressOfPayload	# Store the payload to $t1
	lw $t1 AddressOfPayload

	lbu $t2 3($t0) 		# Load the byte 3 of header
	andi $t2 $t2 0X0F	# Isolate the header length
	sll $t2 $t2 2		# header length * 4
	add $t2 $t2 $t0		# header + (headerLength * 4)

	addHeaderSize:		# Store payload
		beqz $t4 endAddHeaderSize	# If null byte, end loop
		lb $t3 0($t1) 	# Take next byte in payload
		sb $t3 0($t2)	# Store next byte
		addi $t4 $t4 -1	# Sub 1 decrement
		addi $t1 $t1 1	# The next address of payload
		addi $t2 $t2 1	# Add 1 to total length
		j addHeaderSize
	endAddHeaderSize:

#########################################################
# Part 2.8 of hw
#########################################################

	move $a0 $t0		# starting Address of header
	li $v0 34		# Print the start address
	syscall

	li $v0 11		# Print comma
	li $a0 ','
	syscall

#	addi $t2 $t2 -1		# Subtract 1 because the last one is null
	move $a0 $t2		# Load total length
	li $v0 34
	syscall

	li $v0 4		#Print the next line
	la $a0 newline
	syscall

#########################################################
# Part 2.9 of hw
# $t1 = half word part of header
# $t2 = halfword 1111 1111 <- largest digit. If larger, keep adding
#########################################################

	sh $0 8($t0)		# Set checksum to 0
	li $t3 0		# Store halfword. Initialize

	# Get the length we are going for
	lbu $t1 3($t0)		# Load the byte 3 = $t1
	andi $t1 $t1 0xF	# Get the header length
	sll $t1 $t1 1		# headerLength * 2 b/c headerlength = word. dealing with halfword

	addHeader:
		lhu $t4 0($t0)		# load the half word in header
		beqz $t1 endAddHeader	# Header length = 0?
		addi $t1 $t1 -1		# decrement so we can end loop
		addi $t0 $t0 2 		# Next half word
		add $t3 $t3 $t4		# sum of all half word in header = $t3
		j addHeader
	endAddHeader:

	# t3 has the sum of header.
	li $t2 0x10000
	sumChecksum:
		blt $t3 $t2 endChecksum	# t3 = halfword?
		srl $t4 $t3 16		# Get the higher
		sll $t3 $t3 16
		srl $t3 $t3 16
		# addi $t3 $t3 0xFF	# Get the lower
		add $t3 $t3 $t4		# Add the hi + lo
		j sumChecksum
	endChecksum:	# $t3 is now half word size

	xori $t3 $t3 0xFFFF	# One's complement

	la $t0 Header
	sh $t3 8($t0)

	j exit

error:	# Error occured. Print error message.
	li $v0 4
	la $a0 Err_string
	syscall

exit:	# Terminate program
	li $v0, 10
	syscall
