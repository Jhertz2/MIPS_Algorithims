.data

nums: .word 5,4,5,10,30,15,12,3,21

size: .word 9

min: .word 0

max: .word 0

median: .word 0

mode: .word 0

min_string: .asciiz "\nThe min is: "
max_string: .asciiz "\nThe max is: "
median_string: .asciiz "\n\n\nThe median is: "
mode_string: .asciiz "\nThe mode is: "


.text
lui $at, 4097
ori $t0, $at, 0

lui $at, 4097
ori $t1, $at, 36
nop
lw $t2, 0($t1) #t2 holds the 'size' variable
and $s7, $zero, 1 #clearing $s7 so we can set it to '2'
addi $s7, $s7, 2 #setting s7 to '2' for division purposes
div $t2, $s7 #divide size/2 ($t2/$t7)
mflo $s7 #s7 now holds the location of size/2
subi $t2, $t2, 1 #size-1 is $t2
and $t1, $zero, 1 #t1 is now our first counter 'i'
and $t3, $zero, 1 #$t3 is now our second counter 'h'
and $t9, $zero, 1 #clearing $t9 so we can store '4' in it
addi $t9, $t9, 4 #$t9 holds the number '4'
mult $t9, $s7 # 4 * size/2 ($t9 * $s7)
mflo $s7 #overwriting $s7, it now holds the middle word of the array (12)
start: beq $t1, $t2, end_1 #will run until $t1 becomes 10 (for (i<size))
nop

lui $at, 4097
ori $t0, $at, 0

	start_2: beq $t3, $t2, inner_end #2nd for loop
	nop 
	lw $t4,0($t0) #t4 =nums[h]
	lw $t5, 4($t0) #t5 = nums[h+1]
	slt $t6, $t4, $t5 #if nums[h]< nums[h+1], t6 will be 1
		beq $t6, 1, increment #if nums[h] < nums[h+1], we don't need to run this loop 
		nop
		lw $t7, 4($t0) #$t7 is temp_1 (holds value of nums[h+t]
		nop
		lw $t8, 0($t0) #t8 is temp_2 (holds value of nums[h]
		nop
		sw $t8, 4($t0) #changing value in memory of nums[h+1]
		sw $t7, 0($t0) #changing value in memory of nums [h]
		increment: addi $t0, $t0, 4 #index the array 'nums'
		addi $t3, $t3, 1 #increment 'h'
		j start_2
		nop
	inner_end: and $t3, $zero, 1 #reset the counter to 0 
addi $t1, $t1, 1 # increment $t1
j start
nop
end_1:

lui $at, 4097
ori $t0, $at, 0

lw $s0, 0($t0) #s0 hold value of the min 
lui $at, 4097
ori $s3, $at, 40
sw $s0, 0($s3) #storing value of the min in to 'min'
li $v0, 4 # system call code for printing string = 4
lui $at, 4097
ori $a0, $at, 56
syscall
li $v0, 1
lw $a0, 0($s3)
syscall


#S0 AND S3 CAN NOW BE OVERWRITTEN

mult $t2, $t9 #multiplying size-1 * 4 ($t2*$t9) to get us the max value
mflo $t9 #over writing $t9, so it now contains our last word '36'
add $t0, $t0, $t9 #setting to the last word in the array
lw $s0, 0($t0) #setting s0 to the max value of our array
lui $at, 4097
ori $s3, $at, 44
sw $s0, 0($s3) #storing value of the max in to 'max'
li $v0, 4 # system call code for printing string = 4
lui $at, 4097
ori $a0, $at, 70# load address of string to be printed into $a0
syscall
li $v0, 1
lw $a0, 0($s3)
syscall

#S0 S3 AND T9 CAN BE OVERWRITTEN NOW 

lui $at, 4097
ori $t0, $at, 0 #reset the array memory adress
add $t0, $t0, $s7 #incrementing our array to the halfway index
lw $s0, 0($t0)#s0 now contains the value of the halfway index of the array
lui $at, 4097
ori $s3, $at, 48
sw $s0, 0($s3) #storing value of the median in  to 'median'
li $v0, 4 # system call code for printing string = 4
lui $at, 4097
ori $a0, $at, 86 # load address of string to be printed into $a0
syscall
li $v0, 1
lw $a0, 0($s3)
syscall

 #CAN NOW BE OVERWRITTEN

#t2 holds size-1

and $t1, $zero, 1 #t1 is now our first counter 'g'
and $t3, $zero, 1 #$t3 is now our second counter 'y'
or  $s7, $zero, 1   #s7 = counter = 1
and $s4, $zero, 1 #s4 = hold = 0
and $t5, $zero, 1 #t5 = mode = 0
lui $at, 4097
ori $t0, $at, 0 #$t0 will be for arr[y]
lui $at, 4097
ori $s6, $at, 0 #$s6 now will be for arr[g]
lw $s3, 0($t0) # s3 = value of arr[y]
lw $s0, 0($s6) #s0 = value of arr[g]
#second loop!
start_1: 
 beq $t1, $t2, end_3 #will run until $t1 becomes 10 (for (g<size-1))
nop


	start_3: 
	beq $t3, $t2, inner_end_2 #2nd for loop
	nop 
		bne $s3, $s0, break_1 # if arr[y] doesn't equal arr[g] break ($s3!=$s0)
		nop
		addi $s7,$s7,1 #counter ++
		slt $s5, $s4, $s7 # if hold <counter, $s5 =1 
		
			bne $s5, 1, break_1 #if hold is not less than counter, don't run this loop
			nop
			addi $t5, $s0, 0 # mode = arr[g]
			addi $s4, $s7, 0 # hold = counter
	break_1:
	addi $t0, $t0, 4 #index the array
	lw $s3, 0($t0) # s3 = value of arr[y] +4
	addi $t3, $t3, 1 #increment y
	j start_3
	nop
	
	inner_end_2: and $t3, $zero, 1 #reset the 'y' to 0 
	addi $t1, $t1, 1 # increment $t1
	lui $at, 4097
	ori $t0, $at, 0 #reset memory address for nums at $t0
	addi $s6, $s6, 4#index the array arr[g]
	lw $s0, 0($s6) #increment arr[g]
	or $s7, $zero, 1 #counter = 1
j start_1
nop
end_3:

lui $at, 4097
ori $s7, $at, 52
sw $t5, 0($s7)
li $v0, 4 # system call code for printing string = 4
lui $at, 4097
ori $a0, $at, 103# load address of string to be printed into $a0
syscall
li $v0, 1
lw $a0, 0($s7)
syscall



