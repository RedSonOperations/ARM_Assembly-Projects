.text
.global main
main:
    #pop stack
    SUB sp, sp, #12
    STR lr, [sp, #0]
    STR r4, [sp, #4] @ r4 = loop counter
    STR r5, [sp, #8] @ r5 = loop limit

    #prompt user for number and scan in input 
    LDR r0, =promptNumber
    BL printf
    LDR r0, =formatNumber
    LDR r1, =number
    BL scanf
   
    #determine whether input number is prime or not
    LDR r0, =number
    LDR r0, [r0]
    MOV r1, #2
    BL __aeabi_idiv
    #input number divided by 2 = limit of loop for prime number testing
    #initialize
    MOV r5, r0 
    MOV r4, #2
    
    Startloop:
	#check limit, if counter is greater than input/2 and input does not test
	#as not prime for all integers up to input/2, branch to 'Prime'
	CMP r4, r5
	BGT Prime

        #prime number test algorithm:
	#since integers get rid of decimal when unevenly dividing a number
	#i.e., 12=user input, 5=divisor from 2 to n/2, 12/5 = 2.4 ->int-> 2
	#they should not be able to be multiplied by the divisor/denominator val
	#to equal the numerator (i.e., 2*5 = 10 /= 12 according to integer
	#division from the preceding example, 12/5).
	#Then, compares product of divisor and quotient to user-input number
	#and if it equals user-input number, input number is not prime, program		#branches to NotPrime.
        LDR r0, =number
        LDR r0, [r0]
        MOV r1, r4
        BL __aeabi_idiv
	#r0 now contains quotient
	MUL r1, r0, r4
	#r1 now contains quotient * counter (divisor in our case from 2 to  n/2)	#aka, the product mentioned prior in above explanation of method
	MOV r0, r1
	LDR r1, =number
	LDR r1, [r1]
	#r0 now contains product, r1 now contains user-input number
	#comparison, if unequal for all cases 2 to n/2, user-input number is 
	#prime. If equal encountered for any divisor, user-input number is not
	#prime.
	CMP r0, r1
	BEQ NotPrime

	#increment counter, loop continues for counter += 1
        ADD r4, r4, #1
        B Startloop

    Prime:
	#number is prime, displays number that is prime in output message
	LDR r1, =number
	LDR r1, [r1]
	LDR r0, =prime
	BL printf
	B guess

    NotPrime:
	#number is not prime, displays number that is not prime in output message

	LDR r1, =number
	LDR r1, [r1]
	LDR r0, =notPrime
        BL printf
    	B guess
    
    guess:    
	#prompt for, scan in max value for range of numbers for user to guess in
	LDR r0, =promptMax
	BL printf
	LDR r0, =formatMax
	LDR r1, =max
	BL scanf

	#initialize loop limit, r5, and loop counter, r4
	LDR r0, =max
	LDR r0, [r0]
	MOV r5, r0
	MOV r4, #0

	#Perform linear congruential generation to generate pseudo random number
        LDR r0, =max
	LDR r0, [r0]
	LDR r1, =m
	LDR r1, [r1]
	MUL r0, r0, r1
        ADD r0, r0, #5
	MOV r1, #12
	BL __aeabi_uidivmod

	#move and store random value in variable 'random'
	MOV r1, r0
	LDR r0, =random
	STR r1, [r0]
	
	guessLoop:
	    #max number of tries is the max number that the user set as limit
	    #if equals or exceeds limit, branch to lost and user loses
	    CMP r4, r5	
	    BGE lost

	    #load max to prompt user to guess between 1 and max
	    #prompt and scan in for guess
	    LDR r0, =max
	    LDR r0, [r0]
	    MOV r1, r0

	    LDR r0, =promptGuess
	    BL printf
	    LDR r0, =formatGuess
	    LDR r1, =guess_
	    BL scanf
	   
  	    #comparisons betwen guess and random number made
	    #1. if guess greater than random number, branches to guessLower
	    #2. if guess less than random number, branches to guessHigher
	    #3. if guess equals random number, user wins
	    LDR r0, =guess_
 	    LDR r0, [r0]
	    LDR r1, =random
    	    LDR r1, [r1]
	    #1
	    CMP r0, r1
	    BGT guessLower
            #2
	    CMP r0, r1
	    BLT guessHigher	
	    #3
	    CMP r0, r1
	    BEQ equals    
	    #increment loop, branch to beginning of loop

	    ADD r4, r4, #1
	    B guessLoop
	equals:
	    #user guessed correctly, random number loaded into r1 and displayed for proof of correct guess
	    LDR r1, =random
	    LDR r1, [r1]
	    LDR r0, =correctGuess
	    BL printf
	    #branch to push stack/end of program (end)
	    B end            	
	guessLower:
	    #user guessed higher than random number, prompted to guess lower
	    LDR r0, =colder
	    BL printf
	    ADD r4, r4, #1
	    B guessLoop
	guessHigher:
	    #user guessed lower than random number, prompted to guess higher
	    LDR r0, =warmer
   	    BL printf
	    ADD r4, r4, #1
	    B guessLoop
	lost:
	    #user loses, failed to guess random number. Random number loaded into r1 and displayed for proof of inaccurate guesses
	    LDR r1, =random
	    LDR r1, [r1]
	    LDR r0, =loseMsg
	    BL printf
	    #branch to push stack/end of program (end)
	    B end
    end:
        #push stack
        LDR lr, [sp, #0]
        LDR r4, [sp, #4]
        LDR r5, [sp, #8]
        ADD sp, sp, #12
        MOV pc, lr

.data
promptNumber: .asciz "Please enter a number: \n"
formatNumber: .asciz "%d"
number: .word 0
primeTestVal: .word 2
prime: .asciz "Your number %d is prime!\n"
notPrime: .asciz "Your number %d is not prime!\n"
promptMax: .asciz "Please enter a max value for the range you will guess in:\n"
formatMax: .asciz "%d"
promptGuess: .asciz "Please guess a number between 1 and %d\n"
formatGuess: .asciz "%d"
guess_: .word 0
max: .word 0
warmer: .asciz "Guess higher!\n"
colder: .asciz "Guess lower!\n"
random: .word 0
m: .word 8
rand: .asciz "Random: %d\n"
correctGuess: .asciz "Great job! You guessed it. The random number was: %d\n"
loseMsg: .asciz "You ran out of guesses! The random number was: %d\n"
