#project 
#Hala Gholeh 1201418  // Yazan Yousef 1191706
.data
	msg: .asciiz "Dictionary.txt file exist or not [y,n]? \n"
	done: .asciiz "\ndone\n"
	no: .asciiz "\nnooooo\n"
	#dictionaryFile: .asciiz "dictionary.txt"
	createdFileMsg: .asciiz "File Created Successfully :)\n"
	invaledMsg: .asciiz "\nInvaled Input :(\n"
	minueMsg: .asciiz "\nDo You Want To Compress Or Decompress? [Choose one of these options]\n1.[c], compress, or compression means compression.\n2.[d], decompress, decompression means decompression.\n3.[q] , quit means quit the program.\n"
	quitMsg: .asciiz "\nEnd Of Program ^_^\n"
	filename: .space 50
	
###_________________What I used in compresstion part______________###
	pathMsg: .asciiz "\nEnter The Path Of The Input File To Be Compressed\n"
	doComp: .asciiz "\nCompresstion was done *-*\n"
	inputFile: .space 50
	dictionaryFile: .asciiz "C:\\Users\\mwasem\\Desktop\\dectionary.txt"
	compressedFile: .asciiz "compressedFile.txt"
	buffer: .space 650000
	str: .space 30
	newline: .asciiz "\n" # new line character
	dot: .byte '.'   #dot character
	comma: .byte ','   #comma character
	null: .byte 0   
	zero: .byte 48     # ASCII code for the digit zero '0'
	space: .word 32   #ASCII code of space is 32
#__________________________________________________________________#	
	DfileName: .space 50
	bufferrr: .space 650000      # Buffer to store each line read from the file
	dec: .asciiz "d.txt"
	decB: .space 650000 
	Bdata: .space 3000
	mss: .asciiz "\nEnter the pathe of compressed file\n"


.text
main:

	#print msg on the screen to input the char
flag: #back from invaled msg notEqual
	la $a0 , msg
	li $v0 , 4
	syscall
	
	#input the char
	li $v0 , 12
	syscall
	
	#move user char from v0 to t0
	move $t0 , $v0
	li $t1 , 'y'   #put y char in t1
	li $t2 , 'n'  #put n char in t1
	li $t3 , 'Y'   #put y char in t1
	li $t4 , 'N'   #put y char in t1
	
	beq $t0 , $t1 , EnterThePath  #check if the user input was y if yes branch 
	beq $t0 , $t2 , creatFile #chaeck if the user input was n if yes branch 
	beq $t0 , $t3 , EnterThePath  #check if the user input was y if yes branch 
	beq $t0 , $t4 , creatFile  #check if the user input was y if yes branch 
	
	#bne $t0 , $t1 , notEqual 
	bne $t0 , $t2 , notEqual
back:   #back to code without check if invald input

	jal minueFunction
	
	
	
	
	#end  of main 
	li $v0 , 10   
	syscall
	
	
#lable to read the path of dictinary from the user	
EnterThePath:###################################################################################
	la $a0 , pathMsg
	li $v0 , 4
	syscall
# Reading the filename and storing it into filename variable.
    	li $v0, 8               
    	la $a0, filename        
    	li $a1, 50             
    	syscall                 

# Replacing the newline character with null character.
    	la $t0, filename
    	li $t1, '\n'
loo:
    	lb $t2, 0($t0)
    	addi $t0, $t0, 1
    	bne $t2, $t1, loo
    	sb $zero, -1($t0)       # Replace newline character with null character

# Open the file
    	li $v0, 13             
    	la $a0, filename        
    	li $a1, 0               
    	li $a2, 0               
    	syscall                 
    	move $s0, $v0           

# Read the file contents
    	li $v0, 14              
    	move $a0, $s0          
    	la $a1, buffer          
    	li $a2, 256            
    	syscall                

# Close the file
    	li $v0, 16              # Syscall code 16 for closing a file
    	move $a0, $s0           # Move the file descriptor to $a0
    	syscall
	
	j back
	
	
	
	
	
	

#lable to creat new file named dictinary.txt
creatFile:
	la $a0 , no
	li $v0 , 4
	syscall	
	
	li $v0 , 13    #open file
	li $a1 , 1    #flag to write in file
	la $a0 , dictionaryFile  #file name
	syscall
	move $s0, $v0
	
	la $a0 , createdFileMsg  #print msg 
	li $v0 , 4
	syscall
	li $v0, 16
   	move $a0, $s0
    	syscall
    
	j back
	
	
notEqual:
	la $a0 , invaledMsg
	li $v0 , 4
	syscall
	
	j flag
	


minueFunction:
here:  #back from notEqualMinue
	#print minue to choose the option 
	la $a0 , minueMsg
	li $v0 , 4
	syscall
	
	#input the char
	li $v0 , 12
	syscall
	
	#move user char from v0 to t0
	move $t0 , $v0
	li $t1 , 'q'   #put q char in t1
	li $t2 , 'Q'   #put q char in t2
	li $t3 , 'c'
	li $t4 , 'C'
	li $t5 , 'd'
	li $t6 , 'D'
	
	beq $t0 , $t1 , quit  #check if the user input was q if yes branch 
	beq $t0 , $t2 , quit  #check if the user input was q if yes branch 
	beq $t0 , $t3, compress
	beq $t0 , $t4, compress
	beq $t0 , $t5 , decompress
	beq $t0 , $t6 , decompress
	
	
	bne $t0 , $t2 , notEqualMinue
continue: #continue the function if we have equal choise

	
	jr $ra
	
	
quit:
	#end program
	la $a0 , quitMsg
	li $v0 , 4
	syscall
	
	li $v0 , 10
	syscall	
	
	
compress:
	li $t7, 48     # ASCII code for '0'

	la $a0 , pathMsg
	li $v0 , 4
	syscall

# Reading the filename and storing it into filename variable.
	li $v0, 8               
    	la $a0, inputFile      
    	li $a1, 50             
    	syscall                 # Read the filename from the user
    
# Replacing the newline character with null character.
    	la $t0, inputFile 
    	li $t1, '\n'
looop:
    	lb $t2, 0($t0)
    	addi $t0, $t0, 1
    	bne $t2, $t1, looop
    	sb $zero, -1($t0)       # Replace newline character with null character

    
   
# Open input file
    	li $v0 ,13
    	la $a0, inputFile
    	li $a1 , 0
    	syscall
    	move $s1 , $v0
    
#Read the file content
    	li $v0 , 14
    	move $a0 , $s1
    	la $a1 , buffer
    	li $a2 , 1024
    	syscall
    	
#Open output file
    	li $v0, 13
    	la $a0, dictionaryFile
    	li $a1, 1
    	syscall  # File descriptor gets returned in $v0
    	move $s0, $v0
    
# Open comp file
    	li $v0, 13
    	la $a0, compressedFile
    	li $a1, 1
    	syscall  # File descriptor gets returned in $v0
    	move $s2, $v0
    	
#Read words from input file and write them to output file
    	la $a3 , buffer
    	la $a1 , str
	li $t6 , 0 #counter 
	li $t5 , '.'
	li $t4 , ','

loop:
    	lb $t0, ($a3)
    	beq $t0,$t5 , skip #skip '.'
    	beq $t0,$t4 , skip #skip the ','
    	beq $t0, ' '  , next_word # 32 is ASCII code for space
    	beq $t0, 0, doneCOMP
    	sb $t0, ($a1) # Store character in string
    	addi $a3, $a3, 1
    	addi $a1, $a1, 1
    	addi $t6 , $t6 , 1  #increment the counter (counter +1)
    	j loop
	
next_word:

	sb $zero, ($a1) # terminate string
   	#la $a0, str
    	#li $v0, 4
    	#syscall
    
    	#la $a0 , newline
    	#li $v0 ,4
    	#syscall 
 
	li $v0, 15     # Syscall code 15 for writing to a file
        move $a0, $s0   # Move the file descriptor to $a0
        la $a1, zero    # Move the ASCII code to $a1
        li $a2, 1           
        syscall    
    
    	li $v0, 15      # write new line character in file
    	move $a0, $s0
    	la $a1, space
    	li $a2, 1
    	syscall
# Write word to output file
    	li $v0, 15
    	move $a0 , $s0
    	la $a1 , str
    	move $a2 , $t6
    	syscall
	
	li $v0, 15 # write new line character in file
   	move $a0, $s0
    	la $a1, newline
    	li $a2, 1
    	syscall
    	
    	addi $t7 , $t7 , 1  #increment the ASCII code 
  	sb $t7 , zero       #store the ASCII code in memory located at zero
  	
  	li $v0, 15           # writing to a file
        move $a0, $s2       # Move the file descriptor
        la $a1, zero       # Move the ASCII code to $a1
        li $a2, 1               
        syscall    
        
        li $v0, 15              
        move $a0, $s2          
        la $a1, newline       
        li $a2, 1               
        syscall 
        
# Prepare for next word
    	add $a1, $a1, $v0
    	addi $a3, $a3, 1 # skip printed word
    	la $a1, str # reset pointer for next word
    	li $t6 , 0 #rsent the counter to zero
    
    	j loop
    	
skip:
	addi $a3, $a3, 1 # skip char
	j loop
	
doneCOMP:
	addi $t7 , $t7 , 1
  	sb $t7 , zero
	li $v0, 15              # Syscall code 15 for writing to a file
        move $a0, $s0           # Move the file descriptor to $a0
        la $a1, zero          # Move the ASCII code to $a1
        li $a2, 1               # Length of the data to be written (1 byte)
        syscall    
     
	li $v0, 15 # write new line character
    	move $a0, $s0
    	la $a1, space
    	li $a2, 1
    	syscall

 	li $v0, 15 # write new line character
    	move $a0, $s0
    	la $a1, dot
    	li $a2, 1
    	syscall
    	
    	li $v0, 15 # write new line character
    	move $a0, $s0
    	la $a1, newline
    	li $a2, 1
    	syscall
    
    	addi $t7 , $t7 , 1
  	sb $t7 , zero

	li $v0, 15              # Syscall code 15 for writing to a file
        move $a0, $s0           # Move the file descriptor to $a0
        la $a1, zero          # Move the ASCII code to $a1
        li $a2, 1               # Length of the data to be written (1 byte)
        syscall    
        
     	li $v0, 15 # write new line character
    	move $a0, $s0
    	la $a1, space
    	li $a2, 1
    	syscall
    
    	li $v0, 15 # write new line character
    	move $a0, $s0
    	la $a1, comma
    	li $a2, 1
    	syscall
    	
    	la $a0 , doComp
    	li $v0 , 4
    	syscall
 
# Close input file
    	li $v0, 16
    	move $a0, $s1
    	syscall
# Close output file
    	li $v0, 16
    	move $a0, $s0
    	syscall
# Close compressed file
    	li $v0, 16
    	move $a0, $s2
    	syscall
	
	
	
	j minueFunction
	
	

decompress:

	la $a0 , mss
	li $v0 , 4
	syscall
# Reading the filename and storing it into filename variable.
    	li $v0, 8              
    	la $a0, DfileName       
    	li $a1, 50           
    	syscall                 

# Replacing the newline character with null character.
    	la $t0, DfileName
    	li $t1, '\n'
looppp:
    	lb $t2, 0($t0)
    	addi $t0, $t0, 1
    	bne $t2, $t1, looppp
    	sb $zero, -1($t0)       # Replace newline character with null character

# Open the file
    	li $v0, 13             
    	la $a0, DfileName        
    	li $a1, 0               
    	li $a2, 0              
   	 syscall                 
    	move $s0, $v0           

# Read the file contents
    	li $v0, 14              
    	move $a0, $s0          
    	la $a1, bufferrr         
    	li $a2, 256            
    	syscall                 

# Print the file contents
    	li $v0, 4              
    	move $a0, $a1          
    	syscall                
    		# Open the file
   	 li $v0, 13              
    	la $a0, dec        
    	li $a1, 0               
    	li $a2, 0               
    	syscall                 
    	move $s1, $v0   #decB
    
    
# Read the file contents
    	li $v0, 14              
    	move $a0, $s1          
    	la $a1, decB        
    	li $a2, 256             
    	syscall    

	la $t0, bufferrr      #compressed file
nextWord:
	lb $t2 , 0($t0)       # 0
	beq $t2, '\n', enc
    	la $t3, decB #dec file
	lb $t4 , 0($t3)  #the first word in in dec file
loopH:	
	beq $t2 , $t4 , print   
	j line
	beqz $t2 , minueFunction
line: 
	addi $t3 , $t3 , 1
	lb $t4 , 0($t3)
	beq $t4 , '\n' , plus
	beq $t2 , $t4 , print 
	j line
	
	
plus:
	addi $t3 , $t3 , 1
	lb $t4 , 0($t3)
	j loopH
	
	
print:
	addi $t3 , $t3 , 1 
	lb $t4 , 0($t3)
	beq $t4 , ' '  ,next
	
	j print 
	
	
	
next:
	addi $t3 , $t3 , 1   #Bdata: .space 3000
	lb $t4 , 0($t3)
	beq $t4 , 10 , enc   #new line
	
	la $t5 , Bdata
	sb $t4 , 0($t5)
	
	j next 
enc:	
	addi $t0 , $t0 , 1
	j nextWord
    # Close the file
   	 li $v0, 16              
    	move $a0, $s0           
    	syscall                 # Close the file



	li $v0, 16              
    	move $a0, $s1           # Move the file descriptor to $a0
    	syscall 
	j minueFunction
	



notEqualMinue:
	la $a0 , invaledMsg
	li $v0 , 4
	syscall
	
	j here
	
	li $v0 , 10
	syscall
