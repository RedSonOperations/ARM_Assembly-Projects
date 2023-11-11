.text
.global main
main:
    #pop stack
    SUB sp, sp, #12
    STR lr, [sp, #0]
    STR r4, [sp, #4]
    STR r5, [sp, #8]

    #prompt for and scan in number to be multiplied
    LDR r0, =promptNum
    BL printf
    LDR r0, =formatNum
    LDR r1, =num
    BL scanf

    #prompt for and scan in number to multiply first number by
    LDR r0, =promptMultBy
    BL printf
    LDR r0, =formatMultBy
    LDR r1, =multBy
    BL scanf

    #number to multiply loaded in r0, number to multiply this by loaded in r4
    #since r4 is decrementing counter in recursive function
    #r0 value copied/moved into r1 to remain as additive increment for final
    #product for recursive function
    LDR r0, =num
    LDR r0, [r0]
    LDR r1, =multBy
    LDR r4, [r1]
    MOV r1, r0
    BL MultiplyRecursive

    #output recursion product
    MOV r1, r0
    LDR r0, =outputProduct
    BL printf

    #prompt for index of Fibonacci sequence user wishes to calculate
    LDR r0, =promptFib
    BL printf
    #scan in value for Fibonacci sequence index
    LDR r0, =formatFib
    LDR r1, =fib
    BL scanf
    #preparing r4 and r5 to be equal to n-1 and n-2 respectively, where n is 
    #value stored in r0
    LDR r0, =fib
    LDR r0, [r0]
    SUB r4, r0, #1
    SUB r5, r0, #2
    BL RecursiveFib
    #outputting Fibonacci number at n
    MOV r1, r0
    LDR r0, =outputFib
    BL printf

    #push stack
    LDR lr, [sp]
    LDR r4, [sp, #4]
    LDR r5, [sp, #8]
    ADD sp, sp, #12
    MOV pc, lr

.data

promptNum: .asciz "Please enter a number to multiply: \n"
promptMultBy: .asciz "How much would you like to multiply that by?: \n"
formatNum: .asciz "%d"
formatMultBy: .asciz "%d"
num: .word 0
multBy: .word 0
outputProduct: .asciz "The product is %d!\n"

promptFib: .asciz "Please enter the index of the Fibonacci sequence you'd like to calculate: \n"
formatFib: .asciz "%d"
fib: .word 0
outputFib: .asciz "The Fibonacci number at this index is %d!\n"

#END main

.text
MultiplyRecursive:
    #pop stack
    SUB sp, sp, #8
    STR lr, [sp, #0]
    STR r4, [sp, #4]
    #compare r4 to 1, as r4 is the loop counter decremented towards 1
    #r4 decremented by 1 for every recursive call as r0 gets incremented by
    #the initial value of r0, held in r1 and added to and stored in r0 to get
    #final value of r0, which is the product of the two inputs
    #if r4 is not equal to 1, operations performed and recursive call made
    #otherwise, r0 is returned as the product of the two inputs and stack pushed
    CMP r4, #1
    BNE Else
    B return
    Else:
	#r0 is value that gets incremented by r1 (original value of r0) per each
        #recursive call
	ADD r0, r1
	#r4 is decrementing counter
	SUB r4, #1
	#recursive call
        BL MultiplyRecursive
        B return
    return:
	#stack pushed
	LDR lr, [sp]
	LDR r4, [sp, #4]
	ADD sp, sp, #8
	MOV pc, lr
.data
#END MultiplyRecursive

.text
RecursiveFib:
    #pop stack
    SUB sp, sp, #12
    STR lr, [sp, #0]
    STR r4, [sp, #4]
    STR r5, [sp, #8]
    #if n==0, return as base case
    CMP r0, #0              
    BEQ Return          
    #if n==1, return as base case
    CMP r0, #1             
    BEQ Return          
    #r4 = n-1
    SUB r4, r0, #1         
    #r5 = n-2
    SUB r5, r0, #2          
    #prepare n-1 for recursive call, subsequent recursive call
    MOV r0, r4             
    BL RecursiveFib                 
    MOV r4, r0             
    #prepare n-2 for recursive call, subsequent recursive call 
    MOV r0, r5              
    BL RecursiveFib            
    #fib(n)=fib(n-1)+fib(n-2), r0 = n-1, r4 = n-2
    ADD r0, r0, r4

    Return:
	#push stack
        LDR lr, [sp]
        LDR r4, [sp, #4]
        LDR r5, [sp, #8]
        ADD sp, sp, #12
        MOV pc, lr
