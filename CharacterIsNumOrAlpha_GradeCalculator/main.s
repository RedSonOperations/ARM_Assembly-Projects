.global main
.text

main:
    #pop stack
    SUB sp, sp, #4
    STR lr, [sp, #0]

    LDR r0, =promptAlpha
    BL printf
    LDR r0, =formatAlpha
    LDR r1, =alpha
    BL scanf
    LDR r0, =alpha
    LDR r0, [r0] 

    # Call isAlphabeticLogical
    BL isAlphabeticLogical

    # Check the result in r0
    CMP r0, #1
    BEQ isAlpha
    B outputNotAlpha

isAlpha:
    LDR r0, =outputAlpha
    BL printf
    B rest

outputNotAlpha:
    LDR r0, =outputNum
    BL printf
    B rest 
rest:
    # Call gradeProgram
    LDR r0, =promptName
    BL printf
    LDR r0, =formatName
    LDR r1, =name
    BL scanf
    LDR r0, =promptAvg
    BL printf
    LDR r0, =formatAvg
    LDR r1, =avg
    BL scanf
    LDR r1, =name
    LDR r0, =outputName
    BL printf
    
    LDR r1, =avg
    LDR r0, [r1]
    BL gradeProgram
     
    # Call findMaxOfThree
    # Prompt and scan for the three numbers
    LDR r0, =promptMax1
    BL printf
    LDR r0, =formatMax
    LDR r1, =max1
    BL scanf

    LDR r0, =promptMax2
    BL printf
    LDR r0, =formatMax
    LDR r1, =max2
    BL scanf

    LDR r0, =promptMax3
    BL printf
    LDR r0, =formatMax
    LDR r1, =max3
    BL scanf

    # Call findMaxOfThree
    LDR r1, =max1
    LDR r0, [r1]
    LDR r1, =max2
    LDR r3, [r1]
    LDR r1, =max3
    LDR r2, [r1]
    MOV r1, r3
    BL findMaxOfThree
   
    #push stack
    LDR lr, [sp]
    ADD sp, sp, #4
    MOV pc, lr

.data
promptAlpha: .asciz "Enter a letter or number: "
formatAlpha: .asciz " %c"
outputAlpha: .asciz "The input is a letter!\n"
outputNum: .asciz "The input is a number!\n"
alpha: .byte 0

promptName: .asciz "What is the student's name?: "
formatName: .asciz "%s"
outputName: .asciz "Student: %s\n"
name: .space 100
nameBuffer: .space 100
nameBufferSize: .word 100
promptAvg: .asciz "Enter a grade average: "
formatAvg: .asciz "%d"
avg: .word 0

promptMax1: .asciz "Enter the first number: "
promptMax2: .asciz "Enter the second number: "
promptMax3: .asciz "Enter the third number: "
formatMax: .asciz "%d"
max1: .word 0
max2: .word 0
max3: .word 0

