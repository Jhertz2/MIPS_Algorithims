.data

matrixB: .word 5,6,7,8,9,10
sizeY: .word 3,1
sizeX: .word 3,1
sizeB: .word 2,3
result: .word 0:9
VectorX: .word 40, 50, 60
VectorY: .word 70, 80 ,90
XtimesY: .word 0:9

.text

#transpose vector Y

and $t0, $zero, 1 #creating an increment

#this is transposing Y
lui $at, 4097 # accessing memory
ori $t1, $at,24 
lw $t2, 0($t1) # storing value of '3' in to $t2
lw $t3, 4($t1) # storing value of '1' in to $t3
sw $t2, 4($t1) #  stre value in $t2 into memory adress located at $t1
sw $t3, 0($t1)




#load all values of column vectors

lui $at, 4097 #bring values of vector x from memory
ori $s0, $at, 84
lui $at, 4097
ori $s4, $at, 96 #bringing values of vector y from memory
lui $at, 4097
ori $t1, $at, 108




begin_1:
beq $t0, $t2, next_1
nop
lw $s1, 0($s0) #s1 is VectorX
nop
lw $s2, 0($s4) #this is Vector Y
nop

mult  $s1, $s2
mflo $t8
sw $t8, 0($t1) #saving the element in to our multiplied matrix
addi $t1, $t1, 4
addi $s4, $s4, 4
addi $t0, $t0, 1
j begin_1
nop

next_1: and $t0, $zero, 1
lui $at, 4097
ori $s4, $at, 96 #bringing values of vector y from memory

begin_2:
beq $t0, $t2, next_2
nop
lw $s1, 4($s0) #s1 is VectorX
nop
lw $s2, 0($s4) #this is Vector Y
nop

mult  $s1, $s2
mflo $t8
sw $t8, 0($t1) #saving the element in to our multiplied matrix
addi $t1, $t1, 4
addi $s4, $s4, 4
addi $t0, $t0, 1
j begin_2

next_2: and $t0, $zero, 1
lui $at, 4097
ori $s4, $at, 96 #bringing values of vector y from memory
begin_3:
beq $t0, $t2, end1
nop
lw $s1, 8($s0) #s1 is VectorX
nop
lw $s2, 0($s4) #this is Vector Y
nop

mult  $s1, $s2
mflo $t8
sw $t8, 0($t1) #saving the element in to our multiplied matrix
addi $t1, $t1, 4
addi $s4, $s4, 4
addi $t0, $t0, 1
j begin_3


end1:
and $t0, $zero, 1
lui $at, 4097
ori $s0, $at, 108
lui $at, 4097 
ori $s4, $at, 0
lui $at, 4097
ori $s7, $at, 48


start_1: beq $t0, 3, first_done
nop
lw $s1, 0($s0) #XtimesY
lw $t9, 0($s4) #matrixB
mult $s1, $t9 #multiplying matrix elements
mflo $s2 #holds product
add $t4, $t4, $s2 #$t4 will hold our sum
addi $t0, $t0, 1 #increment counter 
addi $s0, $s0, 12 #increment down the rows of XtimesY
addi $s4, $s4, 4 #increment across the column of Matrix B
j start_1

first_done:
sw $t4, 0($s7) #saving the sum to the first memory address
and $t4, $zero, 1 #reclearing our sum
lui $at, 4097 
ori $s0, $at, 108
lui $at, 4097 
ori $s4, $at, 0
and $t0, $zero, 1


start_2: beq $t0, 3, second_done
nop
lw $s1, 4($s0) #XtimesY
lw $t9, 0($s4) #matrixB
mult $s1, $t9 #multiplying matrix elements
mflo $s2 #holds product
add $t4, $t4, $s2 #$t4 will hold our sum
addi $t0, $t0, 1 #increment counter 
addi $s0, $s0, 12 #increment down the rows of XtimesY
addi $s4, $s4, 4 #increment across the column of Matrix B
j start_2

second_done:
sw $t4, 4($s7) #saving the sum to the first memory address
and $t4, $zero, 1 #reclearing our sum
and $t0, $zero, 1
lui $at, 4097 
ori $s0, $at, 108
lui $at, 4097 
ori $s4, $at, 0

start_3: beq $t0, 3, third_done
nop
lw $s1, 8($s0) #XtimesY
lw $t9, 0($s4) #matrixB
mult $s1, $t9 #multiplying matrix elements
mflo $s2 #holds product
add $t4, $t4, $s2 #$t4 will hold our sum
addi $t0, $t0, 1 #increment counter 
addi $s0, $s0, 12 #increment down the rows of XtimesY
addi $s4, $s4, 4 #increment across the column of Matrix B
j start_3

third_done:
sw $t4, 8($s7) #saving the sum to the first memory address
and $t4, $zero, 1 #reclearing our sum
lui $at, 4097 
ori $s0, $at, 108
lui $at, 4097 
ori $s4, $at, 0
and $t0, $zero, 1

#first row of result done

start_4: beq $t0, 3, fourth_done
nop
lw $s1, 0($s0) #XtimesY
lw $t9, 12($s4) #matrixB
mult $s1, $t9 #multiplying matrix elements
mflo $s2 #holds product
add $t4, $t4, $s2 #$t4 will hold our sum
addi $t0, $t0, 1 #increment counter 
addi $s0, $s0, 12 #increment down the rows of XtimesY
addi $s4, $s4, 4 #increment across the column of Matrix B
j start_4

fourth_done:
sw $t4, 12($s7) #saving the sum to the first memory address
and $t4, $zero, 1 #reclearing our sum
lui $at, 4097 
ori $s0, $at, 108
lui $at, 4097 
ori $s4, $at, 0
and $t0, $zero, 1


start_5: beq $t0, 3, fifth_done
nop
lw $s1, 4($s0) #XtimesY
lw $t9, 12($s4) #matrixB
mult $s1, $t9 #multiplying matrix elements
mflo $s2 #holds product
add $t4, $t4, $s2 #$t4 will hold our sum
addi $t0, $t0, 1 #increment counter 
addi $s0, $s0, 12 #increment down the rows of XtimesY
addi $s4, $s4, 4 #increment across the column of Matrix B
j start_5

fifth_done:
sw $t4, 16($s7) #saving the sum to the first memory address
and $t4, $zero, 1 #reclearing our sum
lui $at, 4097 
ori $s0, $at, 108
lui $at, 4097
ori $s4, $at, 0
and $t0, $zero, 1

start_6: beq $t0, 3, sixth_done
nop
lw $s1, 8($s0) #XtimesY
lw $t9, 12($s4) #matrixB
mult $s1, $t9 #multiplying matrix elements
mflo $s2 #holds product
add $t4, $t4, $s2 #$t4 will hold our sum
addi $t0, $t0, 1 #increment counter 
addi $s0, $s0, 12 #increment down the rows of XtimesY
addi $s4, $s4, 4 #increment across the column of Matrix B
j start_6

sixth_done:
sw $t4, 20($s7) #saving the sum to the first memory address
lui $at, 4097
ori $t0, $at, 48
and $t1, $zero, 1

print: beq $t1, 3, finished_1 # our loop to print the array
li $v0, 1
lw $a0, 0($t0)
syscall
li $a0, 32
li $v0, 11  # syscall number for printing character
syscall
addi $t0, $t0, 4
addi $t1, $t1, 1
j print



finished_1: 
addi $a0, $0, 10 #ascii code for LF, if you have any trouble try 0xD for CR.
addi $v0, $0, 11 #syscall 11 prints the lower 8 bits of $a0 as an ascii character.
syscall
print_1: beq $t1, 6, finished
li $v0, 1
lw $a0, 0($t0)
syscall
li $a0, 32
li $v0, 11  # syscall number for printing character
syscall
addi $t0, $t0, 4
addi $t1, $t1, 1
j print_1

finished:
nop

