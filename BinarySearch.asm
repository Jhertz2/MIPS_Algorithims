.data
length : .word 9 #create a word of value 10
nums : .word 2,4,6,8,10,12,14,16,18 #made an array with these values
target : .word 20 #made a word of value 11
out_string: .asciiz "\nNot Found\n"
found: .asciiz "\nFound it!\n"
small: .asciiz "\nSorry, this array is too small to search. \n"

.text

and $s5, $zero, 1 # counter to be used later
lui $at, 4097
ori $s7, $at, 40
nop
lw $s6, 0($s7) # s6 hold 'target' value
nop
lui $at, 4097
ori $t0, $at, 0
nop
lw $t1, 0($t0) #$t1 holds the size

beq  $t1,0,  crash

addi $t2, $zero, 2 #$t2 is 2
div $t1, $t2 #divide the size of the array by 2
mflo $t0 #rewrite $t0 with the integer value of half of the array
addi $t9, $t0, 1
addi $t3, $zero, 4 #$t3 is 4
mult $t0, $t3  #find the number of bits from the left the middle value is
mflo $t4 #$t4 is the number of bits to the middle from the left
addi $t8, $t0, 1
lui $at, 4097  #load the address of nums to $t5
ori $t5, $at, 4
addi $t7, $t5, 0


add $t5, $t5, $t4 #setting $t5 to the fifth word
mult $t1, $t3 #finding bit size of array (4*10)
mflo $s3 #holds bit size of array (40)

add $t7, $t7, $s3 #setting our max word size (1001028)

 #s0 holds halfway value(our checker) of 'nums'
#beginning of main loop
start: lw $s0, 0($t5) #s0 holds halfway value(our checker) of 'nums'
nop

beq $s0, $s6, end #Checks if $s0(halfway) is equal to $s6 (target)
nop
slt $t6,$s6,$s0 #if $s6 target is less than halfway$s0, set t6 to 1
beq $t6, 1, left_half # if $t6 is 1 (meaning target is less than halfway point) branch off, otherwise run this loop
nop
div $t0,$t2 #divide old halfway $t0, by 2 ($t2)
mflo $t0 #$t0 is our new halfway int value, (currently '2')
bne $t0, 0, skip_1
nop
addi $t0, $t0, 1 #adding one to our new halfway, $t0 should now equal '3'
skip_1: nop
mult $t0, $t3 #finding the bitwise shift necessary '3*4($t3) (currently should be 12) 
mflo $s1 # s1 holds our adder value/ the bit mover (should be $12)
add $t5, $t5, $s1 #updating our halfway point by changing the bit value
slt  $s2, $t7, $t5    
addi $s5, $s5, 1
beq  $s2, 1, not_found 
nop
beq  $t7, $t5, not_found
nop
beq $s5, $t9, not_found
nop
j start
nop


left_half: nop

div $t0,$t2 #divide old halfway $t0, by 2 ($t2)
mflo $t0 #$t0 is our new halfway int value, (currently '2')
bne $t0, 0, skip_2
nop
addi $t0, $t0, 1 #adding one to our new halfway, $t0 should now equal '3'
skip_2: nop
mult $t0, $t3 #finding the bitwise shift necessary '3*4($t3) (currently should be 12) 
mflo $s1 # s1 holds our adder value/ the bit mover (should be $12)
sub $t5, $t5, $s1 #updating our halfway point by changing the bit value
slt  $s2, $t7, $t5    
addi $s5, $s5, 1
beq  $s2, 1, not_found 
nop
beq  $t7, $t5, not_found
nop
beq $s5, $t9, not_found
nop
j start
nop


not_found: nop
li $v0, 4 # system call code for printing string = 4
lui $at, 4097 # load address of string to be printed into $a0
ori $a0, $at, 44
syscall # call operating system to perform operation
j gone
nop

end: nop
li $v0, 4 # system call code for printing string = 4
lui $at, 4097 # load address of string to be printed into $a0
ori $a0, $at, 56
syscall # call operating system to perform operation
j gone
nop

crash: nop
li $v0, 4 # system call code for printing string = 4
lui $at, 4097 # load address of string to be printed into $a0
ori $a0, $at, 68
syscall # call operating system to perform operation
j gone
nop



gone: nop