.data

nums: .word 10,9,8,7,6,5,4,3,2,1

sorted: .word 0:10

length: .word 10


.text

lui $at, 4097
ori $t0, $at, 0
lui $at, 4097
ori $t1, $at, 40
lui $at, 4097
ori $t2, $at, 80
addi  $t3, $t3 ,2 #making $t3 hold '2'
lw $t2, 0($t2) #$t2 holds length
addi $s0, $s0, 4 #making $s0 4
mult $t2, $s0 #multipliying length by 4
mflo $s0 #$s0 now holds length *4
subi $t8, $s0, 4 #4*length - 4 (Last element in our arrays) $t8
add $s0, $t0, $s0 #s0 now holds the max number of elements
div $t3, $t2 #divide length by 2
mflo $t2 #$t2 hold length/2
subi $t2, $t2, 1 #$t2 holds length/2 - 1
subi $s1, $s0, 4 #for odd
add $s2, $s1, $t0

start: 

#comparing each pair, and saving the smaller one first in to the sorted array


lw $t5, 0($t0) #load the first element in to $t5
lw $t6, 4($t0) #load second elemnt of $t6

slt $t4, $t5, $t6 #so if first element is less than second element being compared, $t4 will be set to 1

bne $t4, 1, label #if the first element is smaller, run this loop, otherwise jump
nop
sw $t5, 0($t1) #save the smaller element in to the first element of sorted

sw $t5, 0($t0)

sw $t6, 4($t1) #save larger element in to the second element of sorted

sw $t6, 4($t0)
j bottom

label: 

sw $t6, 0($t1)
sw $t5, 4($t1)
sw $t5, 0($t0)
sw $t6, 4($t0)

bottom:
addi $t1, $t1, 8 #incrementing sorted array
addi $t0, $t0, 8 # incrementing nums array
beq $t0, $s0, end #if memory adress of nums array has increased to the max value, break
nop
beq $t0, $s1, end
nop
beq $s1, $t0, end
nop
j start


end: 


continue:
lui $at, 4097 
ori $t2, $at, 80
lw $t2, 0($t2)#$t2 holds length
and $s0, $zero, 1
addi $s0, $s0, 4
div $t2, $s0
mflo $t2 #$t2 now holds length/4 
and $s1, $zero, 1 #s1 will be our incermeenter 'i'
lui $at, 4097 
ori $t0, $at, 0
lui $at, 4097 
ori $t1, $at, 40
#second time through

begin: beq $s1, $t2, finished #this loop will run two times
nop
lw $s2, 0($t1)# load our values 
lw $s3, 8($t1)
slt $s4, $s2, $s3
	beq $s4, 1, zero_less_than_8 #comparing the first zeroth to the eigth
	nop
	sw $s3, 0($t0)
	lw $s3, 12($t1)
	slt $s4, $s2, $s3
		beq $s4, 1, zero_less_than_12#comparing the first zeroth to the 12th
		nop
		sw $s3, 4($t0)
		sw $s2, 8($t0)
		lw $s2, 4($t1)
		sw $s2, 12($t0)
		j increment #end


j begin
zero_less_than_8:#if zero was lessthan 8, run this loop
sw $s2, 0($t0)
lw $s2, 4($t1)
slt $s4, $s2, $s3
beq $s4, 1, four_less_than_8 #comparing the fourth and eigth
nop
sw $s3, 4($t0)
lw $s3, 12($t1)
j zero_less_than_12 


zero_less_than_12: #if the zeroth was less than the 12th
sw $s2, 8($t0)
lw $s2, 4($t1)
slt $s4, $s2, $s3
beq $s4, 1, four_less_than_12
nop
sw $s3, 8($t0)
sw $s2, 12($t0)
j increment #end
nop

four_less_than_12: # if the fourth was less than the 12th 
sw $s2, 8($t0)
sw $s3, 12($t0)
j increment #end
nop

four_less_than_8: #comparing the first zeroth to the eigth
sw $s2, 4($t0)
sw $s3, 8($t0)
lw $s3, 12($t1)
sw $s3, 12($t0)
j increment #end
nop

increment:

addi $s1, $s1, 1 #increment our counter
addi $t0, $t0, 16 # check the second group (starting at the 16th bit)
addi $t1, $t1, 16

j begin
nop

finished:


lui $at, 4097  
ori $t0, $at, 0 #for s2 (smaller half)
lui $at, 4097 #for s3, (larger Half)
ori $s5, $at, 0
addi $s5, $s5, 16 #starting at the 16th bit (second half)
lui $at, 4097 
ori $t1, $at, 40

lw $s1, 32($t1) #carrying over the last two elements 
sw $s1, 32($t0)
lw $s1, 36($t1)
sw $s1, 36($t0)

and $s6, $zero, 1 #these counters will be used to break our loop
and $s7, $zero, 1 #to break loop


lw $s2, 0($t0)
lw $s3, 0($s5)
beginning:
slt $s4, $s2, $s3 #comparing s3 to s2
beq $s4, 1, smallerB_less_than_biggerB #if the value at the smaller byte is less than the value at the bigger byte, jump
nop
sw $s3, 0($t1) 
addi $s5, $s5, 4 #index our array
lw $s3, 0($s5) #update values being compared
addi $s6, $s6, 1 #increment our counter
addi $t1, $t1, 4 # indexing our storage array
beq $s6, 4, donezo_s6 #if  our counter gets to 4, break
nop

j beginning
nop

smallerB_less_than_biggerB: #if the value at the smaller byte is greater than the value at the bigger byte, jump
nop
sw $s2, 0($t1)
addi $t0, $t0, 4 # index our array
lw $s2, 0($t0)
addi $s7, $s7, 1 #increment our counter
addi $t1, $t1, 4 #index our storage array
beq $s7, 4, donezo_s7 # if our counter gets to 4, break
nop
j beginning #run the loop again
nop

donezo_s6: #greater than half
and $s0, $zero, 1 # clear $s0 to set to 4
addi $s0, $s0, 4 #setting s0 equal to 4
sub $t5, $s0, $s7  #four minus the half that doesn't break (using this to see how many numbers need to be merged and where)
mult $t5, $s0 # multiplying so we can get a number of bits
mflo $t5 #$t5 now holds number of bits that need to be merged
and $s0, $zero, 1 #set s0 to 0
here: beq $s0, $t5, the_end # this loop runs until s0 becomes equal to the number of bits that need to be merged (until all the necessary bits are merged)
nop
lw $s4, 0($t0) 
sw $s4, 0($t1)
addi $t0, $t0, 4 # index array
addi $s0, $s0, 4 #incrementing our counter
addi $t1, $t1, 4 #index our storage array

j here#run the loop again
nop

donezo_s7:#'less than' halves

and $s0, $zero, 1 # clear $s0 to set to 4
addi $s0, $s0, 4
sub $t5, $s0, $s6  #four minus the half that doesn't break
mult $t5, $s0 #holds total number of bits
mflo $t5 #this holds 
and $s0, $zero, 1
here_1: beq $s0, $t5, the_end # this loop runs until our counter equals number of bits that need to be merged
nop
lw $s4, 0($s5)
sw $s4, 0($t1)
addi $s5, $s5, 4 
addi $s0, $s0, 4
addi $t1, $t1, 4

j here_1
nop


the_end:



and $s6, $zero, 1 #clearing s6 to be used as a counter
and $s7, $zero, 1 #clearing s7 to be used as a counter
lui $at, 4097 
ori $t1, $at, 40 #for lesser half
lui $at, 4097 # for larger half
ori $s5, $at, 40
lui $at, 4097 
ori $t0, $at, 0
addi $s5, $s5, 32 # only concerned with the last two elements of this array
donuts:
lw $s2, 0($s5) 
nop
lw $s3, 0($t1)
nop
slt  $s4, $s2, $s3 #comparing last two elements in the array to the beginning elements
beq $s4, 1, jun # if the end elements are less then, go to 'jun'
nop
sw $s3, 0($t0) # otherwise, store the smaller value
addi $t1, $t1, 4 #index our array
addi $s7, $s7, 1 #increment counter
addi $t0, $t0, 4 #index our storage array
beq $s7, 8, home_s7 #if our counter reaches '8', break
nop
j donuts
nop

jun:
sw $s2, 0($t0) #save the end element
addi $s5, $s5, 4 # index our array
addi $t0, $t0, 4 #index the storage array
addi $s6, $s6, 1 #increment our counter
beq $s6, 2, home_s6 # if this counter equals 2, break
nop
j donuts
nop

home_s6:

and $s0, $zero, 1 # clear $s0 to set to 4
and $t3, $zero, 1 # clear $t3
addi $t3, $t3, 10 #make $t3=10
addi $s0, $s0, 4 #make $s0 =4
sub $t5, $t3, $s7  #four minus the counter from the half that doesn't break
mult $t5, $s0 #multiply this value by 4, to give number of bits that need to be merged
mflo $t5 #$t5 now holds number of bits needed to be merged
and $s0, $zero, 1 #clear s0
this: beq $s0, $t5, final # if s0 equals the number of bits that need to be merged, break (if all the bits are merged)
nop
lw $s4, 0($t1) 
sw $s4, 0($t0)
addi $t0, $t0, 4 #index our storage array
addi $s0, $s0, 4 #increment our counter
addi $t1, $t1, 4 #indez our array
j this
nop

home_s7:

and $s0, $zero, 1 # clear $s0 to set to 4
and $t3, $zero, 1 # clear $t3
addi $t3, $t3, 10
addi $s0, $s0, 4
sub $t5, $t3, $s6  #four minus the half that doesn't break
mult $t5, $s0 #holds total number of bits
mflo $t5 #this holds 
and $s0, $zero, 1 #clear s0
this_1: beq $s0, $t5, final # if s0 equals the number of bits that need to be merged, break (if all the bits are merged)
nop

mult $s6, $s0 #
mflo $s6
add $s5, $s6, $s5 #incrementing the memory adress, deciding which of the final two elements need to be stored

lw $s4, 0($s5) 
sw $s4, 0($t0)#storing in necessary spot
addi $s5, $s5, 4 #increment memory adress
addi $t0, $t0, 4 #index array
addi $s0, $s0, 4 #increment counter
addi $t1, $t1, 4 #increment array

j this_1
nop

final:

#this is for printing the array
lui $at, 4097 
ori $t0, $at, 0

and $s0, $zero, 1
while:
beq $s0, 10, print #break the loop when the counter hits 10
li $v0, 1
lw $a0, 0($t0)
syscall
addi $s0, $s0, 1 #add one to the counter 
addi $t0, $t0, 4 #increment the array 
li $a0, 32 #print the space in between the numbers
li $v0,11
syscall
j while
print: