 
.data

array: .word 0:5
integer: .asciiz "Enter a number: "
findMax: .asciiz "\nThe largest of which is: "
userEntry: .asciiz "You entered: "
space: .asciiz " "



.text
main:           
	#Defines the array with a size of 5 words.
    	la $s0, array
    	li $t1, 5
    	lw $t4,($s0)

#Loop
whileLoop:
	#Ask the user for their numbers until the array is full.
    	la $a0, integer          #Ask the user.
    	li $v0, 4
    	syscall

    	li $v0, 5               #Store the integer.
    	syscall
    	sw $v0, ($s0)           #Then store the integer into the array.
    	 
	#Go to the next index.
	addi $s0, $s0, 4
    	addi $t2, $t2, 1	    #Add 1 to the counter.	       
    	blt $t2, $t1, whileLoop     #Keep going while the size is less than 5. Use the whileLoop

resetArray:
    	la $a0, userEntry          #Print the array.
    	li $v0, 4
    	syscall
	
	#Reset the array, the counter and the memory address of the array.
    	li $s0, 0
    	li $t2, 0
    	la $s0, array

 walkThrough:
 	#Add a word into t2
    	lw $t6,($s0)
    	#Claim into register
    	move $a0, $t6        
    	li $v0, 1            
    	syscall

	#Add a space
    	la $a0, space
    	li $v0, 4            
    	syscall

	#Go to the next index now in the array!
    	addi $s0, $s0, 4         
    	addi $t2, $t2, 1         
	
	#Branch as long as the counter is less than the size of the array.
    	blt $t2, $t1, walkThrough     

	#Reset the counter, the address then go to the next index of the array.
    	li $t2, 0               
    	la $s0, array            
    	addi $s0, $s0, 4         
    	addi $t2, $t2, 1         


 maxLoop:  
 #Basically, find the minimum number, then keep looping through
 #the array until you find the maximum value.
 	#Loop to the next element in the array
 	lw $s6,($s0)
 	#If the element is more than the minimum value, then it's not the max, loop.   
 	#If the value is greater than or equal to the minimum.          
    	bge $s6, $t3, greaterThanMin    
    	move $t3,$s6    
    	#Loop        
    	j ifNotMax

 greaterThanMin:
 	#If the number isn't the max, then go to ifNotMax function
 	ble $s6,$t4, ifNotMax        
    	move $t4,$s6           

 ifNotMax:
 	#Loop if the counter is less than the size. 
 	#If the value is less than or equal to the maximum.
 	addi $t2,$t2,1
    	addi $s0,$s0, 4
    	blt $t2, $t1, maxLoop


#Printing the max value
	#Print the "largest value"
    	la $a0, findMax               
    	li $v0,4            
    	syscall
	#Show the max value
    	move $a0, $t4           
    	li $v0,1
    	syscall
	
	#Fin
    	li $v0,10                
    	syscall
